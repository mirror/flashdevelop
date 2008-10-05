using System;
using System.Text;
using System.Collections.Generic;
using System.Diagnostics;

namespace PluginCore.FRService
{
    #region Search Classes And Enums

    [Flags]
    public enum SearchFilter
    {
        None=0,
        InCodeComments=1,
        OutsideCodeComments=2,
        InStringLiterals=4,
        OutsideStringLiterals=8
    }

    public class SearchMatch
    {
        public int Index;
        public int Length;
        public int Line;
        public int Column;
        public int LineStart;
        public int LineEnd;
        public string Value;
        public string LineText;
        public SearchGroup[] Groups;
    }

    public class SearchGroup
    {
        public int Index;
        public int Length;
        public int Line;
        public string Value;

        public SearchGroup(int index)
        {
            Index = index;
        }
    }

    #endregion

    public class FRSearch
    {
        #region Static Methods

        /// <summary>
        /// Make the pattern regex-safe
        /// </summary>
        /// <param name="pattern">Text to escape</param>
        /// <returns>Regex-safe text</returns>
        static public string Escape(string pattern)
        {
            string result = "";
            char c;
            int i = 0;
            while (i < pattern.Length)
            {
                c = pattern[i++];
                if (c == '\\' || c == '[' || c ==']' || c == '(' || c == ')' || c == '.' || c == '-' || c == '+' | c == '*' || c == '^' || c == '$') 
                    result += "\\";
                result += c;
            }
            return result;
        }

        /// <summary>
        /// Replace escaped characters in replacement text
        /// </summary>
        /// <param name="text">Text to unescape</param>
        static public string Unescape(string text)
        {
            return Unescape(text, null);
        }

        /// <summary>
        /// Replace escaped characters in replacement text
        /// </summary>
        /// <param name="escapedText">Text to unescape</param>
        /// <param name="match">Search result (for reinjecting sub-matches)</param>
        static public string Unescape(string text, SearchMatch match)
        {
            int p = text.IndexOf('\\');
            if (p < 0) return text;

            string result = text.Substring(0, p);
            int n = text.Length;
            for (int i = p; i < n; i++)
            {
                if (i < n - 1 && text[i] == '\\')
                {
                    i++;
                    char c = text[i];
                    if (c == 'r') result += '\r';
                    else if (c == 'n') result += '\n';
                    else if (c == 't') result += '\t';
                    else if (c == 'v') result += '\v';
                    else if (match != null && c >= '0' && c <= '9' && match.Groups.Length > int.Parse(c.ToString()))
                        result += match.Groups[int.Parse(c.ToString())].Value;
                    else result += c;
                }
                else result += text[i];
            }
            return result;
        }

        /// <summary>
        /// Update the matches indexes to take in account the pattern & replacement lengthes
        /// </summary>
        /// <param name="matches">Search results to update</param>
        /// <param name="fromMatchIndex">First result to update</param>
        /// <param name="found">Text matched</param>
        /// <param name="replacement">Text replacement</param>
        static public void PadIndexes(List<SearchMatch> matches, int fromMatchIndex, string found, string replacement)
        {
            int linesDiff = CountNewLines(replacement) - CountNewLines(found);
            int charsDiff = replacement.Length - found.Length;
            SearchMatch match;
            if (charsDiff != 0 || linesDiff != 0)
                for (int i = fromMatchIndex; i < matches.Count; i++)
                {
                    match = matches[i];
                    match.Index += charsDiff;
                    match.LineStart += charsDiff;
                    match.LineEnd += charsDiff;
                    match.Line += linesDiff;
                }
        }

        static private int CountNewLines(string src)
        {
            int lines = 0;
            char c1;
            char c2 = ' ';
            for (int i = 0; i < src.Length; i++)
            {
                c1 = src[i];
                if (c1 == '\r') lines++;
                else if (c1 == '\n' && c2 != '\r') lines++;
                c2 = c1;
            }
            return lines;
        }

        /** TODO : needs something like SearchOptions flags to be functional
        
        /// <summary>
        /// Quick search
        /// </summary>
        /// <param name="pattern">Search pattern</param>
        /// <param name="input">Source text</param>
        /// <returns>First result</returns>
        static public SearchMatch Match(string pattern, string input, SearchOptions options)
        {
            Search search = new Search(pattern);
            // eval options
            return search.Match(input);
        }

        /// <summary>
        /// Quick search
        /// </summary>
        /// <param name="pattern">Search pattern</param>
        /// <param name="input">Source text</param>
        /// <returns>All results</returns>
        static public List<SearchMatch> Matches(string pattern, string input, SearchOptions options)
        {
            Search search = new Search(pattern);
            // eval options
            return search.Matches(input);
        }

        /// <summary>
        /// Quick replace
        /// </summary>
        /// <param name="pattern">Search pattern</param>
        /// <param name="input">Source text</param>
        /// <param name="replacement">Replacement pattern</param>
        /// <returns></returns>
        static public string Replace(string pattern, string input, string replacement, SearchOptions options)
        {
            Search search = new Search(pattern);
            // eval options
            List<SearchMatch> matches = search.Matches(input);
            return search.ReplaceAll(input, replacement, matches);
        }
        */

        #endregion

        #region Public Replace Methods

        /// <summary>
        /// Replace one search result
        /// </summary>
        /// <param name="input">Source text</param>
        /// <param name="replacement">Replacement pattern</param>
        /// <param name="match">Search result to replace</param>
        /// <returns>Updated text</returns>
        public string Replace(string input, string replacement, SearchMatch match)
        {
            List<SearchMatch> matches = new List<SearchMatch>();
            matches.Add(match);
            return ReplaceOneMatch(input, replacement, matches, 0);
        }

        /// <summary>
        /// Replace one search result - updates other matches indexes accordingly
        /// </summary>
        /// <param name="input">Source text</param>
        /// <param name="replacement">Replacement pattern</param>
        /// <param name="matches">Search results</param>
        /// <param name="matchIndex">Index of the search result to replace</param>
        /// <returns>Updated text</returns>
        public string Replace(string input, string replacement, List<SearchMatch> matches, int matchIndex)
        {
            return ReplaceOneMatch(input, replacement, matches, matchIndex);
        }

        /// <summary>
        /// Replace one search result
        /// </summary>
        /// <param name="input">Source text</param>
        /// <param name="replacement">Replacement pattern</param>
        /// <param name="matches">Search results to replace</param>
        /// <returns>Updated text</returns>
        public string ReplaceAll(string input, string replacement, List<SearchMatch> matches)
        {
            return ReplaceAllMatches(input, replacement, matches);
        }

        #endregion

        #region Internal Replace Methods

        string ReplaceOneMatch(string src, string replacement, List<SearchMatch> matches, int matchIndex)
        {
            if (matches == null || matches.Count == 0) return src;
            SearchMatch match = matches[matchIndex];

            // replace text
            if (isEscaped) replacement = Unescape(replacement, match);
            src = src.Substring(0, match.Index) + replacement + src.Substring(match.Index + match.Length);

            // update next matches
            if (matches.Count > matchIndex + 1) PadIndexes(matches, matchIndex + 1, match.Value, replacement);
            return src;
        }

        string ReplaceAllMatches(string src, string replacement, List<SearchMatch> matches)
        {
            if (matches == null || matches.Count == 0) return src;
            StringBuilder sb = new StringBuilder();
            string original = replacement;
            int lastIndex = 0;

            foreach (SearchMatch match in matches)
            {
                sb.Append(src.Substring(lastIndex, match.Index - lastIndex));
                // replace text
                if (isEscaped) replacement = Unescape(replacement, match);
                sb.Append(replacement);
                lastIndex = match.Index + match.Length;
            }

            sb.Append(src.Substring(lastIndex));
            return sb.ToString();
        }
        #endregion

        #region Public Properties

        public bool IsEscaped
        {
            get { return isEscaped; }
            set
            {
                isEscaped = value;
                needParsePattern = true;
            }
        }
        public bool IsRegex
        {
            get { return isRegex; }
            set
            {
                isRegex = value;
                needParsePattern = true;
            }
        }
        public bool NoCase
        {
            get { return noCase; }
            set
            {
                noCase = value;
                needParsePattern = true;
            }
        }
        public bool WholeWord
        {
            get { return wholeWord; }
            set
            {
                wholeWord = value;
                needParsePattern = true;
            }
        }
        public bool SingleLine
        {
            get { return singleLine; }
            set
            {
                singleLine = value;
            }
        }
        public SearchFilter Filter
        {
            get { return filter; }
            set
            {
                filter = value;
            }
        }
        public string Pattern
        {
            get { return pattern; }
            set
            {
                pattern = value;
                needParsePattern = true;
            }
        }
        #endregion

        #region Public Search Methods

        /// <summary>
        /// Create a seach engine
        /// </summary>
        /// <param name="pattern">Search pattern</param>
        public FRSearch(string pattern)
        {
            this.pattern = pattern;
        }

        /// <summary>
        /// Find a match
        /// </summary>
        /// <param name="input">Source text</param>
        /// <returns>Search result</returns>
        public SearchMatch Match(string input)
        {
            return Match(input, 0, 1);
        }

        /// <summary>
        /// Find a match - both startIndex & startLine must be defined
        /// </summary>
        /// <param name="input">Source text</param>
        /// <param name="startIndex">Character offset</param>
        /// <param name="startLine">Line offset</param>
        /// <returns>Search result</returns>
        public SearchMatch Match(string input, int startIndex, int startLine)
        {
            returnAllMatches = false;
            List<SearchMatch> res = SearchSource(input, startIndex, startLine);
            if (res.Count > 0) return res[0];
            else return null;
        }

        /// <summary>
        /// Find all matches
        /// </summary>
        /// <param name="input">Source text</param>
        /// <returns>Search results</returns>
        public List<SearchMatch> Matches(string input)
        {
            return Matches(input, 0, 1);
        }

        /// <summary>
        /// Find all matches - both startIndex & startLine must be defined
        /// </summary>
        /// <param name="input">Source text</param>
        /// <param name="startIndex">Character offset</param>
        /// <param name="startLine">Line offset</param>
        /// <returns>Search results</returns>
        public List<SearchMatch> Matches(string input, int startIndex, int startLine)
        {
            returnAllMatches = true;
            return SearchSource(input, startIndex, startLine);
        }
        #endregion

        #region Internal Parser Configuration

        bool needParsePattern = true;
        SearchToken[] search;
        int groupCount;
        List<int> groupStarts;
        List<int> groupEnds;
        string pattern;
        bool noCase;
        bool wholeWord;
        bool isRegex;
        bool isEscaped;
        bool singleLine;
        bool returnAllMatches;
        SearchFilter filter;

        const char CHAR_TO = (char)14;
        const char CHAR_DIGIT = (char)15;
        const char CHAR_NONDIGIT = (char)16;
        const char CHAR_SPACE = (char)17;
        const char CHAR_NONSPACE = (char)18;
        const char CHAR_WORD = (char)19;
        const char CHAR_NONWORD = (char)20;
        const char CHAR_BACKREFERENCE = (char)21;
        #endregion

        #region Internal Search Methods

        private List<SearchMatch> SearchSource(string src, int startIndex, int startLine)
        {
            // intialize search tokens
            if (needParsePattern) BuildSearchTokens(pattern);
            else
            {
                foreach (SearchToken tokClean in search)
                {
                    if (tokClean.type == SearchType.BackReference) tokClean.chars = null;
                }
            }
            ////Debug.WriteLine(src);
            //Debug.WriteLine("Filter: " + filter);

            // source seek
            int len = src.Length;
            long backtrackLimit = len * 10;
            int pos = startIndex;
            int line = startLine;
            List<int> lineStart = new List<int>();
            for(int i=0; i<startLine; i++) lineStart.Add(0);
            char c;
            // matching 
            List<SearchMatch> results = new List<SearchMatch>();
            SearchMatch match;
            int tok_count = search.Length;
            int tok_i = 0;
            SearchToken token = (SearchToken)search[tok_i];
            bool nextToken = false;
            bool noMatch = false;
            bool hadWS = true;
            bool hasLD = false;
            bool hadNL = false;
            // filter
            bool inComments = (filter & SearchFilter.InCodeComments) > 0;
            bool outComments = (filter & SearchFilter.OutsideCodeComments) > 0;
            bool filterComments = inComments || outComments;
            int commentMatch = 0;
            bool inLiterals = (filter & SearchFilter.InStringLiterals) > 0;
            bool outLiterals = (filter & SearchFilter.OutsideStringLiterals) > 0;
            bool filterLiterals = inLiterals || outLiterals;
            int literalMatch = 0;

            // comparison mode
            StringComparison compType = (noCase) ? StringComparison.CurrentCultureIgnoreCase : StringComparison.CurrentCulture;
            
            // fast first lookup
            if (token.type == SearchType.Text)
            {
                int p = src.IndexOf(new string(token.chars), compType);
                if (p < 0) return results;
            }

            while (pos < len)
            {
                c = src[pos++];

                //// LINE NUMBER /// </summary>
                hadNL = false;
                if (c == '\n')
                {
                    line++;
                    hadNL = true;
                }
                else if (c == '\r')
                {
                    if (pos < len && src[pos] != '\n')
                    {
                        line++;
                        hadNL = true;
                    }
                }
                if (hadNL)
                {
                    if (lineStart.Count >= line) lineStart[line-1] = pos;
                    else lineStart.Add(pos);
                }

                //// FILTERS
                if (filterComments)
                {
                    if (commentMatch == 0)
                    {
                        if (c == '/' && pos < len)
                            if (src[pos] == '*') commentMatch = 1;
                            else if (src[pos] == '/') commentMatch = 2;
                    }
                    else if (commentMatch == 1)
                    {
                        if (c == '*' && src[pos] == '/') commentMatch = 0;
                    }
                    else if (commentMatch == 2)
                    {
                        if (hadNL) commentMatch = 0;
                    }
                    if ((inComments && commentMatch == 0)
                        || (outComments && commentMatch > 0)) continue;
                }
                else if (filterLiterals)
                {
                    if (literalMatch == 0)
                    {
                        if (c == '"') literalMatch = 1;
                        else if (c == '\'') literalMatch = 2;
                    }
                    else if (pos > 1)
                    if (literalMatch == 1)
                    {
                        if (src[pos-2] != '\\' && c == '"') literalMatch = 0;
                    }
                    else if (literalMatch == 2)
                    {
                        if (src[pos - 2] != '\\' && c == '\'') literalMatch = 0;
                    }
                    if ((inLiterals && literalMatch == 0)
                        || (outLiterals && literalMatch > 0)) continue;
                }

                //// WHOLE WORDS
                if (wholeWord && tok_i == 0 && token.matched == 0 && token.tpos == 0)
                {
                    hasLD = c == '_' || c == '$' || Char.IsLetterOrDigit(c);
                    if (!hadWS && hasLD) continue;
                    hadWS = !hasLD;
                }

                //// MATCHING
                if (token.matched == 0 && token.tpos == 0)
                {
                    token.line = line;
                    token.lineStart = lineStart[line-1];
                    token.index = pos - 1;
                }

                //Debug.Write(c);
                ////Debug.Write("["+new string(token.chars)+"]");
                switch (token.type)
                {
                    // match text
                    case SearchType.Text:
                        if (String.Compare(c.ToString(), token.chars[token.tpos].ToString(), compType) == 0)
                        {
                            token.tpos++;
                            if (token.tpos == token.len)
                            {
                                token.matched++;
                                token.tpos = 0;
                                if (token.isGreed || token.matched == token.maxRepeat) nextToken = true;
                            }
                        }
                        else
                        {
                            if (tok_i == 0 && token.tpos == 0) continue;
                            noMatch = true;
                        }
                        break;

                    // match in collection
                    case SearchType.CharIn:
                        if (CollectionMatch(c, token.chars, token.len) == token.len)
                        {
                            noMatch = true;
                        }
                        else
                        {
                            token.matched++;
                            if (token.isGreed || token.matched == token.maxRepeat) nextToken = true;
                        }
                        break;

                    // match NOT in collection
                    case SearchType.CharNotIn:
                        if (CollectionMatch(c, token.chars, token.len) < token.len)
                        {
                            noMatch = true;
                        }
                        else
                        {
                            token.matched++;
                            if (token.isGreed || token.matched == token.maxRepeat) nextToken = true;
                        }
                        break;

                    // match any char
                    case SearchType.AnyChar:
                        //Debug.Write(".");
                        if (singleLine || (c != '\r' && c != '\n'))
                        {
                            token.matched++;
                            if (token.isGreed || token.matched == token.maxRepeat) nextToken = true;
                        }
                        else noMatch = true;
                        break;

                    // match a previously matched group
                    case SearchType.BackReference:
                        if (token.chars == null)
                        {
                            SearchToken temp;
                            int tempIndex = 0;
                            for (int i = 0; i < tok_i; i++)
                            {
                                temp = search[i];
                                if (groupStarts[token.backReferenceIndex] == i)
                                {
                                    tempIndex = temp.index;
                                }
                                if (groupEnds[token.backReferenceIndex] == i)
                                {
                                    token.chars = src.Substring(tempIndex, temp.getLength()).ToCharArray();
                                    token.len = token.chars.Length;
                                    //Debug.Write("\\" + token.index + "=" + new string(token.chars));
                                    break;
                                }
                            }
                        }
                        if (c == token.chars[token.tpos])
                        {
                            token.tpos++;
                            if (token.tpos == token.len)
                            {
                                token.matched++;
                                token.tpos = 0;
                                if (token.isGreed || token.matched == token.maxRepeat) nextToken = true;
                            }
                        }
                        else noMatch = true;
                        break;
                }

                // end of source reached, but still search tokens to match
                if (pos == len && tok_i < tok_count - 1)
                {
                    // force to got to next search token?
                    for (int i = tok_i + 1; i < tok_count; i++)
                        if (search[i].minRepeat != 0)
                        {
                            //Debug.Write("BACK");
                            noMatch = true;
                            break;
                        }
                }

            matchCancelled:
                // search token NOT matched
                if (noMatch)
                {
                    if (--backtrackLimit == 0)
                    {
                        throw new Exception("Regex engine infinite loop detected.");
                    }
                    noMatch = false;

                    // stopping multiple matching
                    if (token.matched >= token.minRepeat && !token.backtrack)
                    {
                        //Debug.Write(".");
                        pos = token.index + token.getLength();
                        nextToken = true;
                    }
                    else
                    {
                        // search backtracking
                        while (tok_i > 0)
                        {
                            token = search[tok_i - 1];
                            // revert whildcard
                            if (!token.isGreed)
                            {
                                if (token.matched > token.minRepeat)
                                {
                                    //Debug.Write("-");
                                    token.matched--;
                                    token.backtrack = true;
                                    pos = token.index + token.getLength();
                                    break;
                                }
                                else if (!token.backtrack)
                                {
                                    //Debug.Write("<");
                                    token.backtrack = true;
                                    pos = token.index + token.getLength();
                                    tok_i--;
                                    break;
                                }
                            }
                            // continue "greedy" match
                            else if (token.matched < token.maxRepeat)
                            {
                                //Debug.Write(">");
                                pos = token.index + token.getLength();
                                token.backtrack = true;
                                tok_i--;
                                break;
                            }
                            tok_i--;
                            //Debug.Write("-" + tok_i);
                        }
                        token = search[tok_i];
                        // reset search
                        if (tok_i == 0)
                        {
                            //Debug.WriteIf(token.matched > 0, "<<\n");
                            pos = token.index + 1;
                            token.matched = 0;
                            token.tpos = 0;
                            token.backtrack = false;
                        }
                        // fix line number
                        while (pos < lineStart[lineStart.Count - 1])
                        {
                            lineStart.RemoveAt(lineStart.Count - 1);
                            line = lineStart.Count;
                        }
                    }
                }

                // search token matched
                if (nextToken)
                {
                    //Debug.Write('!');
                    nextToken = false;

                    // next token
                    while (++tok_i < tok_count)
                    {
                        token = search[tok_i];
                        token.matched = 0;
                        token.tpos = 0;
                        token.backtrack = false;
                        if (token.isGreed && token.minRepeat == 0) token.index = pos - 1;
                        else break;
                    }
                    // matched the whole search pattern?
                    if (tok_i == tok_count)
                    {
                        // whole word check
                        if (wholeWord && pos < len)
                        {
                            char c2 = src[pos];
                            if (c2 == '_' || c2 == '$' || char.IsLetterOrDigit(c2))
                            {
                                //Debug.WriteLine("!W!");
                                noMatch = true;
                                tok_i--;
                                token = search[tok_i];
                                token.matched--;
                                goto matchCancelled;
                            }
                        }

                        //Debug.Write("$$MATCHED " + token.index + ",");
                        SearchGroup[] groups = new SearchGroup[groupCount + 1];
                        SearchGroup group;
                        int index = search[0].index;
                        int length = 0;
                        int tokLength;
                        groups[0] = new SearchGroup(index);

                        for (int i = 0; i < tok_count; i++)
                        {
                            token = search[i];
                            tokLength = token.getLength();
                            for (int gi = 0; gi <= groupCount; gi++)
                            {
                                if (groupStarts[gi] == i)
                                {
                                    //Debug.Write("\n?" + gi);
                                    groups[gi] = new SearchGroup(index + length);
                                }
                                if (groupEnds[gi] == i)
                                {
                                    group = groups[gi];
                                    //Debug.Write("\n$" + gi);
                                    group.Length = index + length + tokLength - group.Index;
                                    group.Value = src.Substring(group.Index, group.Length);
                                    //Debug.Write("='" + group.Value + "'");
                                }
                            }
                            //Debug.Write("+" + tokLength);
                            //Debug.Write("(" + (index + length) + "/" + token.index + ")");
                            length += tokLength;
                            // clear backreferences
                            if (token.type == SearchType.BackReference) token.chars = null;
                        }
                        groups[0].Length = length;

                        // store result
                        match = new SearchMatch();
                        match.Index = index;
                        match.Length = groups[0].Length;
                        match.Value = groups[0].Value;
                        match.Groups = groups;
                        match.Line = line;
                        match.LineStart = search[0].lineStart;
                        match.Column = match.Index - match.LineStart;
                        //
                        int le;
                        for (le = pos-1; le < len; le++)
                            if (src[le] == '\r' || src[le] == '\n')
                                break;
                        match.LineEnd = le;
                        if (match.LineEnd > match.LineStart && match.LineEnd < src.Length)
                            match.LineText = src.Substring(match.LineStart, match.LineEnd - match.LineStart);
                        else match.LineText = match.Value;
                        //
                        results.Add(match);
                        if (!returnAllMatches) return results;

                        // reset search
                        //Debug.Write(length + " $$");
                        tok_i = 0;
                        token = search[0];
                        token.matched = 0;
                        token.tpos = 0;
                        token.backtrack = false;
                    }
                }
            }
            return results;
        }

        static bool SpecialMatch(char c, char special)
        {
            switch (special)
            {
                case CHAR_DIGIT:
                    if (char.IsDigit(c)) return true;
                    break;
                case CHAR_NONDIGIT:
                    if (!char.IsDigit(c)) return true;
                    break;
                case CHAR_SPACE:
                    if (char.IsWhiteSpace(c)) return true;
                    break;
                case CHAR_NONSPACE:
                    if (!char.IsWhiteSpace(c)) return true;
                    break;
                case CHAR_WORD:
                    if (char.IsLetter(c)) return true; ;
                    break;
                case CHAR_NONWORD:
                    if (!char.IsLetter(c)) return true;
                    break;
            }
            return false;
        }

        static int CollectionMatch(char c, char[] chars, int len)
        {
            char c2;
            for (int i = 0; i < len; i++)
            {
                c2 = chars[i];
                if (c2 == CHAR_TO)
                {
                    if (c > chars[i - 1] && c <= chars[i + 1]) return i;
                    else i++;
                }
                else if (c2 > CHAR_TO && c2 <= CHAR_NONWORD)
                {
                    if (SpecialMatch(c, c2)) return i;
                }
                else if (c == c2) return i;
            }
            return len;
        }
        #endregion

        #region Internal Pattern Parsing

        void BuildSearchTokens(string pattern)
        {
            List<SearchToken> tokens = new List<SearchToken>();

            int i = 0;
            int len = Math.Min(pattern.Length, 1023);
            char c;
            bool escaped = false;

            char[] buffer = new char[1024];
            int bi = 0;

            bool inGroup = false;
            bool setInGroup = false;
            List<int> groups = new List<int>();
            groupCount = 0;
            groupStarts = new List<int>();
            groupEnds = new List<int>();
            groupStarts.Add(0);
            groupEnds.Add(0);

            bool ignoreToken = false;
            bool inText = true;
            bool setInText = true;
            bool addToken = false;
            int setMinRepeat = 1;
            int setMaxRepeat = 1;
            bool setGreed = false;
            SearchToken lastToken = null;

            while (i < len)
            {
                c = pattern[i++];
                ////Debug.Write(c);

                //// CHARACTER ESCAPING /// </summary>

                if (isEscaped && c == '\\' && i < len)
                {
                    c = pattern[i++];
                    escaped = true;
                    switch (c)
                    {
                        case '0': c = (char)0; break;
                        case 'n': c = '\n'; break;
                        case 'r': c = '\r'; break;
                        case 't': c = '\t'; break;
                        case 'b': c = '\b'; break;
                        case 'v': c = '\v'; break;
                        case 'f': c = '\f'; break;
                        // TODO  Ctrl+? char 'cX'
                        // TODO  UNICODE char 'uXXXX'
                        // TODO  HEXA char 'hXX'
                        default: escaped = false; break;
                    }
                    if (!escaped && isRegex)// && !inText)
                    {
                        escaped = true;
                        switch (c)
                        {
                            case 'd': c = (char)CHAR_DIGIT; break;
                            case 'D': c = (char)CHAR_NONDIGIT; break;
                            case 's': c = (char)CHAR_SPACE; break;
                            case 'S': c = (char)CHAR_NONSPACE; break;
                            case 'w': c = (char)CHAR_WORD; break;
                            case 'W': c = (char)CHAR_NONWORD; break;
                            // TODO  Word boundaries /b /B

                            case '1': // backreferences
                            case '2':
                            case '3':
                            case '4':
                            case '5':
                            case '6':
                            case '7':
                            case '8':
                            case '9':
                                if (bi > 0)
                                {
                                    i--;
                                    addToken = true;
                                }
                                else
                                {
                                    addToken = false;
                                    lastToken = new SearchToken(SearchType.BackReference);
                                    lastToken.backReferenceIndex = int.Parse(c.ToString());
                                    tokens.Add(lastToken);
                                    bi++;
                                    ignoreToken = true;
                                }
                                break;
                            default: escaped = false; break;
                        }
                    }
                }

                //// REGEX TOKENS /// </summary>

                if (!escaped && isRegex)
                {
                    switch (c)
                    {
                        //// GROUPS /// </summary>
                        case '(':
                            if (inText)
                            {
                                addToken = true;
                                setInGroup = true;
                            }
                            break;
                        case ')':
                            if (groups.Count > 0 && inText)
                            {
                                addToken = true;
                                int index = (bi == 0) ? tokens.Count - 1 : tokens.Count;
                                groupEnds[groups[groups.Count - 1]] = index;
                                //Debug.WriteLine("--" + groups[groups.Count - 1] + " " + index);
                                groups.RemoveAt(groups.Count - 1);
                            }
                            break;

                        //// CHAR COLLECTION /// </summary>
                        case '[':
                            if (i < len && pattern[i] != ']')
                            {
                                addToken = true;
                                setInText = false;
                            }
                            break;
                        case ']':
                            if (!inText)
                            {
                                addToken = true;
                                setInText = true;
                            }
                            break;
                        case '.':
                            if (inText)
                            {
                                if (bi > 0)
                                {
                                    i--;
                                    addToken = true;
                                }
                                else
                                {
                                    addToken = false;
                                    lastToken = new SearchToken(SearchType.AnyChar);
                                    tokens.Add(lastToken);
                                    bi++;
                                    ignoreToken = true;
                                }
                                break;
                            }
                            break;
                        case '-':
                            if (!inText && bi > 0 && i < len)
                            {
                                int charFrom = (int)buffer[bi - 1];
                                c = pattern[i++];
                                int charTo = (int)c;
                                if (c == ']' || charTo < charFrom)
                                {
                                    c = '-';
                                    i--;
                                    break;
                                }
                                buffer[bi++] = (char)CHAR_TO;
                            }
                            break;
                    }

                    if (i < len)
                    {
                        char c2 = pattern[i];
                        bool foundModifier = false;
                        switch (c2)
                        {
                            case '+':
                                setMaxRepeat = int.MaxValue;
                                foundModifier = true;
                                break;
                            case '-':
                                if (inText || setInText)
                                {
                                    setMinRepeat = 0;
                                    setMaxRepeat = int.MaxValue;
                                    setGreed = true;
                                    foundModifier = true;
                                }
                                break;
                            case '*':
                                setMinRepeat = 0;
                                setMaxRepeat = int.MaxValue;
                                foundModifier = true;
                                break;
                            case '?':
                                setMinRepeat = 0;
                                setMaxRepeat = 1;
                                foundModifier = true;
                                break;
                        }
                        // if in text:
                        // - remove last char added,
                        // - make it a simple text match
                        // - next char will get the modifiers
                        if (foundModifier)
                        {
                            if (ignoreToken)
                            {
                                lastToken.minRepeat = setMinRepeat;
                                lastToken.maxRepeat = setMaxRepeat;
                                lastToken.isGreed = setGreed;
                            }
                            else if (inText && !addToken)
                            {
                                addToken = true;
                                if (bi > 0)
                                {
                                    i -= 2;
                                    setMinRepeat = 1;
                                    setMaxRepeat = 1;
                                    setGreed = false;
                                }
                                else buffer[bi++] = c;
                            }
                            i++;
                        }
                    }
                }
                else escaped = false;

                if (ignoreToken)
                {
                    ignoreToken = false;
                    bi = 0;
                    inText = true;
                    setMinRepeat = 1;
                    setMaxRepeat = 1;
                    setGreed = false;
                }
                else if (addToken)
                {
                    addToken = false;
                    if (bi > 0)
                    {
                        lastToken = new SearchToken(inText, new String(buffer, 0, bi));
                        lastToken.minRepeat = setMinRepeat;
                        lastToken.maxRepeat = setMaxRepeat;
                        lastToken.isGreed = setGreed;
                        tokens.Add(lastToken);
                        bi = 0;
                    }
                    inText = setInText;
                    inGroup = setInGroup;
                    if (setInGroup)
                    {
                        setInGroup = false;
                        groupCount++;
                        groups.Add(groupCount);
                        groupStarts.Add(tokens.Count);
                        groupEnds.Add(tokens.Count);
                        //Debug.WriteLine("++" + groups[groups.Count - 1] + " " + tokens.Count);
                    }
                    setMinRepeat = 1;
                    setMaxRepeat = 1;
                    setGreed = false;
                }
                else buffer[bi++] = c;
            }

            if (bi > 0)
            {
                lastToken = new SearchToken(inText, new String(buffer, 0, bi));
                lastToken.minRepeat = setMinRepeat;
                lastToken.maxRepeat = setMaxRepeat;
                lastToken.isGreed = setGreed;
                tokens.Add(lastToken);
            }
            groupEnds[0] = tokens.Count - 1;
            for (i = 0; i < groupCount + 1; i++)
            {
                //Debug.WriteLine("group " + i + ": " + groupStarts[i] + "/" + groupEnds[i]);
            }
            // only one token, is must match one char at least
            if (tokens.Count == 1 && lastToken.minRepeat == 0)
            {
                lastToken.minRepeat = 1;
            }

            // make SearchToken array
            search = new SearchToken[tokens.Count];
            for (i = 0; i < tokens.Count; i++)
            {
                search[i] = (SearchToken)tokens[i];
                //Debug.WriteLine(search[i].ToString());
            }
        }
        #endregion

        #region Internal Structures

        enum SearchType
        {
            Text,
            CharIn,
            CharNotIn,
            AnyChar,
            BackReference,
            LineStart,
            LineEnd
        }
        class SearchToken
        {
            public SearchType type;
            public int len;
            public char[] chars;
            public int minRepeat = 1;
            public int maxRepeat = 1;
            public bool isGreed;

            public int matched;
            public bool backtrack;
            public int tpos;
            public int line;
            public int lineStart;
            public int index;
            public int backReferenceIndex;

            public SearchToken(SearchType type)
            {
                this.type = type;
            }
            public SearchToken(bool isText, string token)
            {
                if (isText) type = SearchType.Text;
                else if (token.Length > 1 && token[0] == '^') type = SearchType.CharNotIn;
                else type = SearchType.CharIn;
                //
                len = token.Length;
                chars = token.ToCharArray();
            }

            public int getLength()
            {
                return (type == SearchType.Text | type == SearchType.BackReference) ? len * matched : matched;
            }

            public override string ToString()
            {
                return "[Token: '" + new string(chars) + "', " + type + ", " + minRepeat + "-" + maxRepeat + "]";
            }
        }
        #endregion

        /**
        static FRSearch()
        {
            TextWriterTraceListener listener = new TextWriterTraceListener(System.Console.Out);
            Debug.Listeners.Add(listener);
        }
        */
    }
}
