using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using ScintillaNet.Configuration;
using ScintillaNet;
using PluginCore.Managers;
using PluginCore.Controls;
using PluginCore;
using PluginCore.Utilities;

namespace CssCompletion
{
    public class Completion
    {
        Regex reNavPrefix = new Regex("\\-[a-z]+\\-(.*)", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        Settings settings;
        Language lang;
        string wordChars;
        List<ICompletionListItem> properties;
        List<ICompletionListItem> pseudos;
        List<ICompletionListItem> prefixes;
        Dictionary<string, string[]> values;
        string[] tags;
        bool enabled;
        CssFeatures features;
        int lastColonInsert;

        public Completion(PluginCore.Helpers.SimpleIni config, Settings settings)
        {
            this.settings = settings;
            lang = ScintillaControl.Configuration.GetLanguage("css");
            InitProperties(GetSection(config, "Properties"));
            InitLists(GetSection(config, "Lists"));
        }

        internal void OnFileChanged(CssFeatures features)
        {
            this.features = features;
            enabled = features != null;
            if (enabled)
            {
                wordChars = lang.characterclass.Characters;
                if (features.Mode != CssMode.CSS) wordChars += features.Trigger;
            }
        }

        internal void OnCharAdded(ScintillaControl sci, int position, int value)
        {
            if (!enabled) return;
            char c = (char)value;
            if (wordChars.IndexOf(c) < 0)
            {
                if (c == ':')
                {
                    if (lastColonInsert == position - 1)
                    {
                        sci.DeleteBack();
                        lastColonInsert = -1;
                        return;
                    }
                }
                else if (c == ';')
                {
                    char c2 = (char)sci.CharAt(position);
                    if (c2 == ';')
                    {
                        sci.DeleteBack();
                        sci.SetSel(position, position);
                        return;
                    }
                }
                else if (c == '\n' && !settings.DisableAutoCloseBraces)
                {
                    int line = sci.LineFromPosition(position);
                    string text = sci.GetLine(line - 1).TrimEnd();
                    if (text.EndsWith("{")) AutoCloseBrace(sci, line);
                }
                else return;
            }

            var context = GetContext(sci, position);
            if (context.InBlock)
            {
                if (context.Word == "-") HandlePrefixCompletion(context, true);
                else if (context.Word.Length >= 2 || (char)value == '-')
                    HandlePropertyCompletion(context, true);
            }
            else if (context.InValue)
            {
                if (features.Mode != CssMode.CSS && c == features.Trigger)
                    HandleVariableCompletion(context, true);
                else if (context.Word.Length == 1 && "abcdefghijklmnopqrstuvwxyz".IndexOf(context.Word[0]) >= 0)
                    HandleValueCompletion(context, true);
            }
            else if (c == ':') HandlePseudoCompletion(context, true);
        }

        internal void OnTextChanged(ScintillaControl sender, int position, int length, int linesAdded)
        {
        }

        internal void OnComplete(ScintillaControl sci, int position)
        {
            if (!enabled) return;
            var context = GetContext(sci, position);
            if (context.InBlock) HandlePropertyCompletion(context, false);
            else if (context.InValue)
            {
                if (context.Word.Length > 0 && context.Word[0] == features.Trigger)
                    HandleVariableCompletion(context, true);
                else 
                    HandleValueCompletion(context, false);
            }
            else if (context.Separator == ':') HandlePseudoCompletion(context, false);
        }

        internal void OnInsert(ScintillaControl sci, int position, string text, char trigger, ICompletionListItem item)
        {
            if (!(item is CompletionItem)) return;
            CompletionItem it = item as CompletionItem;
            if (trigger == ':')
            {
                lastColonInsert = position + text.Length + 1;
            }
            else if (it.Kind == ItemKind.Property && !settings.DisableInsertColon)
            {
                int pos = position + text.Length;
                char c = (char)sci.CharAt(pos);
                if (c != ':') sci.InsertText(pos, ":");
                sci.SetSel(pos + 1, pos + 1);
                lastColonInsert = pos + 1;
            }
            else lastColonInsert = -1;
        }

        #region parsing

        private LocalContext GetContext(ScintillaControl sci, int position)
        {
            var ctx = new LocalContext(sci);
            int i = position - 1;
            int style = sci.StyleAt(i-1);
            if (style == 9) // inside comments
                return ctx;

            int inString = 0;
            if (style == 14) inString = 1;
            if (style == 13) inString = 2;

            bool inWord = true;
            bool inComment = false;
            bool inPar = false;
            string word = "";
            int lastCharPos = i;

            while (i > 1)
            {
                char c = (char)sci.CharAt(i--);

                if (wordChars.IndexOf(c) >= 0)
                {
                    lastCharPos = i + 1;
                    if (inWord) word = c + word;
                }
                else inWord = false;

                if (inString > 0)
                {
                    if (inString == 1 && c == '\'') inString = 0;
                    else if (inString == 2 && c == '"') inString = 0;
                    continue;
                }
                if (inComment)
                {
                    if (c == '*' && i > 0 && (char)sci.CharAt(i) == '/') inComment = false;
                    continue;
                }
                if (c == '/' && i > 0 && (char)sci.CharAt(i) == '*') // entering comment
                    inComment = true;
                if (c == '\'') inString = 1; // entering line
                else if (c == '"') inString = 2;

                else if (c == ')') inPar = true;
                else if (inPar)
                {
                    if (c == '(') inPar = false;
                    continue;
                }

                else if (c == ':')
                {
                    ctx.Separator = c;
                    ctx.Position = lastCharPos;
                    string attr = ReadAttribute(sci, i);
                    if (attr.Length > 1 && !IsTag(attr) && attr[0] != features.Trigger && !IsVarDecl(sci, i))
                    {
                        ctx.InValue = true;
                        ctx.Property = attr;
                    }
                    break;
                }
                else if (c == ';' || c == '{')
                {
                    ctx.Separator = c;
                    ctx.Position = lastCharPos;
                    ctx.InBlock = !IsVarDecl(sci, i);
                    break;
                }
                else if (c == '}' || c == ',' || c == '.' || c == '#')
                {
                    ctx.Separator = c;
                    ctx.Position = lastCharPos;
                    break;
                }
                else if (c == '(')
                {
                    string tok = ReadWordLeft(sci, i);
                    if (tok == "url")
                    {
                        ctx.Separator = '(';
                        ctx.InUrl = true;
                        ctx.Position = i + 1;
                        word = "";
                        for (int j = i + 2; j < position; j++)
                            word += (char)sci.CharAt(j);
                        break;
                    }
                }
            }
            if (word.Length > 0)
            {
                if (word[0] == '-')
                {
                    Match m = reNavPrefix.Match(word);
                    if (m.Success) word = m.Groups[1].Value;
                }
            }
            ctx.Word = word;
            return ctx;
        }

        private bool IsVarDecl(ScintillaControl sci, int i)
        {
            if (features.Pattern == null) return false;
            int line = sci.LineFromPosition(i);
            string text = sci.GetLine(line);
            return features.Pattern.IsMatch(text);
        }

        private bool IsTag(string word)
        {
            return Array.IndexOf<string>(tags, word) >= 0;
        }

        private string ReadWordLeft(ScintillaControl sci, int i)
        {
            bool inWord = false;
            string word = "";

            while (i > 1)
            {
                char c = (char)sci.CharAt(i--);

                if (wordChars.IndexOf(c) >= 0)
                {
                    inWord = true;
                    word = c + word;
                }
                else if (inWord) break;
            }
            return word;
        }

        private string ReadAttribute(ScintillaControl sci, int i)
        {
            bool inWord = false;
            string word = "";

            while (i > 1)
            {
                char c = (char)sci.CharAt(i--);

                if (wordChars.IndexOf(c) >= 0)
                {
                    inWord = true;
                    word = c + word;
                }
                else if (c > 32) return "";
                else if (inWord) break;
            }
            if (word.Length > 0 && word[0] == '-')
            {
                Match m = reNavPrefix.Match(word);
                if (m.Success) word = m.Groups[1].Value;
            }
            return word;
        }

        private CssBlock FindBlock(ScintillaControl sci, bool parseIfDirty, int line, int col)
        {
            List<CssBlock> blocks = ParseBlocks(sci);
            return LookupBlock(blocks, null, line, col);
        }

        private CssBlock LookupBlock(List<CssBlock> blocks, CssBlock parent, int line, int col)
        {
            foreach (CssBlock block in blocks)
            {
                if (CursorInBlock(block, line, col))
                    return LookupBlock(block.Children, block, line, col);
            }
            return parent;
        }

        private bool CursorInBlock(CssBlock block, int line, int col)
        {
            if (line < block.LineFrom || line > block.LineTo) return false;
            if (line == block.LineFrom && col <= block.ColFrom) return false;
            if (line == block.LineTo && col > block.ColTo) return false;
            return true;
        }

        private List<CssBlock> ParseBlocks(ScintillaControl sci)
        {
            List<CssBlock> blocks = new List<CssBlock>();
            blocks.Clear();
            int lines = sci.LineCount;
            int inString = 0;
            bool inComment = false;
            CssBlock block = null;
            for (int i = 0; i < lines; i++)
            {
                string line = sci.GetLine(i);
                int len = line.Length;
                int safeLen = len - 1;
                for (int j = 0; j < len; j++)
                {
                    char c = line[j];
                    if (inComment)
                    {
                        if (c == '*' && j < safeLen && line[j + 1] == '/') inComment = false;
                        else continue;
                    }
                    else if (inString > 0)
                    {
                        if (inString == 1 && c == '\'') inString = 0;
                        else if (inString == 2 && c == '"') inString = 0;
                        else continue;
                    }
                    else if (c == '\'') inString = 1;
                    else if (c == '"') inString = 2;
                    else if (c == '/' && j < safeLen && line[j + 1] == '/')
                        break;
                    else if (c == '/' && j < safeLen && line[j + 1] == '*')
                        inComment = true;
                    else if (c == '{')
                    {
                        CssBlock parent = block;
                        block = new CssBlock();
                        block.LineFrom = i;
                        block.ColFrom = j;
                        if (parent != null)
                        {
                            block.Parent = parent;
                            parent.Children.Add(block);
                        }
                        else blocks.Add(block);
                    }
                    else if (c == '}')
                    {
                        if (block != null)
                        {
                            block.LineTo = i;
                            block.ColTo = j;
                            block = block.Parent;
                            if (block != null)
                            {
                                block.LineTo = i;
                                block.ColTo = j;
                            }
                        }
                    }
                }
            }
            return blocks;
        }

        #endregion

        #region completion

        private void HandlePrefixCompletion(LocalContext context, bool autoHide)
        {
            CompletionList.Show(prefixes, autoHide, context.Word);
        }

        private void HandlePseudoCompletion(LocalContext context, bool autoHide)
        {
            CompletionList.Show(pseudos, autoHide, context.Word);
        }

        private void HandleValueCompletion(LocalContext context, bool autoHide)
        {
            var items = new List<ICompletionListItem>();
            AddProperties(items, context.Property);
            if (items.Count > 0)
            {
                items.Add(new CompletionItem("inherit", ItemKind.Value));
                CompletionList.Show(items, autoHide, context.Word);
            }
        }

        private void HandleVariableCompletion(LocalContext context, bool autoHide)
        {
            MatchCollection matches = features.Pattern.Matches(context.Sci.Text);
            if (matches.Count == 0) return;
            var tokens = new List<string>();
            foreach (Match m in matches)
                tokens.Add(m.Groups[1].Value);
            tokens.Sort();

            var items = new List<ICompletionListItem>();
            string prev = null;
            foreach (string token in tokens)
                if (token != prev)
                {
                    items.Add(new CompletionItem(token, ItemKind.Variable));
                    prev = token;
                }

            CompletionList.Show(items, autoHide, context.Word.Length > 0 ? context.Word.Substring(1) : "");
        }

        private void HandlePropertyCompletion(LocalContext context, bool autoHide)
        {
            CompletionList.Show(properties, autoHide, context.Word);
        }

        private void AddProperties(List<ICompletionListItem> items, string name)
        {
            if (values.ContainsKey(name))
            {
                var vals = values[name];
                foreach (string val in vals)
                {
                    if (val[0] == '<')
                    {
                        string inherit = val.Substring(1, val.Length - 2);
                        if (inherit != name)
                            AddProperties(items, inherit);
                    }
                    else items.Add(new CompletionItem(val, ItemKind.Value));
                }
            }
        }

        private void InitProperties(Dictionary<string, string> section)
        {
            properties = new List<ICompletionListItem>();
            values = new Dictionary<string, string[]>();
            foreach (var prop in section)
            {
                string[] names = prop.Key.Split(',');
                string[] vals = prop.Value.Split(' ');
                foreach (string name in names)
                {
                    properties.Add(new CompletionItem(name, ItemKind.Property));
                    values.Add(name, vals);
                }
            }
        }

        private void InitLists(Dictionary<string, string> section)
        {
            tags = Regex.Split(section["tags"], "\\s+");
            pseudos = MakeList(section["pseudo"], ItemKind.Pseudo);
            prefixes = MakeList(section["prefixes"], ItemKind.Prefixes);
        }

        private List<ICompletionListItem> MakeList(string raw, ItemKind kind)
        {
            string[] defs = Regex.Split(raw, "\\s+");
            var list = new List<ICompletionListItem>();
            foreach (string def in defs)
                list.Add(new CompletionItem(def, kind));
            return list;
        }

        private Dictionary<string, string> GetSection(PluginCore.Helpers.SimpleIni config, string name)
        {
            foreach (var def in config)
                if (def.Key == name) return def.Value;
            return null;
        }

        /// <summary>
        /// Add closing brace to a code block.
        /// If enabled, move the starting brace to a new line.
        /// </summary>
        /// <param name="Sci"></param>
        /// <param name="txt"></param>
        /// <param name="line"></param>
        public static void AutoCloseBrace(ScintillaControl Sci, int line)
        {
            // find matching brace
            int bracePos = Sci.LineEndPosition(line - 1) - 1;
            while ((bracePos > 0) && (Sci.CharAt(bracePos) != '{')) bracePos--;
            if (bracePos == 0 || Sci.BaseStyleAt(bracePos) != 5) return;
            int match = Sci.SafeBraceMatch(bracePos);
            int start = line;
            int indent = Sci.GetLineIndentation(start - 1);
            if (match > 0)
            {
                int endIndent = Sci.GetLineIndentation(Sci.LineFromPosition(match));
                if (endIndent + Sci.TabWidth > indent)
                    return;
            }

            // find where to include the closing brace
            int startIndent = indent;
            int newIndent = indent + Sci.TabWidth;
            int count = Sci.LineCount;
            int lastLine = line;
            int position;
            string txt = Sci.GetLine(line).Trim();
            line++;
            int eolMode = Sci.EOLMode;
            string NL = LineEndDetector.GetNewLineMarker(eolMode);

            if (txt.Length > 0 && ")]};,".IndexOf(txt[0]) >= 0)
            {
                Sci.BeginUndoAction();
                try
                {
                    position = Sci.CurrentPos;
                    Sci.InsertText(position, NL + "}");
                    Sci.SetLineIndentation(line, startIndent);
                }
                finally
                {
                    Sci.EndUndoAction();
                }
                return;
            }
            else
            {
                while (line < count - 1)
                {
                    txt = Sci.GetLine(line).TrimEnd();
                    if (txt.Length != 0)
                    {
                        indent = Sci.GetLineIndentation(line);
                        if (indent <= startIndent) break;
                        lastLine = line;
                    }
                    else break;
                    line++;
                }
            }
            if (line >= count - 1) lastLine = start;

            // insert closing brace
            Sci.BeginUndoAction();
            try
            {
                position = Sci.LineEndPosition(lastLine);
                Sci.InsertText(position, NL + "}");
                Sci.SetLineIndentation(lastLine + 1, startIndent);
            }
            finally
            {
                Sci.EndUndoAction();
            }
        }

        #endregion
    }
}
