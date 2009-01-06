package flash.ui
{
	/// The Keyboard class is used to build an interface that can be controlled by a user with a standard keyboard.
	public class Keyboard extends Object
	{
		/// [AIR] Constant associated with the key code value for the A key (65).
		public static const A : uint;
		/// [AIR] Constant associated with the key code value for the Alternate (Option) key (18).
		public static const ALTERNATE : uint;
		/// [AIR] Constant associated with the key code value for the B key (66).
		public static const B : uint;
		/// [AIR] Constant associated with the key code value for the ` key (192).
		public static const BACKQUOTE : uint;
		/// [AIR] Constant associated with the key code value for the \ key (220).
		public static const BACKSLASH : uint;
		/// Constant associated with the key code value for the Backspace key (8).
		public static const BACKSPACE : uint;
		/// Constant associated with the key code value for the C key (67).
		public static const C : uint;
		/// Constant associated with the key code value for the Caps Lock key (20).
		public static const CAPS_LOCK : uint;
		/// [AIR]
		public static const CharCodeStrings : Array;
		/// [AIR] Constant associated with the key code value for the , key (188).
		public static const COMMA : uint;
		/// [AIR] Constant associated with the Mac command key (15).
		public static const COMMAND : uint;
		/// Constant associated with the key code value for the Control key (17).
		public static const CONTROL : uint;
		/// [AIR] Constant associated with the key code value for the D key (68).
		public static const D : uint;
		/// Constant associated with the key code value for the Delete key (46).
		public static const DELETE : uint;
		/// Constant associated with the key code value for the Down Arrow key (40).
		public static const DOWN : uint;
		/// [AIR] Constant associated with the key code value for the E key (69).
		public static const E : uint;
		/// Constant associated with the key code value for the End key (35).
		public static const END : uint;
		/// Constant associated with the key code value for the Enter key (13).
		public static const ENTER : uint;
		/// [AIR] Constant associated with the key code value for the = key (187).
		public static const EQUAL : uint;
		/// Constant associated with the key code value for the Escape key (27).
		public static const ESCAPE : uint;
		/// [AIR] Constant associated with the key code value for the F key (70).
		public static const F : uint;
		/// Constant associated with the key code value for the F1 key (112).
		public static const F1 : uint;
		/// Constant associated with the key code value for the F10 key (121).
		public static const F10 : uint;
		/// Constant associated with the key code value for the F11 key (122).
		public static const F11 : uint;
		/// Constant associated with the key code value for the F12 key (123).
		public static const F12 : uint;
		/// Constant associated with the key code value for the F13 key (124).
		public static const F13 : uint;
		/// Constant associated with the key code value for the F14 key (125).
		public static const F14 : uint;
		/// Constant associated with the key code value for the F15 key (126).
		public static const F15 : uint;
		/// Constant associated with the key code value for the F2 key (113).
		public static const F2 : uint;
		/// Constant associated with the key code value for the F3 key (114).
		public static const F3 : uint;
		/// Constant associated with the key code value for the F4 key (115).
		public static const F4 : uint;
		/// Constant associated with the key code value for the F5 key (116).
		public static const F5 : uint;
		/// Constant associated with the key code value for the F6 key (117).
		public static const F6 : uint;
		/// Constant associated with the key code value for the F7 key (118).
		public static const F7 : uint;
		/// Constant associated with the key code value for the F8 key (119).
		public static const F8 : uint;
		/// Constant associated with the key code value for the F9 key (120).
		public static const F9 : uint;
		/// [AIR] Constant associated with the key code value for the G key (71).
		public static const G : uint;
		/// [AIR] Constant associated with the key code value for the H key (72).
		public static const H : uint;
		/// Constant associated with the key code value for the Home key (36).
		public static const HOME : uint;
		/// [AIR] Constant associated with the key code value for the I key (73).
		public static const I : uint;
		/// Constant associated with the key code value for the Insert key (45).
		public static const INSERT : uint;
		/// [AIR] Constant associated with the key code value for the J key (74).
		public static const J : uint;
		/// [AIR] Constant associated with the key code value for the K key (75).
		public static const K : uint;
		/// [AIR]
		public static const KEYNAME_BEGIN : String;
		/// [AIR]
		public static const KEYNAME_BREAK : String;
		/// [AIR]
		public static const KEYNAME_CLEARDISPLAY : String;
		/// [AIR]
		public static const KEYNAME_CLEARLINE : String;
		/// [AIR]
		public static const KEYNAME_DELETE : String;
		/// [AIR]
		public static const KEYNAME_DELETECHAR : String;
		/// [AIR]
		public static const KEYNAME_DELETELINE : String;
		/// [AIR]
		public static const KEYNAME_DOWNARROW : String;
		/// [AIR]
		public static const KEYNAME_END : String;
		/// [AIR]
		public static const KEYNAME_EXECUTE : String;
		/// [AIR]
		public static const KEYNAME_F1 : String;
		/// [AIR]
		public static const KEYNAME_F10 : String;
		/// [AIR]
		public static const KEYNAME_F11 : String;
		/// [AIR]
		public static const KEYNAME_F12 : String;
		/// [AIR]
		public static const KEYNAME_F13 : String;
		/// [AIR]
		public static const KEYNAME_F14 : String;
		/// [AIR]
		public static const KEYNAME_F15 : String;
		/// [AIR]
		public static const KEYNAME_F16 : String;
		/// [AIR]
		public static const KEYNAME_F17 : String;
		/// [AIR]
		public static const KEYNAME_F18 : String;
		/// [AIR]
		public static const KEYNAME_F19 : String;
		/// [AIR]
		public static const KEYNAME_F2 : String;
		/// [AIR]
		public static const KEYNAME_F20 : String;
		/// [AIR]
		public static const KEYNAME_F21 : String;
		/// [AIR]
		public static const KEYNAME_F22 : String;
		/// [AIR]
		public static const KEYNAME_F23 : String;
		/// [AIR]
		public static const KEYNAME_F24 : String;
		/// [AIR]
		public static const KEYNAME_F25 : String;
		/// [AIR]
		public static const KEYNAME_F26 : String;
		/// [AIR]
		public static const KEYNAME_F27 : String;
		/// [AIR]
		public static const KEYNAME_F28 : String;
		/// [AIR]
		public static const KEYNAME_F29 : String;
		/// [AIR]
		public static const KEYNAME_F3 : String;
		/// [AIR]
		public static const KEYNAME_F30 : String;
		/// [AIR]
		public static const KEYNAME_F31 : String;
		/// [AIR]
		public static const KEYNAME_F32 : String;
		/// [AIR]
		public static const KEYNAME_F33 : String;
		/// [AIR]
		public static const KEYNAME_F34 : String;
		/// [AIR]
		public static const KEYNAME_F35 : String;
		/// [AIR]
		public static const KEYNAME_F4 : String;
		/// [AIR]
		public static const KEYNAME_F5 : String;
		/// [AIR]
		public static const KEYNAME_F6 : String;
		/// [AIR]
		public static const KEYNAME_F7 : String;
		/// [AIR]
		public static const KEYNAME_F8 : String;
		/// [AIR]
		public static const KEYNAME_F9 : String;
		/// [AIR]
		public static const KEYNAME_FIND : String;
		/// [AIR]
		public static const KEYNAME_HELP : String;
		/// [AIR]
		public static const KEYNAME_HOME : String;
		/// [AIR]
		public static const KEYNAME_INSERT : String;
		/// [AIR]
		public static const KEYNAME_INSERTCHAR : String;
		/// [AIR]
		public static const KEYNAME_INSERTLINE : String;
		/// [AIR]
		public static const KEYNAME_LEFTARROW : String;
		/// [AIR]
		public static const KEYNAME_MENU : String;
		/// [AIR]
		public static const KEYNAME_MODESWITCH : String;
		/// [AIR]
		public static const KEYNAME_NEXT : String;
		/// [AIR]
		public static const KEYNAME_PAGEDOWN : String;
		/// [AIR]
		public static const KEYNAME_PAGEUP : String;
		/// [AIR]
		public static const KEYNAME_PAUSE : String;
		/// [AIR]
		public static const KEYNAME_PREV : String;
		/// [AIR]
		public static const KEYNAME_PRINT : String;
		/// [AIR]
		public static const KEYNAME_PRINTSCREEN : String;
		/// [AIR]
		public static const KEYNAME_REDO : String;
		/// [AIR]
		public static const KEYNAME_RESET : String;
		/// [AIR]
		public static const KEYNAME_RIGHTARROW : String;
		/// [AIR]
		public static const KEYNAME_SCROLLLOCK : String;
		/// [AIR]
		public static const KEYNAME_SELECT : String;
		/// [AIR]
		public static const KEYNAME_STOP : String;
		/// [AIR]
		public static const KEYNAME_SYSREQ : String;
		/// [AIR]
		public static const KEYNAME_SYSTEM : String;
		/// [AIR]
		public static const KEYNAME_UNDO : String;
		/// [AIR]
		public static const KEYNAME_UPARROW : String;
		/// [AIR]
		public static const KEYNAME_USER : String;
		/// [AIR] Constant associated with the key code value for the L key (76).
		public static const L : uint;
		/// Constant associated with the key code value for the Left Arrow key (37).
		public static const LEFT : uint;
		/// [AIR] Constant associated with the key code value for the [ key (219).
		public static const LEFTBRACKET : uint;
		/// [AIR] Constant associated with the key code value for the M key (77).
		public static const M : uint;
		/// [AIR] Constant associated with the key code value for the - key (189).
		public static const MINUS : uint;
		/// [AIR] Constant associated with the key code value for the N key (78).
		public static const N : uint;
		/// [AIR] Constant associated with the key code value for the 0 key (48).
		public static const NUMBER_0 : uint;
		/// [AIR] Constant associated with the key code value for the 1 key (49).
		public static const NUMBER_1 : uint;
		/// [AIR] Constant associated with the key code value for the 2 key (50).
		public static const NUMBER_2 : uint;
		/// [AIR] Constant associated with the key code value for the 3 key (51).
		public static const NUMBER_3 : uint;
		/// [AIR] Constant associated with the key code value for the 4 key (52).
		public static const NUMBER_4 : uint;
		/// [AIR] Constant associated with the key code value for the 5 key (53).
		public static const NUMBER_5 : uint;
		/// [AIR] Constant associated with the key code value for the 6 key (54).
		public static const NUMBER_6 : uint;
		/// [AIR] Constant associated with the key code value for the 7 key (55).
		public static const NUMBER_7 : uint;
		/// [AIR] Constant associated with the key code value for the 8 key (56).
		public static const NUMBER_8 : uint;
		/// [AIR] Constant associated with the key code value for the 9 key (57).
		public static const NUMBER_9 : uint;
		/// [AIR] Constant associated with the pseudo-key code for the the number pad (21).
		public static const NUMPAD : uint;
		/// Constant associated with the key code value for the number 0 key on the number pad (96).
		public static const NUMPAD_0 : uint;
		/// Constant associated with the key code value for the number 1 key on the number pad (97).
		public static const NUMPAD_1 : uint;
		/// Constant associated with the key code value for the number 2 key on the number pad (98).
		public static const NUMPAD_2 : uint;
		/// Constant associated with the key code value for the number 3 key on the number pad (99).
		public static const NUMPAD_3 : uint;
		/// Constant associated with the key code value for the number 4 key on the number pad (100).
		public static const NUMPAD_4 : uint;
		/// Constant associated with the key code value for the number 5 key on the number pad (101).
		public static const NUMPAD_5 : uint;
		/// Constant associated with the key code value for the number 6 key on the number pad (102).
		public static const NUMPAD_6 : uint;
		/// Constant associated with the key code value for the number 7 key on the number pad (103).
		public static const NUMPAD_7 : uint;
		/// Constant associated with the key code value for the number 8 key on the number pad (104).
		public static const NUMPAD_8 : uint;
		/// Constant associated with the key code value for the number 9 key on the number pad (105).
		public static const NUMPAD_9 : uint;
		/// Constant associated with the key code value for the addition key on the number pad (107).
		public static const NUMPAD_ADD : uint;
		/// Constant associated with the key code value for the decimal key on the number pad (110).
		public static const NUMPAD_DECIMAL : uint;
		/// Constant associated with the key code value for the division key on the number pad (111).
		public static const NUMPAD_DIVIDE : uint;
		/// Constant associated with the key code value for the Enter key on the number pad (108).
		public static const NUMPAD_ENTER : uint;
		/// Constant associated with the key code value for the multiplication key on the number pad (106).
		public static const NUMPAD_MULTIPLY : uint;
		/// Constant associated with the key code value for the subtraction key on the number pad (109).
		public static const NUMPAD_SUBTRACT : uint;
		/// [AIR] Constant associated with the key code value for the O key (79).
		public static const O : uint;
		/// [AIR] Constant associated with the key code value for the P key (80).
		public static const P : uint;
		/// Constant associated with the key code value for the Page Down key (34).
		public static const PAGE_DOWN : uint;
		/// Constant associated with the key code value for the Page Up key (33).
		public static const PAGE_UP : uint;
		/// [AIR] Constant associated with the key code value for the .
		public static const PERIOD : uint;
		/// [AIR] Constant associated with the key code value for the Q key (81).
		public static const Q : uint;
		/// [AIR] Constant associated with the key code value for the ' key (222).
		public static const QUOTE : uint;
		/// [AIR] Constant associated with the key code value for the R key (82).
		public static const R : uint;
		/// Constant associated with the key code value for the Right Arrow key (39).
		public static const RIGHT : uint;
		/// [AIR] Constant associated with the key code value for the ] key (221).
		public static const RIGHTBRACKET : uint;
		/// [AIR] Constant associated with the key code value for the S key (83).
		public static const S : uint;
		/// [AIR] Constant associated with the key code value for the ; key (186).
		public static const SEMICOLON : uint;
		/// Constant associated with the key code value for the Shift key (16).
		public static const SHIFT : uint;
		/// [AIR] Constant associated with the key code value for the / key (191).
		public static const SLASH : uint;
		/// Constant associated with the key code value for the Spacebar (32).
		public static const SPACE : uint;
		/// [AIR]
		public static const STRING_BEGIN : String;
		/// [AIR]
		public static const STRING_BREAK : String;
		/// [AIR]
		public static const STRING_CLEARDISPLAY : String;
		/// [AIR]
		public static const STRING_CLEARLINE : String;
		/// [AIR]
		public static const STRING_DELETE : String;
		/// [AIR]
		public static const STRING_DELETECHAR : String;
		/// [AIR]
		public static const STRING_DELETELINE : String;
		/// [AIR]
		public static const STRING_DOWNARROW : String;
		/// [AIR]
		public static const STRING_END : String;
		/// [AIR]
		public static const STRING_EXECUTE : String;
		/// [AIR]
		public static const STRING_F1 : String;
		/// [AIR]
		public static const STRING_F10 : String;
		/// [AIR]
		public static const STRING_F11 : String;
		/// [AIR]
		public static const STRING_F12 : String;
		/// [AIR]
		public static const STRING_F13 : String;
		/// [AIR]
		public static const STRING_F14 : String;
		/// [AIR]
		public static const STRING_F15 : String;
		/// [AIR]
		public static const STRING_F16 : String;
		/// [AIR]
		public static const STRING_F17 : String;
		/// [AIR]
		public static const STRING_F18 : String;
		/// [AIR]
		public static const STRING_F19 : String;
		/// [AIR]
		public static const STRING_F2 : String;
		/// [AIR]
		public static const STRING_F20 : String;
		/// [AIR]
		public static const STRING_F21 : String;
		/// [AIR]
		public static const STRING_F22 : String;
		/// [AIR]
		public static const STRING_F23 : String;
		/// [AIR]
		public static const STRING_F24 : String;
		/// [AIR]
		public static const STRING_F25 : String;
		/// [AIR]
		public static const STRING_F26 : String;
		/// [AIR]
		public static const STRING_F27 : String;
		/// [AIR]
		public static const STRING_F28 : String;
		/// [AIR]
		public static const STRING_F29 : String;
		/// [AIR]
		public static const STRING_F3 : String;
		/// [AIR]
		public static const STRING_F30 : String;
		/// [AIR]
		public static const STRING_F31 : String;
		/// [AIR]
		public static const STRING_F32 : String;
		/// [AIR]
		public static const STRING_F33 : String;
		/// [AIR]
		public static const STRING_F34 : String;
		/// [AIR]
		public static const STRING_F35 : String;
		/// [AIR]
		public static const STRING_F4 : String;
		/// [AIR]
		public static const STRING_F5 : String;
		/// [AIR]
		public static const STRING_F6 : String;
		/// [AIR]
		public static const STRING_F7 : String;
		/// [AIR]
		public static const STRING_F8 : String;
		/// [AIR]
		public static const STRING_F9 : String;
		/// [AIR]
		public static const STRING_FIND : String;
		/// [AIR]
		public static const STRING_HELP : String;
		/// [AIR]
		public static const STRING_HOME : String;
		/// [AIR]
		public static const STRING_INSERT : String;
		/// [AIR]
		public static const STRING_INSERTCHAR : String;
		/// [AIR]
		public static const STRING_INSERTLINE : String;
		/// [AIR]
		public static const STRING_LEFTARROW : String;
		/// [AIR]
		public static const STRING_MENU : String;
		/// [AIR]
		public static const STRING_MODESWITCH : String;
		/// [AIR]
		public static const STRING_NEXT : String;
		/// [AIR]
		public static const STRING_PAGEDOWN : String;
		/// [AIR]
		public static const STRING_PAGEUP : String;
		/// [AIR]
		public static const STRING_PAUSE : String;
		/// [AIR]
		public static const STRING_PREV : String;
		/// [AIR]
		public static const STRING_PRINT : String;
		/// [AIR]
		public static const STRING_PRINTSCREEN : String;
		/// [AIR]
		public static const STRING_REDO : String;
		/// [AIR]
		public static const STRING_RESET : String;
		/// [AIR]
		public static const STRING_RIGHTARROW : String;
		/// [AIR]
		public static const STRING_SCROLLLOCK : String;
		/// [AIR]
		public static const STRING_SELECT : String;
		/// [AIR]
		public static const STRING_STOP : String;
		/// [AIR]
		public static const STRING_SYSREQ : String;
		/// [AIR]
		public static const STRING_SYSTEM : String;
		/// [AIR]
		public static const STRING_UNDO : String;
		/// [AIR]
		public static const STRING_UPARROW : String;
		/// [AIR]
		public static const STRING_USER : String;
		/// [AIR] Constant associated with the key code value for the T key (84).
		public static const T : uint;
		/// Constant associated with the key code value for the Tab key (9).
		public static const TAB : uint;
		/// [AIR] Constant associated with the key code value for the U key (85).
		public static const U : uint;
		/// Constant associated with the key code value for the Up Arrow key (38).
		public static const UP : uint;
		/// [AIR] Constant associated with the key code value for the V key (86).
		public static const V : uint;
		/// [AIR] Constant associated with the key code value for the W key (87).
		public static const W : uint;
		/// [AIR] Constant associated with the key code value for the X key (88).
		public static const X : uint;
		/// [AIR] Constant associated with the key code value for the Y key (89).
		public static const Y : uint;
		/// [AIR] Constant associated with the key code value for the Z key (90).
		public static const Z : uint;

		/// Specifies whether the Caps Lock key is activated (true) or not (false).
		public static function get capsLock () : Boolean;

		/// Specifies whether the Num Lock key is activated (true) or not (false).
		public static function get numLock () : Boolean;

		/// Specifies whether the last key pressed is accessible by other SWF files.
		public static function isAccessible () : Boolean;

		public function Keyboard ();
	}
}
