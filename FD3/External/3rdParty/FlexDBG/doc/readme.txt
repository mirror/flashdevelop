FlexDbg 0.9.1.1
---------------

FlexDbg is plugin for FlashDevelop.
 
Features:
	start, stop, continue, step, next finish command can be used. 
	variable below mouse pointer can be displayed.
	local variable panel, stackframe panel can be used. 
	trace output into output panel.
	
Require:
	FlashDevelop 3.0.0 RC2.

Contains the following files:
	doc/readme.txt         - This file.
	doc/LICENSE.txt        - licence.
	bin/FlexDbg.dll    - plugin dll
	bin/Aga.Controls.dll    - TreeViewAdv control dll

install:
	FlexDbg.dll and Aga.Controls.dll copy to the plugin folder of FlashDevelop.

Development Environment:
	Visual C# 2008 Express Edition(target framework 2.0).

Changelog:

05/05/2009 0.9.1.1
	Initial Release.
	Rewritten from fdbplugin.
