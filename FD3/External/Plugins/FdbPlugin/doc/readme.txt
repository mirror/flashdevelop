FdbPlugin0.4.5.0
-----------------

FdbPlugin is plugin of FlashDevelop.
debugging of as3 becomes possible.
This is Test version.
 
Features:
	start, stop, continue, step, next finish command can be used. 
	variable on mouse pointer can be displayed.
	local variable panel, stackframe panel can be used. 
	tarce output into output panel.
	Value of IsTarceLog is set to True, fdbPlugin.log is preserved in the folder where FlashDevelop.exe exists. 
	
Require:
	FlexSDK3 and FlashDevelop 3.0.0Beta9(Revision76).

Contains the following files:
	doc/readme.txt         - This file.
	doc/LICENSE.txt        - licence.
	bin/FdbPlugin.dll    - plugin dll
	bin/Aga.Controls.dll    - TreeViewAdv control dll

install:
	FdbPlugin.dll and Aga.Controls.dll copy to the plugin folder of FlashDevelop.

Development Environment:
	WindowsXP SP2(japanese version).
	Visial C# 2008 Express Edition(target framework 2.0).

Changelog:

2008/10/30 0.4.5.0
	Support en/jp.	
	Add Stackframe panel.
	Add BreakPoint panel.
	Add save/load breakpoint.
	Add enable/disable breakpoint.
	Add quick waich(from contextmenu).
	Add finsih command.
	Add condition command.
	Refactoring source.

2008/07/07 0.3.5.0
	Change base source(form SVN)
	Support "Clear BreakPoints".
	Support PreLoad.
	Support ActionScript-Base AIR debug
	Fixed setting breakpoint bug.
	Change find exception dialog method.
	Add Trace.

2008/06/05 0.2.4.0
	Fixed getting error, when the mouse pointer is put on the variable after debugging is stopped. 
	Fixed state machine.
	Change Pause function.
	
2008/05/27 0.2.3.0
	Fixed 
	when delete file, this error message is displayed.
	"fdbPlugin.PluginMain.HandleEvent(Object sender, NotifyEvent e, HandlingPriority prority)
	PluginCore.Managers.EventManager.DispatchEvent(Object sender, NotifyEvent e)"

2008/05/20 0.2.2.0
	Fixed menu and toolbar button dont become enable with release mode.
	Fixed DebugFlashPlayer cant be changed.
	Add menu and toolbar button disable  with AS2.
	Add cause exception, error dialog move front.
	Change using output panel.
	
2008/05/08 0.1.1.0
	Fixed fdbPlugin causes NullReferenceException, when startpage is opened.
	include patch to fix an issue with shortcut(CTRL-S).
	
2008/04/28 0.1.0.0
	release.
