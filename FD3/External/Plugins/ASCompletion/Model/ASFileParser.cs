/*
 * 
 * User: Philippe Elsass
 * Date: 18/03/2006
 * Time: 19:03
 */

using System;
using System.IO;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Text.RegularExpressions;
using System.Diagnostics;
using ASCompletion.Context;
using ASCompletion.Completion;
using PluginCore.Managers;

namespace ASCompletion.Model
{
	#region Token class
	class Token
	{
		public int Position;
		public int Line;
		public string Text;

		public Token()
		{
		}

		public Token(Token copy)
		{
			Text = copy.Text;
			Line = copy.Line;
			Position = copy.Position;
		}

		override public string ToString()
		{
			return Text;
		}
	}
	#endregion
	
	/// <summary>
	/// Description of ASFileParser.
	/// </summary>
	public class ASFileParser
	{	
		#region Regular expressions
		static public RegexOptions ro_cm = RegexOptions.Compiled | RegexOptions.Multiline;
		static public RegexOptions ro_cs = RegexOptions.Compiled | RegexOptions.Singleline;
		static public Regex re_balancedBraces = new Regex("{[^{}]*(((?<Open>{)[^{}]*)+((?<Close-Open>})[^{}]*)+)*(?(Open)(?!))}", ro_cs);
        static public Regex re_import = new Regex("^[\\s]*import[\\s]+(?<package>[\\w.]+)", ro_cm);
		static private Regex re_spaces = new Regex("\\s+", RegexOptions.Compiled);
        static private Regex re_validTypeName = new Regex("^(\\s*of\\s*)?(?<type>[\\w.]*)$", RegexOptions.Compiled);
        static private Regex re_region = new Regex(@"^(#|{)[ ]?region[:\\s]*(?<name>[^\r\n]*)", RegexOptions.Compiled);
		#endregion

        #region public methods
		static private PathModel cachedPath;
		static private DateTime cacheLastWriteTime;

        static public void ParseCacheFile(PathModel inPath, string file, IASContext inContext)
		{
            lock (typeof(ASFileParser))
            {
                cachedPath = inPath;
                ParseFile(file, inContext);
                cachedPath = null;
            }
		}
		
		static public FileModel ParseFile(string file, IASContext inContext)
		{
			FileModel fileModel = new FileModel(file);
            fileModel.Context = inContext;
			return ParseFile(fileModel);
		}
		
		static public FileModel ParseFile(FileModel fileModel)
        {
            string src = "";
            // parse file
            if (fileModel.FileName.Length > 0)
            {
                if (File.Exists(fileModel.FileName))
                {
                    src = PluginCore.Helpers.FileHelper.ReadFile(fileModel.FileName);
                    ASFileParser parser = new ASFileParser();
                    fileModel.LastWriteTime = File.GetLastWriteTime(fileModel.FileName);
                    if (cachedPath != null)
                        cacheLastWriteTime = fileModel.LastWriteTime;
                    parser.ParseSrc(fileModel, src);
                }
                // the file is not available (for the moment?)
                else if (Path.GetExtension(fileModel.FileName).Length > 0)
                {
                    fileModel.OutOfDate = true;
                }
            }
            // this is a package
            else
            {
                // ignore
            }
            return fileModel;
        }
        #endregion

        #region parser context
        const int COMMENTS_BUFFER = 4096;
		const int TOKEN_BUFFER = 1024;
		const int VALUE_BUFFER = 1024;
		
		// parser context
		private FileModel model;
		private int version;
		private bool haXe;
		private bool tryPackage;
        private bool hasPackageSection;
		private FlagType context;
		private FlagType modifiers;
		private FlagType curModifiers;
		//private int modifiersPos;
        private int line;
		private int modifiersLine;
		private bool foundColon;
		private bool inParams;
		private bool inEnum;
        private bool inTypedef;
        private bool inGeneric;
		private bool inValue;
        private bool inConst;
		private bool inType;
        private bool flattenNextBlock;
		private FlagType foundKeyword;
		private Token valueKeyword;
        private MemberModel valueMember;
		private Token curToken;
		private Token prevToken;
		private MemberModel curMember;
		private MemberModel curMethod;
        private Visibility curAccess;
		private string curNamespace;
		private ClassModel curClass;
		private string lastComment;
		private string curComment;
        private ContextFeatures features;
        #endregion

        #region tokenizer

        public ContextFeatures Features
        {
            get { return features; }
        }

        public ASFileParser()
        {
            features = new ContextFeatures();
        }

        /// <summary>
        /// Rebuild a file model with the source provided
        /// </summary>
        /// <param name="fileModel">Model</param>
        /// <param name="ba">Source</param>
		public void ParseSrc(FileModel fileModel, string ba)
		{
            //TraceManager.Add("Parsing " + Path.GetFileName(fileModel.FileName));
            model = fileModel;
            model.OutOfDate = false;
            model.CachedModel = false;

            // pre-filtering
            if (model.HasFiltering && model.Context != null)
                ba = model.Context.FilterSource(fileModel.FileName, ba);
            model.InlinedIn = null;
            model.InlinedRanges = null;

            // language features
            if (model.Context != null) features = model.Context.Features;
            model.Imports.Clear();
            model.Classes.Clear();
            model.Members.Clear();
            model.Namespaces.Clear();
            model.Regions.Clear();
            model.PrivateSectionIndex = 0;
            model.Package = "";
            model.MetaDatas = null;

			// state
			int len = ba.Length;
			if (len < 0)
				return;
			int i = 0;
			line = 0;
			
		// when parsing cache file including multiple files
		resetParser:
			
			char c1;
			char c2;
			int matching = 0;
			bool isInString = false;
			int inString = 0;
			int braceCount = 0;
			bool inCode = true;

			// comments
			char[] commentBuffer = new char[COMMENTS_BUFFER];
			int commentLength = 0;
			lastComment = null;
			curComment = null;

			// tokenisation
			tryPackage = true;
            hasPackageSection = false;
			haXe = model.haXe;
			version = (haXe)? 4 : 1;
			curToken = new Token();
			prevToken = new Token();
			int tokPos = 0;
			int tokLine = 0;
			curMethod = null;
			curMember = null;
			valueKeyword = null;
            valueMember = null;
			curModifiers = 0;
			curNamespace = "internal";
            curAccess = 0;

			char[] buffer = new char[TOKEN_BUFFER];
			int length = 0;
			char[] valueBuffer = new char[VALUE_BUFFER];
			int valueLength = 0;
			int paramBraceCount = 0;
			int paramTempCount = 0;
			int paramParCount = 0;
			int paramSqCount = 0;

			bool hadWS = true;
			bool hadDot = false;
			inParams = false;
			inEnum = false;
            inTypedef = false;
			inValue = false;
            inConst = false;
            inType = false;
            inGeneric = false;

			bool addChar = false;
			int evalToken = 0;
			//bool evalKeyword = true;
			context = 0;
			modifiers = 0;
			foundColon = false;

            bool handleDirectives = features.hasDirectives || cachedPath != null;

			while (i < len)
			{
				c1 = ba[i++];
				isInString = (inString > 0);

				/* MATCH COMMENTS / STRING LITERALS */

				switch (matching)
				{
					// look for comment block/line and preprocessor commands
					case 0:
						if (!isInString)
						{
							// new comment
							if (c1 == '/' && i < len)
							{
								c2 = ba[i];
								if (c2 == '/') {
                                    // Check if this this is a /// comment
                                    if (i + 1 < len && ba[i + 1] == '/')
                                    {
                                        // This is a /// comment
                                        matching = 4;
                                        i++;
                                    }
                                    else
                                    {
                                        // This is a regular comment
                                        matching = 1;
                                    }
                                    inCode = false;
                                    i++;
                                    continue;
								}
								else if (c2 == '*') {
									matching = 2;
									inCode = false;
									i++;
									while (i < len-1)
									{
										c2 = ba[i];
										if (c2 == '*' && ba[i+1] != '/') i++;
										else break;
									}
									continue;
								}
							}
							// don't look for comments in strings
							else if (c1 == '"')
							{
								isInString = true;
								inString = 1;
							}
							else if (c1 == '\'')
							{
								isInString = true;
								inString = 2;
							}
							// preprocessor statements
							else if (c1 == '#' && handleDirectives)
							{
								c2 = ba[i];
								if (i < 2 || ba[i-2] < 33 && c2 >= 'a' && c2 <= 'z') 
								{
									matching = 3;
									inCode = false;
									continue;
								}
							}
						}
						// end of string
                        else if (isInString)
                        {
                            if (c1 == '\\') { i++; continue; }
                            else if (c1 == 10 || c1 == 13) inString = 0;
                            else if ((inString == 1) && (c1 == '"')) inString = 0;
                            else if ((inString == 2) && (c1 == '\'')) inString = 0;

                            // extract "include" declarations
                            if (inString == 0 && length == 7 && context == 0)
                            {
                                string token = new string(buffer, 0, length);
                                if (token == "include")
                                {
                                    string inc = ba.Substring(tokPos, i - tokPos);
                                    if (model.MetaDatas == null) model.MetaDatas = new List<ASMetaData>();
                                    ASMetaData meta = new ASMetaData("Include");
                                    meta.ParseParams(inc);
                                    model.MetaDatas.Add(meta);
                                }
                            }
                        }
						break;

					// skip commented line
					case 1:
						if (c1 == 10 || c1 == 13) 
						{
							// ignore single comments
							commentLength = 0;
							inCode = true;
							matching = 0;
						}
						break;

					// skip commented block
					case 2:
						if (c1 == '*')
						{
							bool end = false;
							while (i < len)
							{
								c2 = ba[i];
                                if (c2 == '\\') { i++; continue; }
								if (c2 == '/') 
								{
									end = true;
									break;
								}
								else if (c2 == '*') i++;
								else break;
							}
							if (end)
							{
								lastComment = (commentLength > 0) ? new string(commentBuffer, 0, commentLength) : null;
								// TODO  parse for TODO statements?
								commentLength = 0;
								inCode = true;
								matching = 0;
								i++;
								continue;
							}
						}
						break;
						
					// directive/preprocessor statement
					case 3:
						if (c1 == 10 || c1 == 13) 
						{
							if (commentLength > 0)
							{
								string directive = new string(commentBuffer, 0, commentLength);
                                if (directive.StartsWith("if"))
                                {
                                    inCode = true;
                                }
                                else if (directive.StartsWith("else"))
                                {
                                    inCode = true;
                                }
                                else inCode = true;
								
								// FD cache custom directive
								if (cachedPath != null && directive.StartsWith("file-cache "))
								{
                                    // parsing done!
                                    FinalizeModel();

                                    // next model
                                    string realFile = directive.Substring(11);
                                    FileModel newModel = new FileModel(realFile, cacheLastWriteTime);
                                    newModel.CachedModel = true;
                                    newModel.Context = model.Context;
                                    haXe = newModel.haXe;
                                    if (!cachedPath.HasFile(realFile) && File.Exists(realFile))
                                    {
                                        newModel.OutOfDate = (File.GetLastWriteTime(realFile) > cacheLastWriteTime);
                                        cachedPath.AddFile(newModel);
                                    }
                                    model = newModel;
                                    goto resetParser; // loop
								}
                            }
                            else inCode = true;
                            commentLength = 0;
                            matching = 0;
						}
						break;

                    // We are inside a /// comment
                    case 4:
                        {
                            bool end = false;
                            bool skipAhead = false;

                            // See if we just ended a line
                            if (2 <= i && (ba[i - 2] == 10 || ba[i - 2] == 13))
                            {
                                // Check ahead to the next line, see if it has a /// comment on it too.
                                // If it does, we want to continue the comment with that line.  If it
                                // doesn't, then this comment is finished and we will set end to true.
                                for (int j = i+1; j < len; ++j)
                                {
                                    // Skip whitespace
                                    char twoBack = ba[j-2];
                                    if (' ' != twoBack && '\t' != twoBack)
                                    {
                                        if ('/' == twoBack && '/' == ba[j-1] && '/' == ba[j])
                                        {
                                            // There is a comment ahead.  Move up to it so we can gather the
                                            // rest of the comment
                                            i = j+1;
                                            skipAhead = true;
                                            break;
                                        }
                                        else
                                        {
                                            // Not a comment!  We're done!
                                            end = true;
                                            break;
                                        }
                                    }
                                }
                            }
                            if (end)
                            {
                                // The comment is over and we want to write it out
                                lastComment = (commentLength > 0) ? new string(commentBuffer, 0, commentLength).Trim() : null;
                                commentLength = 0;
                                inCode = true;
                                matching = 0;

                                // Back up i so we can start gathering comments from right after the line break
                                --i;
                                continue;
                            }
                            if (skipAhead)
                            {
                                // We just hit another /// and are skipping up to right after it.
                                continue;
                            }
                            break;
                        }
				}

				/* LINE/COLUMN NUMBER */

				if (c1 == 10 || c1 == 13)
                {
                    if (cachedPath == null) line++; // cache breaks line count
					if (c1 == 13 && i < len && ba[i] == 10) i++;
				}


				/* SKIP CONTENT */

				if (!inCode)
				{
                    // store comments
                    if (matching == 2 || (matching == 3 && handleDirectives) || matching == 4)
                    {
                        if (commentLength < COMMENTS_BUFFER) commentBuffer[commentLength++] = c1;
                    }
                    else if (matching == 1 && (c1 == '#' || c1 == '{'))
                    {
                        commentBuffer[commentLength++] = c1;
                        while (i < len)
                        {
                            c2 = ba[i];
                            if (commentLength < COMMENTS_BUFFER) commentBuffer[commentLength++] = c2;
                            if (c2 == 10 || c2 == 13)
                                break;
                            i++;
                        }

                        string comment = new String(commentBuffer, 0, commentLength);
                        Match match = re_region.Match(comment);
                        if (match.Success)
                        {
                            string regionName = match.Groups["name"].Value.Trim();
                            MemberModel region = new MemberModel(regionName, String.Empty, FlagType.Declaration, Visibility.Default);
                            region.LineFrom = region.LineTo = line;
                            model.Regions.Add(region);
                        }
                    }
					continue;
				}
				else if (isInString)
				{
					// store parameter default value
                    if (inValue && (inParams || inConst) && valueLength < VALUE_BUFFER) 
                        valueBuffer[valueLength++] = c1;
					continue;
				}
				if (braceCount > 0 && !inValue)
				{
					if (c1 == '}')
					{
                        lastComment = null;
						braceCount--;
						if (braceCount == 0 && curMethod != null)
						{
							curMethod.LineTo = line;
							curMethod = null;
						}
					}
					else if (c1 == '{') braceCount++;
                    // escape next char
                    else if (c1 == '\\') i++;
					continue;
				}


				/* PARSE DECLARATION VALUES/TYPES */

				if (inValue)
				{
                    if (inType && !Char.IsLetterOrDigit(c1) && ".{}-><".IndexOf(c1) < 0)
                    {
                        inType = false;
                        inValue = false;
                        inGeneric = false;
                        valueLength = 0;
                        length = 0;
                        context = 0;
                    }
                    else if (c1 == '{')
                    {
                        paramBraceCount++;
                        c1 = ' '; // ignore brace
                    }
                    else if (c1 == '}' && paramBraceCount > 0)
                    {
                        paramBraceCount--;
                        if (!inType && paramBraceCount == 0 && paramParCount == 0 && paramSqCount == 0 && valueLength < VALUE_BUFFER)
                        {
                            valueBuffer[valueLength++] = '}';
                            c1 = ';'; // stop value
                        }
                    }
                    else if (c1 == '(')
                    {
                        // TODO "timeline code": detect a function declaration
                        /*if (!inType && paramParCount == 0)
                        {
                            string param = new string(valueBuffer, 0, valueLength).Trim();
                            if (param == "function")
                            {
                                inValue = false;
                                valueLength = 0;
                                if (curMember != null)
                                {
                                    curMember.Flags -= FlagType.Variable;
                                    curMember.Flags |= FlagType.Function;
                                    context = FlagType.Function;
                                    i--;
                                }
                            }
                        }*/
                        paramParCount++;
                    }
                    else if (c1 == ')')
                    {
                        if (paramParCount > 0) paramParCount--;
                    }
                    else if (c1 == '[') paramSqCount++;
                    else if (c1 == ']' && paramSqCount > 0) paramSqCount--;
                    else if (paramTempCount > 0)
                    {
                        if (c1 == '<') paramTempCount++;
                        else if (c1 == '>')
                        {
                            // ignore haxe method signatures
                            if (inGeneric && i > 1 && ba[i - 2] == '-') { /*ignore*/ }
                            else paramTempCount--;
                        }
                    }
                    else if (inValue && c1 == '/' && valueLength == 0) // lookup native regex
                    {
                        int itemp = i;
                        valueBuffer[valueLength++] = '/';
                        while (valueLength < VALUE_BUFFER && i < len)
                        {
                            c1 = ba[i++];
                            if (c1 == '\n' || c1 == '\r')
                            {
                                valueLength = 0;
                                i = itemp;
                                break;
                            }
                            valueBuffer[valueLength++] = c1;
                            if (c1 == '\\' && i < len)
                            {
                                c1 = ba[i++];
                                valueBuffer[valueLength++] = c1;
                            }
                            else if (c1 == '/') break;
                        }
                    }

					// end of value
					if ( paramBraceCount == 0 && paramParCount == 0 && paramSqCount == 0 && paramTempCount == 0
					    && (c1 == ',' || c1 == ';' || c1 == '}' || c1 == '\r' || c1 == '\n' 
                            || (inParams && c1 == ')') || inType) )
					{
                        if (!inType && (!inValue || c1 != ','))
                        {
                            length = 0;
                            context = 0;
                        }
						inValue = false;
                        inGeneric = false;
                        if (inType && valueLength < VALUE_BUFFER) valueBuffer[valueLength++] = c1;
					}

					// in params, store the default value
					else if ((inParams || inType || inConst) && valueLength < VALUE_BUFFER)
					{
						if (c1 <= 32)
						{
                            if (valueLength > 0 && valueBuffer[valueLength-1] != ' ') 
                                valueBuffer[valueLength++] = ' ';
						}
						else valueBuffer[valueLength++] = c1;
					}

					// detect keywords
                    if (!Char.IsLetterOrDigit(c1))
                    {
                        // escape next char
                        if (c1 == '\\' && i < len) 
                        {
                            c1 = ba[i++];
                            if (valueLength < VALUE_BUFFER) valueBuffer[valueLength++] = c1;
                            continue; 
                        }
                        if (inType && inGeneric && (c1 == '<' || c1 == '.')) continue;
                        hadWS = true;
                    }
                }

				// store type / parameter value
				if (!inValue && valueLength > 0)
				{
					string param = new string(valueBuffer, 0, valueLength);
					
                    // get text before the last keyword found
					if (valueKeyword != null)
					{
						int p = param.LastIndexOf(valueKeyword.Text);
						if (p > 0) param = param.Substring(0,p).TrimEnd();
					}
					
					if (curMember == null)
					{
						if (inType)
						{
							prevToken.Text = curToken.Text;
							prevToken.Line = curToken.Line;
							prevToken.Position = curToken.Position;
							curToken.Text = param;
							curToken.Line = tokLine;
							curToken.Position = tokPos;
							EvalToken(true, true/*false*/, i-1-valueLength);
							evalToken = 0;
						}
					}
					else if (inType)
					{
						foundColon = false;
                        if (haXe && (param.EndsWith("}") || param.Contains(">")))
                        {
                            param = re_spaces.Replace(param, "");
                            param = param.Replace(",", ", ");
                            param = param.Replace("->", " -> ");
                        }
						curMember.Type = param;
					}
                    // AS3 const or method parameter's default value 
					else if (version > 2 && (curMember.Flags & FlagType.Variable) > 0)
					{
                        curMember.Value = param;
                        if (inConst)
                        {
                            context = 0;
                            inConst = false;
                        }
					}
					//
					valueLength = 0;
					length = 0;
                    if (!inParams) continue;
				}

				/* TOKENIZATION */

				// whitespace
				if (c1 <= 32)
				{
					hadWS = true;
					continue;
				}
				// a dot can be in an identifier
				if (c1 == '.')
				{
					if (length > 0 || (inParams && version == 3))
					{
						hadWS = false;
						hadDot = true;
						addChar = true;
                        if (!inValue && context == FlagType.Variable && !foundColon)
                        {
                            bool keepContext = inParams && (length == 0 || buffer[0] == '.');
                            if (!keepContext) context = 0;
                        }
					}
					else continue;
                }
				else
				{
					// should we evaluate the token?
                    if (hadWS && !hadDot && !inGeneric && length > 0)
					{
                        evalToken = 1;
					}
					hadWS = false;
					hadDot = false;
                    bool shortcut = true;

					// valid char for keyword
					if (c1 >= 'a' && c1 <= 'z')
					{
						addChar = true;
					}
					else
					{
						// valid chars for identifiers
                        if (c1 >= 'A' && c1 <= 'Z')
                        {
                            addChar = true;
                        }
                        else if (c1 == '$' || c1 == '_')
                        {
                            addChar = true;
                        }
                        else if (length > 0)
                        {
                            if (c1 >= '0' && c1 <= '9')
                            {
                                addChar = true;
                            }
                            else if (c1 == '*' && context == FlagType.Import)
                            {
                                addChar = true;
                            }
                            // haXe generics
                            else if (features.hasGenerics && c1 == '<')
                            {
                                if (!inValue && i > 2 && length > 1 && i < len - 3
                                    && Char.IsLetterOrDigit(ba[i - 3]) && Char.IsLetter(ba[i])
                                    && (buffer[length - 1] == '.' || Char.IsLetter(buffer[length - 1])))
                                {
                                    evalToken = 0;
                                    inGeneric = true;
                                    inValue = true;
                                    inType = true;
                                    valueLength = 0;
                                    for (int j = 0; j < length; j++)
                                        valueBuffer[valueLength++] = buffer[j];
                                    valueBuffer[valueLength++] = c1;
                                    length = 0;
                                    paramBraceCount = 0;
                                    paramParCount = 0;
                                    paramSqCount = 0;
                                    paramTempCount = 1;
                                    continue;
                                }
                            }
                            else if (inGeneric && (c1 == ',' || c1 == '.' || c1 == '-' || c1 == '>'))
                            {
                                hadWS = false;
                                hadDot = false;
                                evalToken = 0;
                            }
                            else
                            {
                                evalToken = 2;
                                shortcut = false;
                            }
                        }
                        // star is valid in import statements
                        else if (c1 == '*' && version == 3)
                        {
                            addChar = true;
                        }
                        // conditional haXe parameter
                        else if (c1 == '?' && haXe && inParams && length == 0)
                        {
                            addChar = true;
                        }
                        else shortcut = false;
					}

					// eval this word
					if (evalToken > 0)
					{
						prevToken.Text = curToken.Text;
						prevToken.Line = curToken.Line;
						prevToken.Position = curToken.Position;
						curToken.Text = new string(buffer, 0, length);
						curToken.Line = tokLine;
						curToken.Position = tokPos;
						EvalToken(!inValue, (c1 != '=' && c1 != ','), i-1-length);
						length = 0;
						evalToken = 0;
					}

                    if (!shortcut)
					// start of block
					if (c1 == '{')
					{
						if (context == FlagType.Package || context == FlagType.Class) // parse package/class block
						{
                            context = 0;
						}
						else if (context == FlagType.Enum) // parse enum block
						{
                            if (curClass != null && (curClass.Flags & FlagType.Enum) > 0)
                                inEnum = true;
                            else
                            {
                                context = 0;
                                curModifiers = 0;
                                braceCount++; // ignore block
                            }
						}
                        else if (context == FlagType.TypeDef) // parse typedef block
                        {
                            if (curClass != null && (curClass.Flags & FlagType.TypeDef) > 0)
                            {
                                inTypedef = true;
                                if (i < len && ba[i] == '>')
                                {
                                    buffer[0] = 'e'; buffer[1] = 'x'; buffer[2] = 't'; buffer[3] = 'e'; buffer[4] = 'n'; buffer[5] = 'd'; buffer[6] = 's';
                                    length = 7;
                                    context = FlagType.Class;
                                }
                            }
                            else
                            {
                                context = 0;
                                curModifiers = 0;
                                braceCount++; // ignore block
                            }
                        }
                        else if (foundColon && haXe && length == 0) // copy haXe anonymous type
						{
							inValue = true;
							inType = true;
							valueLength = 0;
							valueBuffer[valueLength++] = c1;
							paramBraceCount = 1;
							paramParCount = 0;
							paramSqCount = 0;
							paramTempCount = 0;
							continue;
						}
                        else if (flattenNextBlock) // not in a class, parse if/for/while/do blocks
                        {
                            flattenNextBlock = false;
                            context = 0;
                        }
                        else braceCount++; // ignore block
					}
					
					// end of block
					else if (c1 == '}')
					{
                        curComment = null;
						// outside of a method, the '}' ends the current class
                        if (curClass != null)
                        {
                            if (curClass != null) curClass.LineTo = line;
                            curClass = null;
                            inEnum = false;
                            inTypedef = false;
                        }
                        else
                        {
                            if (hasPackageSection && model.PrivateSectionIndex == 0) model.PrivateSectionIndex = line + 1;
                            flattenNextBlock = false;
                        }
                    }
					
					// member type declaration
					else if (c1 == ':')
					{
						foundColon = true;
					}
					
					// next variable declaration
					else if (c1 == ',')
					{
                        if ((context == FlagType.Variable || context == FlagType.TypeDef) && curMember != null)
                        {
                            curAccess = curMember.Access;
                            foundKeyword = FlagType.Variable;
                            lastComment = null;
                        }
                        else if (context == FlagType.Class && prevToken.Text == "implements")
                        {
                            curToken.Text = "implements";
                            foundKeyword = FlagType.Implements;
                        }
					}
					
					else if (c1 == '(')
					{
                        if (!inValue && context == FlagType.Variable && curToken.Text != "catch")
                            if (haXe && curMember != null && valueLength == 0) // haXe properties
                            {
                                curMember.Flags -= FlagType.Variable;
                                curMember.Flags |= FlagType.Getter | FlagType.Setter;
                                context = FlagType.Function;
                            }
                            else context = 0;

						// beginning of method parameters
                        if (context == FlagType.Function)
                        {
                            context = FlagType.Variable;
                            inParams = true;
                            if (valueMember != null && curMember == null)
                            {
                                valueLength = 0;
                                //valueMember.Flags -= FlagType.Variable; ???
                                valueMember.Flags = FlagType.Function;
                                curMethod = curMember = valueMember;
                                valueMember = null;
                            }
                            else if (curMember == null)
                            {
                                context = FlagType.Function;
                                if ((curModifiers & FlagType.Getter) > 0)
                                {
                                    curModifiers -= FlagType.Getter;
                                    EvalToken(true, false, i);
                                    curMethod = curMember;
                                    context = FlagType.Variable;
                                }
                                else if ((curModifiers & FlagType.Setter) > 0)
                                {
                                    curModifiers -= FlagType.Setter;
                                    EvalToken(true, false, i);
                                    curMethod = curMember;
                                    context = FlagType.Variable;
                                }
                                else
                                {
                                    inParams = false;
                                    context = 0;
                                }
                            }
                            else
                            {
                                curMethod = curMember;
                            }
                        }

                        // an Enum value with parameters
                        else if (inEnum && curToken != null)
                        {
                            context = FlagType.Variable;
                            inParams = true;
                            curMethod = curMember ?? new MemberModel();
                            curMethod.Name = curToken.Text;
                            curMethod.Flags = curModifiers | FlagType.Function | FlagType.Static;
                            curMethod.Parameters = new List<MemberModel>();
                            //
                            if (curClass != null && curMember == null) curClass.Members.Add(curMethod);
                        }

                        // a TypeDef method with parameters
                        else if (inTypedef && curToken != null)
                        {
                            context = FlagType.Variable;
                            inParams = true;
                            curMethod = curMember ?? new MemberModel();
                            curMethod.Name = curToken.Text;
                            curMethod.Flags = curModifiers | FlagType.Function;
                            curMethod.Parameters = new List<MemberModel>();
                            //
                            if (curClass != null && curMember == null) curClass.Members.Add(curMethod);
                        }

                        else if (curMember == null && curToken.Text != "catch") context = 0;
					}
					
					// end of statement
					else if (c1 == ';')
					{
                        context = (inEnum) ? FlagType.Enum : 0;
						modifiers = 0;
						inParams = false;
						curMember = null;
					}
					
					// end of method parameters
					else if (c1 == ')' && inParams)
					{
						context = 0;
                        if (inEnum) context = FlagType.Enum;
                        else if (inTypedef) context = FlagType.TypeDef;
						modifiers = 0;
						inParams = false;
						curMember = curMethod;
					}
					
					// skip value of a declared variable
					else if (c1 == '=')
					{
                        if (context == FlagType.Variable || (context == FlagType.Enum && inEnum))
                        {
                            if (!inValue && curMember != null)
                            {
                                inValue = true;
                                inConst = (curMember.Flags & FlagType.Constant) > 0;
                                inType = false;
                                inGeneric = false;
                                paramBraceCount = 0;
                                paramParCount = 0;
                                paramSqCount = 0;
                                paramTempCount = 0;
                                valueLength = 0;
                                valueMember = curMember;
                            }
                        }
					}

                    // metadata
                    else if (!inValue && c1 == '[' && version == 3)
                    {
                        LookupMeta(ref ba, ref i);
                    }

                    // haXe signatures: T -> T -> T
                    else if (haXe && c1 == '-' && curMember != null)
                    {
                        if (ba[i] == '>')
                        {
                            curMember.Type += " ->";
                            foundColon = true;
                        }
                    }

                    // escape next char
                    else if (c1 == '\\') { i++; continue; }
				}

				// put in buffer
				if (addChar)
				{
					if (length < TOKEN_BUFFER) buffer[length++] = c1;
					
					if (length == 1)
					{
						tokPos = i-1;
						tokLine = line;
					}
					addChar = false;
				}
			}
			
			// parsing done!
            FinalizeModel();

            // post-filtering
            if (cachedPath == null && model.HasFiltering && model.Context != null)
                model.Context.FilterSource(model);
		}

        private bool LookupMeta(ref string ba, ref int i)
        {
            int len = ba.Length;
            int i0 = i;
            int line0 = line;
            int inString = 0;
            int parCount = 0;
            bool isComplex = false;
            while (i < len)
            {
                char c = ba[i];
                if (c == 10 || c == 13)
                {
                    if (cachedPath == null) line++; // cache breaks line count
                    if (c == 13 && i < len && ba[i + 1] == 10) i++;
				}
                if (inString == 0)
                {
                    if (c == '"') inString = 1;
                    else if (c == '\'') inString = 2;
                    else if ("{;[".IndexOf(c) >= 0)
                    {
                        i = i0;
                        line = line0;
                        return false;
                    }
                    else if (c == '(') parCount++;
                    else if (c == ')')
                    {
                        parCount--;
                        if (parCount < 0) return false;
                        isComplex = true;
                    }
                    else if (c == ']') break;
                }
                else if (inString == 1 && c == '"') inString = 0;
                else if (inString == 2 && c == '\'') inString = 0;
                else if (inString > 0 && (c == 10 || c == 13)) inString = 0;
                i++;
            }

            string meta = ba.Substring(i0, i - i0);
            ASMetaData md = new ASMetaData(isComplex ? meta.Substring(0, meta.IndexOf('(')) : meta);
            md.LineFrom = line0;
            md.LineTo = line;
            if (isComplex)
            {
                meta = meta.Substring(meta.IndexOf('(') + 1);
                md.ParseParams(meta.Substring(0, meta.Length - 1));
                if (lastComment != null && (md.Name == "Event" || md.Name == "Style"))
                {
                    md.Comments = lastComment;
                    lastComment = null;
                }
            }
            if (model.MetaDatas == null) model.MetaDatas = new List<ASMetaData>();
            model.MetaDatas.Add(md);
            return true;
        }

        private void FinalizeModel()
        {
            model.Version = version;
            if (model.FileName.Length == 0 || model.FileName.EndsWith("_cache")) return;
            if (model.PrivateSectionIndex == 0) model.PrivateSectionIndex = line;
            if (version == 2)
            {
                string testPackage = Path.Combine(Path.GetDirectoryName(model.FileName), model.GetPublicClass().Name); 
                if (Directory.Exists(testPackage)) model.TryAsPackage = true;
            }
        }
        #endregion

        #region lexer
        /// <summary>
		/// Eval a token depending on the parser context
		/// </summary>
		/// <param name="evalContext">The token could be an identifier</param>
		/// <param name="evalKeyword">The token could be a keyword</param>
		/// <param name="position">Parser position</param>
		/// <returns>A keyword was found</returns>
		private bool EvalToken(bool evalContext, bool evalKeyword, int position)
		{
			bool hadContext = (context != 0);
			bool hadKeyword = (foundKeyword != 0);
			foundKeyword = 0;

			/* KEYWORD EVALUATION */

            string token = curToken.Text;
            int dotIndex = token.LastIndexOf('.');
			if (evalKeyword && (token.Length > 2))
			{
                if (dotIndex > 0) token = token.Substring(dotIndex + 1);

				// members
				if (token == "var" || token == "catch")
				{
					foundKeyword = FlagType.Variable;
				}
				else if (token == "function")
				{
					foundKeyword = FlagType.Function;
				}
				else if (features.hasConsts && token == "const")
				{
					foundKeyword = FlagType.Variable;
					modifiers |= FlagType.Constant;
				}
				else if (features.hasNamespaces && token == "namespace")
				{
                    if (prevToken.Text != "use")
					    foundKeyword = FlagType.Namespace;
				}
				
				// class declaration
				else if (tryPackage && token == "package")
				{
					foundKeyword = FlagType.Package;
					if (version < 3)
					{
						version = 3;
                        hasPackageSection = true;
                        //model.Namespaces.Add("AS3", Visibility.Public);
                        //model.Namespaces.Add("ES", Visibility.Public);
                    }
				}
				else if (token == "class")
				{
					foundKeyword = FlagType.Class;
                    modifiers |= FlagType.Class;
					if (version == 1) version = 2;
				}
				else if (token == "interface")
				{
					foundKeyword = FlagType.Class;
                    modifiers |= FlagType.Class | FlagType.Interface;
					if (version == 1) version = 2;
                }
                else if (features.hasTypeDefs && token == "typedef")
                {
                    foundKeyword = FlagType.TypeDef;
                    modifiers |= FlagType.TypeDef;
                }
				else if (features.hasEnums && token == "enum")
				{
					foundKeyword = FlagType.Enum;
                    modifiers |= FlagType.Enum;
				}

				// head declarations
				else if (token == "import")
				{
					foundKeyword = FlagType.Import;
				}

                // modifiers
                else
                {
                    if (context == FlagType.Class)
                    {
                        if (token == "extends")
                        {
                            foundKeyword = FlagType.Class;
                            curModifiers = FlagType.Extends;
                            return true;
                        }
                        else if (token == "implements")
                        {
                            foundKeyword = FlagType.Class;
                            curModifiers = FlagType.Implements;
                            return true;
                        }
                    }

                    // properties
                    else if (context == FlagType.Function)
                    {
                        if (token == "get")
                        {
                            foundKeyword = FlagType.Function;
                            curModifiers |= FlagType.Getter;
                            return true;
                        }
                        else if (token == "set")
                        {
                            foundKeyword = FlagType.Function;
                            curModifiers |= FlagType.Setter;
                            return true;
                        }
                    }

                    FlagType foundModifier = 0;

                    // access modifiers
                    if (token == "public")
                    {
                        foundModifier = FlagType.Access;
                        curAccess = Visibility.Public;
                    }
                    else if (token == "private")
                    {
                        foundModifier = FlagType.Access;
                        curAccess = Visibility.Private;
                    }
                    else if (token == features.protectedKey)
                    {
                        foundModifier = FlagType.Access;
                        curAccess = Visibility.Protected;
                    }
                    else if (token == features.internalKey)
                    {
                        foundModifier = FlagType.Access;
                        curAccess = Visibility.Internal;
                    }
                    else if (version == 3 && !hadContext) // TODO Handle namespaces properly
                    {
                        if (token == "AS3")
                        {
                            foundModifier = FlagType.Access;
                            curAccess = Visibility.Public;
                            curNamespace = token;
                        }
                        else if (token == "flash_proxy")
                        {
                            foundModifier = FlagType.Access;
                            curAccess = Visibility.Public;
                            curNamespace = token;
                        }
                    }

                    // other modifiers
                    if (foundModifier == 0)
                        if (token == "static")
                        {
                            foundModifier = FlagType.Static;
                        }
                        else if (version <= 3 && token == "intrinsic")
                        {
                            foundModifier = FlagType.Intrinsic;
                        }
                        else if (version == 3 && token == "override")
                        {
                            foundModifier = FlagType.Override;
                        }
                        else if (version == 3 && token == "native")
                        {
                            foundModifier = FlagType.Intrinsic | FlagType.Native;
                        }
                        else if (version == 4 && token == "extern")
                        {
                            foundModifier = FlagType.Intrinsic | FlagType.Extern;
                        }
                        else if (token == "dynamic")
                        {
                            foundModifier = FlagType.Dynamic;
                        }
                        // namespace modifier
                        else if (features.hasNamespaces && model.Namespaces.Count > 0) 
                            foreach (KeyValuePair<string, Visibility> ns in model.Namespaces)
                                if (token == ns.Key)
                                {
                                    curAccess = ns.Value;
                                    curNamespace = token;
                                    foundModifier = FlagType.Namespace;
                                }

                    // a declaration modifier was recognized
                    if (foundModifier != 0)
                    {
                        if (inParams && inValue) valueKeyword = new Token(curToken);
                        inParams = false;
                        inEnum = false;
                        inTypedef = false;
                        inValue = false;
                        inConst = false;
                        inType = false;
                        inGeneric = false;
                        valueMember = null;
                        foundColon = false;
                        if (curNamespace == "internal") curNamespace = "";
                        if (context != 0)
                        {
                            modifiers = 0;
                            context = 0;
                        }
                        if (modifiers == 0)
                        {
                            modifiersLine = curToken.Line;
                            //modifiersPos = curToken.Position;
                        }
                        modifiers |= foundModifier;

                        return true;
                    }
                }
			}

			// a declaration keyword was recognized
            if (foundKeyword != 0)
            {
                if (dotIndex > 0)
                {
                    // an unexpected keyword was found, ignore previous context 
                    curToken.Text = token;
                    curToken.Line = line;
                    // TODO  Should the parser note this error?
                }

                if (inParams && inValue) valueKeyword = new Token(curToken);
                inParams = false;
                inEnum = false;
                inTypedef = false;
                inGeneric = false;
                inValue = false;
                inConst = false;
                if (token != "function") valueMember = null;
                foundColon = false;
                context = foundKeyword;
                curModifiers = modifiers;
                curComment = lastComment;
                if (foundKeyword != FlagType.Import)
                    lastComment = null;
                modifiers = 0;
                curMember = null;
                return true;
            }
            else
            {
                // when not in a class, parse if/for/while blocks
                if (version < 2 &&
                    (token == "if" || token == "else" || token == "for" || token == "while" || token == "do"
                     || token == "switch" || token == "with" || token == "case"
                     || token == "try" || token == "catch" || token == "finally"))
                {
                    flattenNextBlock = true;
                    if (token == "catch")
                    {
                        curModifiers = 0;
                        foundKeyword = FlagType.Variable;
                        context = FlagType.Variable;
                    }
                    return false;
                }

                if (inValue && valueMember != null) valueMember = null;
                if (!evalContext) return false;
                if (dotIndex > 0) token = curToken.Text;

                // some heuristic around Enums & Typedefs
                if (inEnum && !inValue)
                {
                    curModifiers = 0;
                    curAccess = Visibility.Public;
                }
                if (inTypedef && !inValue && curModifiers != FlagType.Extends)
                {
                    curModifiers = 0;
                    curAccess = Visibility.Public;
                }
                else if (!inTypedef && curModifiers == FlagType.TypeDef && curClass != null)
                {
                    curClass.ExtendsType = token;
                    curModifiers = 0;
                    context = 0;
                    curComment = null;
                    curClass = null;
                    curNamespace = "internal";
                    curAccess = 0;
                    modifiers = 0;
                    modifiersLine = 0;
                    return true;
                }
            }


			/* EVAL DECLARATION */

			if (foundColon && curMember != null)
			{
				foundColon = false;
                if (haXe && curMember.Type != null) curMember.Type += " " + curToken.Text;
                else curMember.Type = curToken.Text;
				curMember.LineTo = curToken.Line;
				// Typed Arrays
				if (curMember.Type == "Array" && lastComment != null)
				{
                    Match m = re_validTypeName.Match(lastComment);
                    if (m.Success)
                    {
                        curMember.Type = "Array$" + m.Groups["type"].Value;
                        lastComment = null;
                    }
				}
			}
            else if (hadContext && (hadKeyword || inParams || inEnum || inTypedef))
			{
                MemberModel member;
				switch (context)
				{
					case FlagType.Package:
						if (prevToken.Text == "package")
						{
							model.Package = token;
                            model.Comments = curComment;
						}
						break;
						
					case FlagType.Namespace:
						if (prevToken.Text == "namespace")
						{
                            if (!model.Namespaces.ContainsKey(token))
                            {
                                model.Namespaces.Add(token, curAccess);
                                // namespace is treated as a variable
                                member = new MemberModel();
                                member.Comments = curComment;
                                member.Name = token;
                                member.Type = "Namespace";
                                member.Flags = FlagType.Dynamic | FlagType.Variable | FlagType.Namespace;
                                member.Access = (curAccess == 0) ? features.varModifierDefault : curAccess;
                                member.Namespace = curNamespace;
                                member.LineFrom = (modifiersLine != 0) ? modifiersLine : curToken.Line;
                                member.LineTo = curToken.Line;
                                if (curClass != null) curClass.Members.Add(member);
                                else
                                {
                                    member.InFile = model;
                                    member.IsPackageLevel = true;
                                    model.Members.Add(member);
                                }
                            }
						}
						break;

					case FlagType.Import:
						if (prevToken.Text == "import")
						{
							member = new MemberModel();
							member.Name = LastStringToken(token, ".");
							member.Type = token;
                            member.LineFrom = prevToken.Line;
                            member.LineTo = curToken.Line;
                            member.Flags = (token.EndsWith("*")) ? FlagType.Package : FlagType.Class;
                            model.Imports.Add(member);
						}
						break;

					case FlagType.Class:
						if (curModifiers == FlagType.Extends)
						{
                            if (curClass != null)
                            {
                                // typed Array & Proxy
                                if ((token == "Array" || token == "Proxy" || token == "flash.utils.Proxy")
                                    && lastComment != null && re_validTypeName.IsMatch(lastComment))
                                {
                                    Match m = re_validTypeName.Match(lastComment);
                                    if (m.Success)
                                    {
                                        token += "$" + m.Groups["type"].Value;
                                        lastComment = null;
                                    }
                                }
                                curClass.ExtendsType = token;
                                if (inTypedef) context = FlagType.TypeDef;
                            }
						}
						else if (curModifiers == FlagType.Implements)
						{
							if (curClass != null)
							{
								if (curClass.Implements == null) curClass.Implements = new List<string>();
								curClass.Implements.Add(token);
							}
						}
                        else if (prevToken.Text == "class" || prevToken.Text == "interface")
						{
							if (curClass != null)
							{
                                curClass.LineTo = (modifiersLine != 0) ? modifiersLine - 1 : curToken.Line - 1;
							}
							// check classname
							int p = token.LastIndexOf('.');
							if (p > 0) 
							{
                                if (version < 3)
								{
                                    model.Package = token.Substring(0, p);
                                    token = token.Substring(p + 1);
                                }
                                else
                                {
                                    //TODO  Error: AS3 & haXe classes are qualified by their package declaration
                                }
							}

                            if (model.PrivateSectionIndex != 0 && curToken.Line > model.PrivateSectionIndex)
                                curAccess = Visibility.Private;

							curClass = new ClassModel();
							model.Classes.Add(curClass);
							curClass.InFile = model;
							curClass.Comments = curComment;
                            curClass.Type = (model.Package.Length > 0) ? model.Package + "." + token : token;
							curClass.Name = token;
							curClass.Constructor = (haXe) ? "new" : token;
							curClass.Flags = curModifiers;
                            curClass.Access = (curAccess == 0) ? features.classModifierDefault : curAccess;
							curClass.Namespace = curNamespace;
                            curClass.LineFrom = (modifiersLine != 0) ? modifiersLine : curToken.Line;
							curClass.LineTo = curToken.Line;
						}
						else 
						{
							context = 0;
							modifiers = 0;
						}
						break;

					case FlagType.Enum:
                        if (inEnum && curClass != null && prevToken.Text != "enum")
						{
							member = new MemberModel();
							member.Comments = curComment;
							member.Name = token;
							member.Flags = curModifiers | FlagType.Variable | FlagType.Enum | FlagType.Static;
                            member.Access = Visibility.Public;
							member.Namespace = curNamespace;
							member.LineFrom = member.LineTo = curToken.Line;
							curClass.Members.Add(member);
							//
							curMember = member;
						}
						else
						{
							if (curClass != null)
							{
                                curClass.LineTo = (modifiersLine != 0) ? modifiersLine - 1 : curToken.Line - 1;
							}
							curClass = new ClassModel();
							model.Classes.Add(curClass);
							curClass.InFile = model;
                            curClass.Comments = curComment;
                            curClass.Type = (model.Package.Length > 0) ? model.Package + "." + token : token;
							curClass.Name = token;
                            curClass.Flags = curModifiers;
                            curClass.Access = (curAccess == 0) ? features.enumModifierDefault : curAccess;
							curClass.Namespace = curNamespace;
                            curClass.LineFrom = (modifiersLine != 0) ? modifiersLine : curToken.Line;
							curClass.LineTo = curToken.Line;
						}
						break;

                    case FlagType.TypeDef:
                        if (inTypedef && curClass != null && prevToken.Text != "typedef")
                        {
                            member = new MemberModel();
                            member.Comments = curComment;
                            member.Name = token;
                            member.Flags = curModifiers | FlagType.Variable | FlagType.Dynamic;
                            member.Access = Visibility.Public;
                            member.Namespace = curNamespace;
                            member.LineFrom = member.LineTo = curToken.Line;
                            curClass.Members.Add(member);
                            //
                            curMember = member;
                        }
                        else
                        {
                            if (curClass != null)
                            {
                                curClass.LineTo = (modifiersLine != 0) ? modifiersLine - 1 : curToken.Line - 1;
                            }
                            curClass = new ClassModel();
                            model.Classes.Add(curClass);
                            curClass.InFile = model;
                            curClass.Comments = curComment;
                            curClass.Type = (model.Package.Length > 0) ? model.Package + "." + token : token;
                            curClass.Name = token;
                            curClass.Flags = FlagType.Class | FlagType.TypeDef;
                            curClass.Access = (curAccess == 0) ? features.typedefModifierDefault : curAccess;
                            curClass.Namespace = curNamespace;
                            curClass.LineFrom = (modifiersLine != 0) ? modifiersLine : curToken.Line;
                            curClass.LineTo = curToken.Line;
                        }
                        break;

					case FlagType.Variable:
						// haXe signatures: T -> T
						if (haXe && curMember != null && curMember.Type != null 
                            && curMember.Type.EndsWith("->"))
						{
							curMember.Type += " "+token;
							return false;
						}
						else
						{
							member = new MemberModel();
							member.Comments = curComment;
							member.Name = token;
                            if ((curModifiers & FlagType.Static) == 0) curModifiers |= FlagType.Dynamic;
							member.Flags = curModifiers | FlagType.Variable;
                            member.Access = (curAccess == 0) ? features.varModifierDefault : curAccess;
							member.Namespace = curNamespace;
                            member.LineFrom = (modifiersLine != 0) ? modifiersLine : curToken.Line;
							member.LineTo = curToken.Line;
							//
							// method parameter
							if (inParams && curMethod != null)
							{
                                member.Flags = FlagType.Variable | FlagType.ParameterVar;
								if (inEnum) member.Flags |= FlagType.Enum;
								if (curMethod.Parameters == null) curMethod.Parameters = new List<MemberModel>();
                                member.Access = 0;
                                if (member.Name.Length > 0)
								    curMethod.Parameters.Add(member);
							}
							// class member
                            else if (curClass != null)
                            {
                                FlagType forcePublic = FlagType.Interface;
                                if (haXe) forcePublic |= FlagType.Intrinsic | FlagType.TypeDef;
                                if ((curClass.Flags & forcePublic) > 0)
                                    member.Access = Visibility.Public;

                                curClass.Members.Add(member);
                                curClass.LineTo = member.LineTo;
                            }
                            // package member
                            else
                            {
                                member.InFile = model;
                                member.IsPackageLevel = true;
                                model.Members.Add(member);
                            }
							//
							curMember = member;
						}
						break;

					case FlagType.Function:
						member = new MemberModel();
						member.Comments = curComment;
						member.Name = token;
                        if ((curModifiers & FlagType.Static) == 0) curModifiers |= FlagType.Dynamic;
                        if ((curModifiers & (FlagType.Getter | FlagType.Setter)) == 0)
                            curModifiers |= FlagType.Function;
						member.Flags = curModifiers;
                        member.Access = (curAccess == 0) ? features.methodModifierDefault : curAccess;
						member.Namespace = curNamespace;
                        member.LineFrom = (modifiersLine != 0) ? modifiersLine : curToken.Line;
						member.LineTo = curToken.Line;
						//
                        if (curClass != null)
                        {
                            if (token == curClass.Constructor)
                            {
                                if (haXe) // constructor is: new()
                                {
                                    member.Name = curClass.Name;
                                    curClass.Constructor = curClass.Name;
                                }
                                member.Flags |= FlagType.Constructor;
                                if ((member.Flags & FlagType.Dynamic) > 0) member.Flags -= FlagType.Dynamic;
                                if (curAccess == 0) curAccess = Visibility.Public;
                            }

                            FlagType forcePublic = FlagType.Interface;
                            if (haXe) forcePublic |= FlagType.Intrinsic | FlagType.TypeDef;
                            if (curAccess == 0 && (curClass.Flags & forcePublic) > 0)
                                member.Access = Visibility.Public;

                            curClass.Members.Add(member);
                            curClass.LineTo = member.LineTo;
                        }
                        // package-level function
                        else
                        {
                            member.InFile = model;
                            member.IsPackageLevel = true;
                            model.Members.Add(member);
                        }
						//
						curMember = member;
						break;
				}
				if (context != FlagType.Function && !inParams) curMethod = null;
				curComment = null;
                curNamespace = "internal";
                curAccess = 0;
				modifiers = 0;
                modifiersLine = 0;
				tryPackage = false;
			}
			return false;
		}
		#endregion
		
		#region tool methods
		private String LastStringToken(string token, string separator)
		{
			int p = token.LastIndexOf(separator);
			return (p >= 0) ? token.Substring(p+1) : token;
		}
		#endregion
	}
}
