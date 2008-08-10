using System;
using System.Windows.Forms;

namespace ScintillaNet.Enums
{	
	public enum Position
	{
		Invalid = -1
	}
	
	public enum Command
	{
		Change = 768,
		SetFocus = 512,
		KillFocus = 256
	}
	
	public enum StartMsg
	{
		Initial = 2000,
		Optional = 3000,
		Lexer = 4000
	}
	
	public enum BeepType
	{
		Default = -1,
		Ok = 0x00000000,
		Information = 0x00000040,
		Question = 0x00000020,
		Warning = 0x00000030,
		Error = 0x00000010
	}
	
	public enum MarkerSymbol
    {    
		Circle = 0,
		Roundrect = 1,
		Arrow = 2,
		SmallRect = 3,
		ShortArrow = 4,
		Empty = 5,
		ArrowDown = 6,
		Minus = 7,
		Plus = 8,
		VLine = 9,
		LCorner = 10,
		TCorner = 11,
		BoxPlus = 12,
		BoxPlusConnected = 13,
		BoxMinus = 14,
		BoxMinusConnected = 15,
		LCornerCurve = 16,
		TCornerCurve = 17,
		CirclePlus = 18,
		CirclePlusConnected = 19,
		CircleMinus = 20,
		CircleMinusConnected = 21,
		Background = 22,
		DotDotDot = 23,
		Arrows = 24,
		Pixmap = 25,
		Fullrect = 26
    }
    
    public enum MarkerOutline
    {    
        FolderEnd = 25,
        FolderOpenMid = 26,
        FolderMidTail = 27,
        FolderTail = 28,
        FolderSub = 29,
        Folder = 30,
        FolderOpen = 31
    }
    
    public enum MarginType
    {    
        Symbol = 0,
        Number = 1
    }
    
	public enum WhiteSpace
    {    
        Invisible = 0,
        VisibleAlways = 1,
        VisibleAfterIndent = 2
    }
   
	public enum EndOfLine
    {    
        CRLF = 0,
        CR = 1,
        LF = 2
    }
	
    public enum StylesCommon
    {    
        Default = 32,
        LineNumber = 33,
        BraceLight = 34,
        BraceBad = 35,
        ControlChar = 36,
        IndentGuide = 37,
        LastPredefined = 39,
        Max = 127
    }
    
    public enum CharacterSet
    {    
		Ansi = 0,
		Default = 1,
		Baltic = 186,
		ChineseBig5 = 136,
		EastEurope = 238,
		GB2312 = 134,
		Greek = 161,
		Hangul = 129,
		MAC = 77,
		OEM = 255,
		Russian = 204,
		Cyrillic = 1251,
		ShiftJIS = 128,
		Symbol = 2,
		Turkish = 162,
		Johab = 130,
		Hebrew = 177,
		Arabic = 178,
		Vietnamese = 163,
		Thai = 222,
		Latin9 = 1000
    }
    
    public enum CaseVisible
    {    
        Mixed = 0,
        Upper = 1,
        Lower = 2
    }
    
    public enum IndicatorStyle
    {    
		Plain = 0,
		Squiggle = 1,
		TT = 2,
		Diagonal = 3,
		Strike = 4,
		Hidden = 5,
		Box = 6,
		Max = 7,
		Mask0 = 0x20,
		Mask1 = 0x40,
		Mask2 = 0x80,
		MaskS = 0xE0
    }
    
    public enum PrintOption
    {    
        Normal = 0,
        InvertLight = 1,
        BlackOnWhite = 2,
        ColourOnWhite = 3,
        ColourOnWhiteDefaultBG = 4
    }
    
    public enum FindOption
    {    
        WholeWord = 2,
        MatchCase = 4,
        WordStart = 0x00100000,
        REGEXP = 0x00200000,
        POSIX = 0x00400000
    }
    
    public enum FoldLevel
    {    
		Base = 0x400,
		WhiteFlag = 0x1000,
		HeaderFlag = 0x2000,
		BoxHeaderFlag = 0x4000,
		BoxFooterFlag = 0x8000,
		Contracted = 0x10000,
		Unindent = 0x20000,
		NumberMask = 0x0FFF
    }
    
    public enum FoldFlag
    {    
        LineBeforeExpanded = 0x0002,
        LineBeforeContracted = 0x0004,
        LineAfterExpanded = 0x0008,
        LineAfterContracted = 0x0010,
        LevelNumbers = 0x0040,
        Box = 0x0001
    }
    
    public enum Wrap
    {    
        None = 0,
        Word = 1,
		Char = 2
    }
    
    public enum WrapVisualFlag
    {    
        None = 0x0000,
        End = 0x0001,
        Start = 0x0002
    }
    
    public enum WrapVisualLocation
    {    
        Default = 0x0000,
        EndByText = 0x0001,
        StartByText = 0x0002
    }
    
    public enum LineCache
    {    
        None = 0,
        Caret = 1,
        Page = 2,
        Document = 3
    }
    
    public enum EdgeVisualStyle
    {    
        None = 0,
        Line = 1,
        Background = 2
    }
    
    public enum CursorShape
    {    
        Normal = -1,
        Wait = 4
    }
    
    public enum CaretPolicy
    {    
        Slop = 0x01,
        Strict = 0x04,
        Jumps = 0x10,
        Even = 0x08
    }
    
    public enum VisiblePolicy
    {
    	Slop = 0x01,
		Strict = 0x04
    }
    
    public enum SelectionMode
    {    
        Stream = 0,
        Rectangle = 1,
        Lines = 2
    }
    
    public enum ModificationFlags
    {    
		InsertText = 0x1,
		DeleteText = 0x2,
		ChangeStyle = 0x4,
		ChangeFold = 0x8,
		UserPerformed = 0x10,
		UndoPerformed = 0x20,
		RedoPerformed = 0x40,
		MultiStepUndoRedo = 0x80,
		LastStepInUndoRedo = 0x100,
		ChangeMarker = 0x200,
		BeforeInsert = 0x400,
		BeforeDelete = 0x800,
		MultiLineUndoRedo = 0x1000,
		EventMaskAll = 0x1FFF
    }
    
    public enum Keys
    {    
		Down = 300,
		Up = 301,
		Left = 302,
		Right = 303,
		Home = 304,
		End = 305,
		Prior = 306,
		Next = 307,
		Delete = 308,
		Insert = 309,
		Escape = 7,
		Back = 8,
		Tab = 9,
		Return = 13,
		Add = 310,
		Subtract = 311,
		Divide = 312,
    }
    
    public enum ModifierKey
    {    
		Norm = 0,
		Shift = 1,
		Ctrl = 2,
		Alt = 4
    }
    
	public enum ScintillaEvents
	{    
		StyleNeeded = 2000,
		CharAdded = 2001,
		SavePointReached = 2002,
		SavePointLeft = 2003,
		ModifyAttemptRO = 2004,
		Key = 2005,
		DoubleClick = 2006,
		UpdateUI = 2007,
		Modified = 2008,
		MacroRecord = 2009,
		MarginClick = 2010,
		NeedShown = 2011,
		Painted = 2013,
		UserListSelection = 2014,
		URIDropped = 2015,
		DwellStart = 2016,
		DwellEnd = 2017,
		Zoom = 2018,
		HotspotClick = 2019,
		HotspotDoubleClick = 2020,
		CalltipClick = 2021,
		AutoCSelection = 2022
	}
	
	public enum Lexer
    {    
		CONTAINER = 0,
		NULL = 1,
		PYTHON = 2,
		CPP = 3,
		HTML = 4,
		XML = 5,
		PERL = 6,
		SQL = 7,
		VB = 8,
		PROPERTIES = 9,
		ERRORLIST = 10,
		MAKEFILE = 11,
		BATCH = 12,
		XCODE = 13,
		LATEX = 14,
		LUA = 15,
		DIFF = 16,
		CONF = 17,
		PASCAL = 18,
		AVE = 19,
		ADA = 20,
		LISP = 21,
		RUBY = 22,
		EIFFEL = 23,
		EIFFELKW = 24,
		TCL = 25,
		NNCRONTAB = 26,
		BULLANT = 27,
		VBSCRIPT = 28,
		BAAN = 31,
		MATLAB = 32,
		SCRIPTOL = 33,
		ASM = 34,
		CPPNOCASE = 35,
		FORTRAN = 36,
		F77 = 37,
		CSS = 38,
		POV = 39,
		LOUT = 40,
		ESCRIPT = 41,
		PS = 42,
		NSIS = 43,
		MMIXAL = 44,
		CLW = 45,
		CLWNOCASE = 46,
		LOT = 47,
		YAML = 48,
		TEX = 49,
		METAPOST = 50,
		POWERBASIC = 51,
		FORTH = 52,
		ERLANG = 53,
		OCTAVE = 54,
		MSSQL = 55,
		VERILOG = 56,
		KIX = 57,
		GUI4CLI = 58,
		SPECMAN = 59,
		AU3 = 60,
		APDL = 61,
		BASH = 62,
		ASN1 = 63,
		VHDL = 64,
		CAML = 65,
		BLITZBASIC = 66,
		PUREBASIC = 67,
		HASKELL = 68,
		PHPSCRIPT = 69,
		TADS3 = 70,
		REBOL = 71,
		SMALLTALK = 72,
		FLAGSHIP = 73,
		CSOUND = 74,
		FREEBASIC = 75,
		AUTOMATIC = 1000
    }
	
   	public enum SmartIndent
	{
		None = 0,
		CPP = 1,
		Simple = 2,
		Custom = 3
	}
   	
   	public enum DeviceCap
	{
		DRIVERVERSION = 0,
		TECHNOLOGY = 2,
		HORZSIZE = 4,
		VERTSIZE = 6,
		HORZRES = 8,
		VERTRES = 10,
		BITSPIXEL = 12,
		PLANES = 14,
		NUMBRUSHES = 16,
		NUMPENS = 18,
		NUMMARKERS = 20,
		NUMFONTS = 22,
		NUMCOLORS = 24,
		PDEVICESIZE = 26,
		CURVECAPS = 28,
		LINECAPS = 30,
		POLYGONALCAPS = 32,
		TEXTCAPS = 34,
		CLIPCAPS = 36,
		RASTERCAPS = 38,
		ASPECTX = 40,
		ASPECTY = 42,
		ASPECTXY = 44,
		LOGPIXELSX = 88,
		LOGPIXELSY = 90,
		SIZEPALETTE = 104,
		NUMRESERVED = 106,
		COLORRES = 108,
		PHYSICALWIDTH = 110,
		PHYSICALHEIGHT = 111,
		PHYSICALOFFSETX = 112,
		PHYSICALOFFSETY = 113,
		SCALINGFACTORX = 114,
		SCALINGFACTORY = 115
	}
   		
}
