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
using System.Collections.Specialized;
using System.Text.RegularExpressions;
using System.Diagnostics;

namespace ASCompletion
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
		#region interface with application
		static private IASContext asContext;
		
		static public IASContext Context
		{
			get { return asContext; }
			set { asContext = value; }
		}
		#endregion
		
		#region Regular expressions
		static public readonly RegexOptions ro_cm =
			RegexOptions.Compiled | RegexOptions.Multiline;
		static public readonly RegexOptions ro_cs =
			RegexOptions.Compiled | RegexOptions.Singleline;
		static public readonly Regex re_splitFunction =
			new Regex("(?<keys>[\\w\\s]*)[\\s]function[\\s]*(?<fname>[^(]*)\\((?<params>[^()]*)\\)(?<type>.*)", ro_cs);
		static public readonly Regex re_variableType =
			new Regex("[\\s]*:[\\s]*(?<type>[\\w.]+)", ro_cs);
		static public readonly Regex re_balancedBraces =
			new Regex("{[^{}]*(((?<Open>{)[^{}]*)+((?<Close-Open>})[^{}]*)+)*(?(Open)(?!))}", ro_cs);
		
		static private Regex re_tip =
			new Regex("@tiptext[\\s](?<tip>[^@]*)", RegexOptions.Compiled);
		static private Regex re_cleanTip =
			new Regex("[\r\n]*[\\s]*\\*[\\s]*", RegexOptions.Compiled);
		
		static private Regex re_typedArray = 
			new Regex("^[\\w]*$", RegexOptions.Compiled);
		#endregion

		static private PathModel parentPath;
		static private DateTime cacheLastWriteTime;

		static public int ParseCacheFile(PathModel inPath, string file)
		{
			parentPath = inPath;
			ParseFile(file);
			parentPath = null;
			return 0;
		}
		
		static public FileModel ParseFile(string file)
		{
			FileModel fileModel = new FileModel(file);
			return ParseFile(fileModel);
		}
		
		static public FileModel ParseFile(FileModel fileModel)
		{
			string src;
			using( StreamReader sr = new StreamReader(fileModel.FileName) )
			{
				src = sr.ReadToEnd();
				sr.Close();
			}
			ASFileParser parser = new ASFileParser();
			try
			{
				fileModel.LastWriteTime = File.GetLastWriteTime(fileModel.FileName);
				if (parentPath != null) 
					cacheLastWriteTime = fileModel.LastWriteTime;
				parser.ParseSrc(fileModel, src);
			}
			catch(Exception ex)
			{
				System.Windows.Forms.MessageBox.Show("Error while parsing the file:\n"+fileModel.FileName, "Error: "+ex.Message, 
				                                    System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Error);
			}
			return fileModel;
		}
		
		#region main code parser
		
		const int COMMENTS_BUFFER = 1024;
		const int TOKEN_BUFFER = 1024;
		const int VALUE_BUFFER = 1024;
		
		// parser context
		private FileModel model;
		private int version;
		private bool haXe;
		private bool tryPackage;
		private FlagType context;
		private FlagType modifiers;
		private FlagType curModifiers;
		//private int modifiersPos;
		private int modifiersLine;
		private bool foundColon;
		private bool inParams;
		private bool inEnum;
		private bool inValue;
		private bool inType;
		private FlagType foundKeyword;
		private Token valueKeyword;
		private Token curToken;
		private Token prevToken;
		private MemberModel curMember;
		private MemberModel curMethod;
		private string curNamespace;
		private ClassModel curClass;
		private string lastComment;
		private string curComment;

		private void ParseSrc(FileModel fileModel, string ba)
		{
			model = fileModel;
			if (model.haXe) model.Enums.Clear();
			model.Classes.Clear();
			model.Members.Clear();
			
			// state
			int len = ba.Length;
			if (len < 0)
				return;
			int i = 0;
			int line = 0;
			
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
			haXe = model.haXe;
			version = (haXe)? 4 : 1;
			curToken = new Token();
			prevToken = new Token();
			int tokPos = 0;
			int tokLine = 0;
			curMethod = null;
			curMember = null;
			valueKeyword = null;
			curModifiers = 0;
			curNamespace = "public";

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
			inValue = false;
			inType = false;

			bool addChar = false;
			int evalToken = 0;
			bool evalKeyword = true;
			context = 0;
			modifiers = 0;
			foundColon = false;

			while (i < len)
			{
				c1 = ba[i++];
				isInString = (inString > 0);

				/* MATCH COMMENTS / STRING LITTERALS */

				switch (matching)
				{
					// look for comment block/line and preprocessor commands
					case 0:
						if (!isInString)
						{
							// new comment
							if (c1 == '/')
							{
								c2 = ba[i];
								if (c2 == '/') {
									matching = 1;
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
							else if (c1 == '#')
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
							if (c1 == '\\') i++;
							else if ((inString == 1) && (c1 == '"')) inString = 0;
							else if ((inString == 2) && (c1 == '\'')) inString = 0;
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
								// TODO Store haXe directives in model
								
								// FD cache custom directive
								if (parentPath != null && directive.StartsWith("file-cache "))
								{
									model.Version = version;
									model = new FileModel(directive.Substring(11), cacheLastWriteTime);
									parentPath.AddFile(model);
									goto resetParser;
								}
							}
							commentLength = 0;							
							inCode = true;
							matching = 0;
						}
						break;

				}

				/* LINE/COLUMN NUMBER */

				if (c1 == 10 || c1 == 13)
				{
					line++;
					if (c1 == 13 && ba[i] == 10) i++;
				}


				/* SKIP CONTENT */

				if (!inCode)
				{
					// store comments
					if (matching == 2 || (matching == 3 && (haXe || parentPath != null)))
					{
						if (commentLength < COMMENTS_BUFFER) commentBuffer[commentLength++] = c1;
					}
					continue;
				}
				else if (isInString)
				{
					// store parameter default value
					if (inParams && inValue && valueLength < VALUE_BUFFER) valueBuffer[valueLength++] = c1;
					continue;
				}
				if (braceCount > 0)
				{
					if (c1 == '}')
					{
						braceCount--;
						if (braceCount == 0 && curMethod != null)
						{
							//Debug.WriteLine("} "+curMethod.Name+" @"+line);
							curMethod.LineTo = line;
							curMethod = null;
						}
					}
					else if (c1 == '{') braceCount++;
					continue;
				}


				/* PARSE DECLARATION VALUES/TYPES */

				if (inValue)
				{
					if (c1 == '{') paramBraceCount++;
					else if (c1 == '}'&& paramBraceCount > 0)
					{
						paramBraceCount--;
						if (paramBraceCount == 0 && paramParCount == 0 && paramSqCount == 0 && valueLength < VALUE_BUFFER) 
							valueBuffer[valueLength++] = '}';
					}
					else if (c1 == '(') paramParCount++;
					else if (c1 == ')'&& paramParCount > 0) paramParCount--;
					else if (c1 == '(') paramSqCount++;
					else if (c1 == ')' && paramSqCount > 0) paramSqCount--;
					else if (paramTempCount > 0)
					{
						if (c1 == '<') paramTempCount++;
						else if (c1 == '>') paramTempCount--;
					}

					// end of value
					if ( paramBraceCount == 0 && paramParCount == 0 && paramSqCount == 0 && paramTempCount == 0
					    && (c1 == ',' || c1 == ';' || c1 == '}' || (inParams && c1 == ')') || inType) )
					{
						inValue = false;
						length = 0;
						if (inType) valueBuffer[valueLength++] = c1;
					}

					// in params, store the default value
					else if ((inParams || inType) && valueLength < VALUE_BUFFER)
					{
						if (c1 < 32)
						{
							if (valueLength > 0 && valueBuffer[valueLength-1] != ' ') valueBuffer[valueLength++] = ' ';
						}
						else valueBuffer[valueLength++] = c1;
					}

					// only try to detect keywords
					if (c1 < 'a' || c1 > 'z')
					{
						hadWS = true;
						continue;
					}
				}
				// store parameter value
				if (!inValue && valueLength > 0)
				{
					string param = new string(valueBuffer, 0, valueLength);
					
					if (valueKeyword != null)
					{
						int p = param.LastIndexOf(valueKeyword.Text);
						if (p > 0) param = param.Substring(0,p).TrimEnd();
					}
					//
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
							EvalToken(true, false, i-1-valueLength);
							evalKeyword = true;
							evalToken = 0;
						}
					}
					else if (inType)
					{
						//Debug.WriteLine("      : "+param);
						//
						foundColon = false;
						curMember.Type = param;
					}
					else
					{
						//Debug.WriteLine("      = "+param);
						//
						curMember.Parameters = new ArrayList();
						curMember.Parameters.Add(param);
					}
					//
					valueLength = 0;
					length = 0;
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
					}
					else continue;
				}
				else
				{
					// should we evaluate the token?
					if (hadWS && !hadDot && length > 0)
					{
						evalToken = (evalKeyword) ? 1 : 2;
					}
					hadWS = false;
					hadDot = false;

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
							// haXe template types
							else if (haXe && c1 == '<')
							{
								inValue = true;
								inType = true;
								valueLength = 0;
								for(int j=0; j<length; j++)
									valueBuffer[valueLength++] = buffer[j];
								valueBuffer[valueLength++] = c1;
								length = 0;
								paramBraceCount = 0;
								paramParCount = 0;
								paramSqCount = 0;
								paramTempCount = 1;
								continue;
							}
							else
							{
								evalToken = (evalKeyword) ? 1 : 2;
							}
						}
						// star is valid in import statements
						else if (c1 == '*' && version == 3 && !foundColon)
						{
							addChar = true;
						}

						// these chars are not valid in keywords
						if (length > 0) evalKeyword = false;
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
						EvalToken(!inValue, (evalToken == 1), i-1-length);
						length = 0;
						evalKeyword = true;
						evalToken = 0;
					}

					// start of block
					if (c1 == '{')
					{
						if (context == FlagType.Package || context == FlagType.Class)
						{
						}
						else if (context == FlagType.Enum)
						{
							inEnum = true;
						}
						else if (foundColon && haXe && length == 0)
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
						else 
						{
							braceCount++;
							//Debug.WriteLine("{"+braceCount);
						}
					}
					
					// end of block
					else if (c1 == '}')
					{
						// outside of a method, the '}' ends the current class
						if (curClass != null)
						{
							//Debug.WriteLine("} class "+curClass+" @"+line);
							if (curClass != null) curClass.LineTo = line;
							curClass = null;
							tryPackage = true;
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
						if (context == FlagType.Variable)
							foundKeyword = FlagType.Variable;
					}
					
					else if (c1 == '(')
					{
						// beginning of method parameters
						if (context == FlagType.Function)
						{
							context = FlagType.Variable;
							inParams = true;
							if (curMember == null)
							{
								context = FlagType.Function;
								if ((curModifiers & FlagType.Getter) > 0) 
								{
									curModifiers -= FlagType.Getter;
									EvalToken(true, false, i);
									curMethod = curMember;
								}
								else if ((curModifiers & FlagType.Setter) > 0) 
								{
									curModifiers -= FlagType.Setter;
									EvalToken(true, false, i);
									curMethod = curMember;
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
								Debug.WriteLine("{ "+curMember.Name);
							}
						}
						
						// an Enum value with parameters
						else if (inEnum && curToken != null)
						{
							//Debug.WriteLine("********** enum construc "+curToken);
							context = FlagType.Variable;
							inParams = true;
							curMethod = new MemberModel();
							curMethod.Name = curToken.Text;
							curMethod.Flags = curModifiers | FlagType.Function | FlagType.Enum;
							//
							if (curClass != null) curClass.Members.Add(curMethod);
						}
					}
					
					// end of statement
					else if (c1 == ';')
					{
						context = 0;
						modifiers = 0;
						inParams = false;
						curMember = null;
						//curMethod = null;
					}
					
					// end of method parameters
					else if (c1 == ')' && inParams)
					{
						context = (inEnum) ? FlagType.Enum : 0;
						modifiers = 0;
						inParams = false;
						curMember = curMethod;
					}
					
					// skip value of a declared variable
					else if (c1 == '=' && context == FlagType.Variable)
					{
						if (!inValue)
						{
							inValue = true;
							inType = false;
							paramBraceCount = 0;
							paramParCount = 0;
							paramSqCount = 0;
							paramTempCount = 0;
							valueLength = 0;
						}
					}
					
					// special haXe types: T -> T
					else if (haXe && c1 == '-' && curMember != null)
					{
						if (ba[i] == '>')
						{
							curMember.Type += " ->";
						}
					}
					
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
			model.Version = version;
		}
		
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
			string token = curToken.Text;
			Debug.WriteLine("\t\t\t\t\t'"+token+"' @"+curToken.Position+" ("+evalKeyword+") after "+context);

			/* KEYWORD EVALUATION */

			if (evalKeyword && (token.Length > 2))
			{
				// members
				if (token == "var")
				{
					foundKeyword = FlagType.Variable;
				}
				else if (token == "function")
				{
					foundKeyword = FlagType.Function;
				}
				else if (haXe && token == "property")
				{
					foundKeyword = FlagType.Function;
					modifiers |= FlagType.HXProperty;
				}
				else if (version == 3 && token == "const")
				{
					foundKeyword = FlagType.Variable;
					modifiers |= FlagType.Constant;
				}
				else if (version == 3 && token == "namespace")
				{
					foundKeyword = FlagType.Namespace;
				}
				
				// class declaration
				else if (tryPackage && token == "package")
				{
					foundKeyword = FlagType.Package;
					if (version < 3)
					{
						version = 3;
						model.Namespaces.Insert(1, "protected");
						model.Namespaces.Add("internal");
					}
				}
				else if (token == "class")
				{
					foundKeyword = FlagType.Class;
					if (version == 1) version = 2;
				}
				else if (token == "interface")
				{
					foundKeyword = FlagType.Class;
					modifiers |= FlagType.Interface;
					if (version == 1) version = 2;
				}
				else if (haXe && token == "enum")
				{
					foundKeyword = FlagType.Enum;
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

					// modifiers
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
					
					// namespace modifier
					foreach(string ns in model.Namespaces)
					if (token == ns)
					{
						curNamespace = token;
						foundModifier = FlagType.Namespace;
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

					// a declaration modifier was recognized
					if (foundModifier != 0)
					{
						if (inParams && inValue) valueKeyword = new Token(curToken);
						inParams = false;
						inEnum = false;
						inValue = false;
						inType = false;
						foundColon = false;
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
				if (inParams && inValue) valueKeyword = new Token(curToken);
				inParams = false;
				inEnum = false;
				inValue = false;
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
			else if (!evalContext)
				return false;


			/* EVAL DECLARATION */

			if (foundColon && curMember != null)
			{
				foundColon = false;
				//Debug.WriteLine("   "+curMember.Name+":/*"+lastComment+"*/"+curToken);
				curMember.Type = curToken.Text;
				curMember.LineTo = curToken.Line;
				// Typed Arrays
				if (curMember.Type == "Array" && lastComment != null && re_typedArray.IsMatch(lastComment))
				{
					curMember.Type = "/*"+lastComment+"*/Array";
				}
			}
			else if (hadContext && (hadKeyword || inParams))
			{
				//if (curModifiers != 0)
					//Debug.WriteLine("                @"+modifiersLine+" "+modifiersPos+" *");
				//else
					//Debug.WriteLine("                @"+curToken.Line+" "+curToken.Position);

				if (curComment != null && context != FlagType.Import)
				{
					curComment = curComment.Trim();
					Match mTip = re_tip.Match(curComment+"@");
					if (mTip.Success)
					{
						//Debug.WriteLine("@tiptext: "+re_cleanTip.Replace(mTip.Groups["tip"].Value, " ").Trim());
					}
					////Debug.WriteLine("\t/**"+curComment+"*/");
				}

				MemberModel member;
				switch (context)
				{
					case FlagType.Package:
						//Debug.WriteLine("package "+token);
						//
						if (prevToken.Text == "package")
						{
							model.Package = token;
						}
						break;
						
					case FlagType.Namespace:
						//Debug.WriteLine("namespace "+token);
						//
						if (prevToken.Text == "namespace")
						{
							model.Namespaces.Add(token);
						}
						break;

					case FlagType.Import:
						//Debug.WriteLine("import "+token+" ("+prevToken.Text+")");
						//
						if (prevToken.Text == "import")
						{
							member = new MemberModel();
							member.Name = LastStringToken(token, ".");
							member.Type = token;
							model.Imports.Add(member);
						}
						break;

					case FlagType.Class:
						if (curModifiers == FlagType.Extends)
						{
							//Debug.WriteLine("extends "+token);
							// TODO  Get extended class from context
							/*if (curClass != null)
							{
								ClassModel exClass = new ClassModel();
								exClass.ClassName = token;
								curClass.Extends = exClass;
							}*/
						}
						else if (curModifiers == FlagType.Implements)
						{
							//Debug.WriteLine("implements "+token);
							/*if (curClass != null)
							{
								if (curClass.Implements == null) curClass.Implements = new ArrayList();
								// TODO  Get implemented class from context
								ClassModel impClass = new ClassModel();
								impClass.ClassName = token;
								curClass.Implements.Add(impClass);
							}*/
						}
						else if (prevToken.Text == "class" || prevToken.Text == "interface")
						{
							//Debug.WriteLine(curNamespace+" "+curModifiers+" class "+token);
							//
							if (curClass != null)
							{
								curClass.LineTo = (curModifiers != 0) ? modifiersLine-1 : curToken.Line-1;
							}
							// check classname
							int p = token.LastIndexOf('.');
							if (p > 0) 
							{
								if (version < 3)
								{
									string package = token.Substring(0, p);
									model.Package = package;
									token = token.Substring(p+1);
								}
								else
								{
									//TODO  Error: AS3 & haXe classes are qualified by their package declaration
								}
							}
							curClass = new ClassModel();
							model.Classes.Add(curClass);
							curClass.InFile = model;
							curClass.Comments = curComment;
							curClass.ClassName = token;
							curClass.Constructor = (haXe) ? "new" : token;
							curClass.Flags = curModifiers;
							curClass.Namespace = curNamespace;
							curClass.LineFrom = (curModifiers != 0) ? modifiersLine : curToken.Line;
							curClass.LineTo = curToken.Line;
						}
						else 
						{
							context = 0;
							modifiers = 0;
						}
						break;

					case FlagType.Enum:
						if (inEnum)
						{
							//Debug.WriteLine("value "+token);
							//
							member = new MemberModel();
							member.Comments = curComment;
							member.Name = token;
							member.Flags = curModifiers | FlagType.Variable | FlagType.Enum;
							member.Namespace = curNamespace;
							member.LineFrom = member.LineTo = curToken.Line;
							//curClass.Vars.Add(member);
							curClass.Members.Add(member);
							//
							curMember = member;
						}
						else
						{
							//Debug.WriteLine(curNamespace+" "+curModifiers+" enum "+token);
							//
							if (curClass != null)
							{
								curClass.LineTo = (curModifiers != 0) ? modifiersLine-1 : curToken.Line-1;
							}
							curClass = new ClassModel();
							model.Enums.Add(curClass);
							curClass.InFile = model;
							curClass.Comments = curComment;
							curClass.ClassName = token;
							curClass.Flags = curModifiers | FlagType.Enum;
							curClass.Namespace = curNamespace;
							curClass.LineFrom = (curModifiers != 0) ? modifiersLine : curToken.Line;
							curClass.LineTo = curToken.Line;
						}
						break;

					case FlagType.Variable:
						/*if (inParams && curMethod != null)
						{
							if (inEnum)
								Debug.WriteLine("   *"+curMethod.Name+"("+token);
							else
								Debug.WriteLine("   "+curMethod.Name+"("+token);
						}
						else Debug.WriteLine(curNamespace+" "+curModifiers+" var "+token);*/
						//
						// haXe type: T -> T
						if (haXe && curMember != null && curMember.Type != null && curMember.Type.EndsWith("->"))
						{
							curMember.Type += " "+token;
							return false;
						}
						else
						{
							member = new MemberModel();
							member.Comments = curComment;
							member.Name = token;
							member.Flags = curModifiers | FlagType.Variable;
							member.Namespace = curNamespace;
							member.LineFrom = (curModifiers != 0) ? modifiersLine : curToken.Line;
							member.LineTo = curToken.Line;
							//
							// method parameter
							if (inParams && curMethod != null)
							{
								if (inEnum) member.Flags |= FlagType.Enum;
								if (curMethod.Parameters == null) curMethod.Parameters = new ArrayList();
								curMethod.Parameters.Add(member);
							}
							// class member
							else if (curClass != null) 
							{
								//curClass.Vars.Add(member);
								curClass.Members.Add(member);
							}
							// package member
							else model.Members.Add(member);
							//
							curMember = member;
						}
						break;

					case FlagType.Function:
						//Debug.WriteLine("{"+curNamespace+" "+curModifiers+" function "+token);
						//
						member = new MemberModel();
						member.Comments = curComment;
						member.Name = token;
						member.Flags = curModifiers | FlagType.Function;
						member.Namespace = curNamespace;
						member.LineFrom = (curModifiers != 0) ? modifiersLine : curToken.Line;
						member.LineTo = curToken.Line;
						//
						if (curClass != null)
						{
							if (token == curClass.Constructor) member.Flags |= FlagType.Constructor;
							//if ((curModifiers & (FlagType.Getter | FlagType.Setter)) > 0) curClass.Properties.Add(member);
							//else curClass.Methods.Add(member);
							curClass.Members.Add(member);
						}
						else model.Members.Add(member);
						//
						curMember = member;
						break;
				}
				if (context != FlagType.Function && !inParams) curMethod = null;
				curComment = null;
				curNamespace = "public";
				modifiers = 0;
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
