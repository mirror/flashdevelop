;--------------------------------

!include "MUI.nsh"
!include "FileAssoc.nsh"
!include "LogicLib.nsh"
!include "WordFunc.nsh"

;--------------------------------

; Define application version
!define VERSION "3.0.0"

; The name of the installer
Name "FlashDevelop ${VERSION}"

; The captions of the installer
Caption "FlashDevelop ${VERSION} Beta8 Setup"
UninstallCaption "FlashDevelop ${VERSION} Beta8 Uninstall"

; The file to write
OutFile "Binary\FlashDevelop-${VERSION}-Beta8.exe"

; Default installation folder
InstallDir "$PROGRAMFILES\FlashDevelop\"

; Define executable files
!define EXECUTABLE "$INSTDIR\FlashDevelop.exe"
!define WIN32RES "$INSTDIR\Tools\winres\winres.exe"
!define ASDOCGEN "$INSTDIR\Tools\asdocgen\ASDocGen.exe"

; Get installation folder from registry if available
InstallDirRegKey HKLM "Software\FlashDevelop" "Install_Dir"

; Vista redirects $SMPROGRAMS to all users without this
RequestExecutionLevel admin

; Use replace and version compare
!insertmacro WordReplace
!insertmacro VersionCompare

; Required props
SetCompressor /SOLID lzma
XPStyle on

; Installer details
VIAddVersionKey "CompanyName" "FlashDevelop.org"
VIAddVersionKey "ProductName" "FlashDevelop Installer"
VIAddVersionKey "LegalCopyright" "FlashDevelop.org 2005-2008"
VIAddVersionKey "FileDescription" "FlashDevelop Installer"
VIAddVersionKey "ProductVersion" "1.0.0.0"
VIAddVersionKey "FileVersion" "1.0.0.0"
VIProductVersion "1.0.0.0"

;--------------------------------

; Interface Configuration

!define MUI_HEADERIMAGE
!define MUI_ABORTWARNING
!define MUI_HEADERIMAGE_BITMAP "Graphics\Banner.bmp"
!define MUI_PAGE_HEADER_SUBTEXT "Please view the licence before installing FlashDevelop ${VERSION}."
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of $(^NameDA).\r\n\r\nIt is recommended that you close all other applications before starting Setup. This will make it possible to update relevant system files without having to reboot your computer.\r\n\r\nTo get everything out of FlashDevelop you should have Java 1.6 Runtime and Flash 9 Player (ActiveX for IE) installed.\r\n\r\nWARNING: Before you install a beta version, backup you customized files because they will be overwritten.\r\n\r\n$_CLICK"
!define MUI_WELCOMEFINISHPAGE_BITMAP "Graphics\Wizard.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "Graphics\Wizard.bmp"
!define MUI_FINISHPAGE_RUN "${EXECUTABLE}"
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_LINK "View Readme"
!define MUI_FINISHPAGE_LINK_LOCATION "$INSTDIR\Docs\index.html"

;--------------------------------

; Pages

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\..\..\..\License.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_COMPONENTS
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

;--------------------------------

; InstallTypes

InstType "Default"
InstType "Standalone"
InstType "Generic"
InstType "un.Default"
InstType "un.Full"

;--------------------------------

; Functions

Function GetDotNETVersion

	Push $0
	Push $1
	System::Call "mscoree::GetCORVersion(w .r0, i ${NSIS_MAX_STRLEN}, *i) i .r1"
	StrCmp $1 "error" 0 +2
	StrCpy $0 "not_found"
	Pop $1
	Exch $0
  
FunctionEnd


Function GetFlashVersion

	Push $0
	ClearErrors
	ReadRegStr $0 HKLM "Software\Macromedia\FlashPlayer" "CurrentVersion"
	IfErrors 0 +5
	ClearErrors
	ReadRegStr $0 HKCU "Software\Macromedia\FlashPlayer" "FlashPlayerVersion"
	IfErrors 0 +2
	StrCpy $0 "not_found"
	${WordReplace} $0 "," "." "+" $1
	Exch $1

FunctionEnd

Function GetJavaVersion

	Push $0
	ClearErrors
	ReadRegStr $0 HKLM "Software\JavaSoft\Java Runtime Environment" "CurrentVersion"
	IfErrors 0 +2
	StrCpy $0 "not_found"
	Exch $0

FunctionEnd

Function GetFDVersion

	Push $0
	ClearErrors
	ReadRegStr $0 HKLM Software\FlashDevelop "CurrentVersion"
	IfErrors 0 +2
	StrCpy $0 "not_found"
	Exch $0

FunctionEnd


Function GetFDInstDir

	Push $1
	ClearErrors
	ReadRegStr $1 HKLM Software\FlashDevelop ""
	IfErrors 0 +2
	StrCpy $1 "not_found"
	Exch $1

FunctionEnd

Function .onInit
	
	; Check if the installer is already running
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "FlashDevelop ${VERSION}") i .r1 ?e'
	Pop $0
	StrCmp $0 0 +3
	MessageBox MB_OK|MB_ICONSTOP "The FlashDevelop ${VERSION} installer is already running."
	Abort

	Call GetDotNETVersion
	Pop $0
	${If} $0 == "not_found"
	MessageBox MB_OK|MB_ICONSTOP "You need to install Microsoft.NET 2.0 runtime before installing FlashDevelop."
	Abort
	${EndIf}
	StrCpy $0 $0 "" 1 # skip "v"
	${VersionCompare} $0 "2.0" $1
	${If} $1 == 2
	MessageBox MB_OK|MB_ICONSTOP "You need to install Microsoft.NET 2.0 runtime before installing FlashDevelop. You have $0."
	Abort
	${EndIf}

	Call GetFDVersion
	Pop $0
	Call GetFDInstDir
	Pop $1
	${If} $0 == "not_found"
	${If} $1 != "not_found"
	MessageBox MB_OK|MB_ICONEXCLAMATION "You have a version of FlashDevelop installed that may make FlashDevelop unstable if updated. You should uninstall it before installing this one."
	${EndIf}
	${EndIf}

	Call GetFlashVersion
	Pop $0
	${If} $0 == "not_found"
	MessageBox MB_OK|MB_ICONEXCLAMATION "You should install Flash Player 9 (ActiveX for IE) before installing FlashDevelop."
	${Else}
	${VersionCompare} $0 "9.0" $1
	${If} $1 == 2
	MessageBox MB_OK|MB_ICONEXCLAMATION "You should install Flash Player 9 (ActiveX for IE) before installing FlashDevelop. You have $0."
	${EndIf}
	${EndIf}

	Call GetJavaVersion
	Pop $0
	${If} $0 == "not_found"
	MessageBox MB_OK|MB_ICONEXCLAMATION "You should install Java Runtime 1.6 before installing FlashDevelop."
	${Else}
	${VersionCompare} $0 "1.6" $1
	${If} $1 == 2
	MessageBox MB_OK|MB_ICONEXCLAMATION "You should install Java Runtime 1.6 before installing FlashDevelop. You have $0."
	${EndIf}
	${EndIf}

FunctionEnd

;--------------------------------

; Install Sections

Section "FlashDevelop" Main

	SectionIn 1 2 3 RO
	SetOverwrite on
	
	SetOutPath "$INSTDIR"
	File /r /x .svn /x *.db /x Exceptions.log /x .local /x .multi /x *.pdb /x *.vshost.exe /x *.vshost.exe.manifest /x Data /x Settings "..\Bin\Debug\*.*"

	SetOverwrite off

	SetOutPath "$INSTDIR\Settings"
	File /r /x .svn /x *.db /x FileStates /x Recovery /x LayoutData.fdl /x SessionData.fdb /x SettingData.fdb "..\Bin\Debug\Settings\*.*"

SectionEnd

Section "Registry Modifications" RegistryMods
	
	SectionIn 1 3
	SetOverwrite on
	SetShellVarContext all
	
	Delete "$INSTDIR\.multi"
	Delete "$INSTDIR\.local"

	DeleteRegKey /ifempty HKCR "Applications\FlashDevelop.exe"	
	DeleteRegKey /ifempty HKLM "Software\Classes\Applications\FlashDevelop.exe"
	DeleteRegKey /ifempty HKCU "Software\Classes\Applications\FlashDevelop.exe"
	
	!insertmacro APP_ASSOCIATE "fdp" "FlashDevelop.Project" "FlashDevelop Project" "${WIN32RES},2" "" "${EXECUTABLE}"
	!insertmacro APP_ASSOCIATE "hxproj" "FlashDevelop.HaXeProject" "FlashDevelop HaXe Project" "${WIN32RES},2" "" "${EXECUTABLE}"
	!insertmacro APP_ASSOCIATE "as2proj" "FlashDevelop.AS2Project" "FlashDevelop AS2 Project" "${WIN32RES},2" "" "${EXECUTABLE}"
	!insertmacro APP_ASSOCIATE "as3proj" "FlashDevelop.AS3Project" "FlashDevelop AS3 Project" "${WIN32RES},2" "" "${EXECUTABLE}"
	!insertmacro APP_ASSOCIATE "docproj" "FlashDevelop.DocProject" "FlashDevelop Docs Project" "${WIN32RES},2" "" "${ASDOCGEN}"

	!insertmacro APP_ASSOCIATE "fdt" "FlashDevelop.Template" "FlashDevelop Template File" "${WIN32RES},1" "" "${EXECUTABLE}"
	!insertmacro APP_ASSOCIATE "fda" "FlashDevelop.Arguments" "FlashDevelop Argument File" "${WIN32RES},1" "" "${EXECUTABLE}"
	!insertmacro APP_ASSOCIATE "fds" "FlashDevelop.Snippet" "FlashDevelop Snippet File" "${WIN32RES},1" "" "${EXECUTABLE}"
	!insertmacro APP_ASSOCIATE "fdb" "FlashDevelop.Binary" "FlashDevelop Binary File" "${WIN32RES},1" "" "${EXECUTABLE}"
	!insertmacro APP_ASSOCIATE "fdl" "FlashDevelop.Layout" "FlashDevelop Layout File" "${WIN32RES},1" "" "${EXECUTABLE}"

	!insertmacro APP_ASSOCIATE_REMOVEVERB "FlashDevelop.Project" "ShellNew"
	!insertmacro APP_ASSOCIATE_REMOVEVERB "FlashDevelop.HaXeProject" "ShellNew"
	!insertmacro APP_ASSOCIATE_REMOVEVERB "FlashDevelop.AS2Project" "ShellNew"
	!insertmacro APP_ASSOCIATE_REMOVEVERB "FlashDevelop.AS3Project" "ShellNew"
	!insertmacro APP_ASSOCIATE_REMOVEVERB "FlashDevelop.DocProject" "ShellNew"

	!insertmacro APP_ASSOCIATE_REMOVEVERB "FlashDevelop.Template" "ShellNew"
	!insertmacro APP_ASSOCIATE_REMOVEVERB "FlashDevelop.Arguments" "ShellNew"
	!insertmacro APP_ASSOCIATE_REMOVEVERB "FlashDevelop.Snippet" "ShellNew"
	!insertmacro APP_ASSOCIATE_REMOVEVERB "FlashDevelop.Binary" "ShellNew"
	!insertmacro APP_ASSOCIATE_REMOVEVERB "FlashDevelop.Layout" "ShellNew"

	CreateDirectory "$SMPROGRAMS\FlashDevelop"
	CreateShortCut "$SMPROGRAMS\FlashDevelop\FlashDevelop.lnk" "${EXECUTABLE}" "" "${EXECUTABLE}" 0
	WriteINIStr "$SMPROGRAMS\FlashDevelop\Documentation.url" "InternetShortcut" "URL" "http://www.flashdevelop.org/wikidocs/"
	WriteINIStr "$SMPROGRAMS\FlashDevelop\Community.url" "InternetShortcut" "URL" "http://www.flashdevelop.org/community/"
	CreateShortCut "$SMPROGRAMS\FlashDevelop\Uninstall.lnk" "$INSTDIR\Uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0
	
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Product" "DisplayName" "FlashDevelop ${VERSION}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Product" "Comments" "Thank you for using FlashDevelop."
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Product" "HelpLink" "http://www.flashdevelop.org/community/"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Product" "Publisher" "FlashDevelop.org"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Product" "UninstallString" "$INSTDIR\Uninstall.exe"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Product" "DisplayIcon" "${EXECUTABLE}"
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Product" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Product" "NoRepair" 1
	WriteRegStr HKLM "Software\FlashDevelop" "CurrentVersion" ${VERSION}
	WriteRegStr HKLM "Software\FlashDevelop" "" $INSTDIR
	WriteUninstaller "$INSTDIR\Uninstall.exe"

	!insertmacro UPDATEFILEASSOC

SectionEnd

Section "Quick Launch Shortcut" QuickShortcut

	SectionIn 1	
	SetOverwrite on

	CreateShortCut "$QUICKLAUNCH\FlashDevelop.lnk" "${EXECUTABLE}" "" "${EXECUTABLE}" 0

SectionEnd

Section "Desktop Shortcut" DesktopShortcut

	SectionIn 1
	SetOverwrite on

	CreateShortCut "$DESKTOP\FlashDevelop.lnk" "${EXECUTABLE}" "" "${EXECUTABLE}" 0

SectionEnd

Section "Multi Instance Mode" MultiInstanceMode
	
	SetOverwrite on

	SetOutPath "$INSTDIR"
	File ..\Bin\Debug\.multi

SectionEnd

Section "Standalone Mode" StandaloneMode

	SectionIn 2	
	SetOverwrite on

	SetOutPath "$INSTDIR"
	File ..\Bin\Debug\.local

SectionEnd

;--------------------------------

; Install section strings

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${Main} "Installs the main program and other required files."
!insertmacro MUI_DESCRIPTION_TEXT ${RegistryMods} "Associates integral file types and adds the required uninstall configuration."
!insertmacro MUI_DESCRIPTION_TEXT ${StandaloneMode} "Run as standalone application instead of installing user-related files to the user's application data directory."
!insertmacro MUI_DESCRIPTION_TEXT ${MultiInstanceMode} "Allows multiple instances of FlashDevelop to be executed."
!insertmacro MUI_DESCRIPTION_TEXT ${QuickShortcut} "Installs a FlashDevelop shortcut to the Quick Launch bar."
!insertmacro MUI_DESCRIPTION_TEXT ${DesktopShortcut} "Installs a FlashDevelop shortcut to the desktop."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------

; Uninstall Sections

Section "un.FlashDevelop" UninstMain
	
	SectionIn 1 2 RO
	SetShellVarContext all

	RMDir /r "$INSTDIR\Docs"
	RMDir /r "$INSTDIR\Library"
	RMDir /r "$INSTDIR\Plugins"
	RMDir /r "$INSTDIR\Snippets"
	RMDir /r "$INSTDIR\StartPage"
	RMDir /r "$INSTDIR\Templates"
	RMDir /r "$INSTDIR\Tools"
	
	Delete "$INSTDIR\.multi"
	Delete "$INSTDIR\.local"
	Delete "$INSTDIR\FirstRun.fdb"
	Delete "$INSTDIR\FlashDevelop.exe"
	Delete "$INSTDIR\ICSharpCode.SharpZipLib.dll"
	Delete "$INSTDIR\PluginCore.dll"
	Delete "$INSTDIR\SciLexer.dll"
	Delete "$INSTDIR\SwfOp.dll"
	
	Delete $INSTDIR\Uninstall.exe	
	Delete "$DESKTOP\FlashDevelop.lnk"
	Delete "$QUICKLAUNCH\FlashDevelop.lnk"
	RMDir /r "$SMPROGRAMS\FlashDevelop"
	
	!insertmacro APP_UNASSOCIATE "fdp" "FlashDevelop.Project"
	!insertmacro APP_UNASSOCIATE "hxproj" "FlashDevelop.HaXeProject"
	!insertmacro APP_UNASSOCIATE "as2proj" "FlashDevelop.AS2Project"
	!insertmacro APP_UNASSOCIATE "as3proj" "FlashDevelop.AS3Project"
	!insertmacro APP_UNASSOCIATE "docproj" "FlashDevelop.DocProject"

	!insertmacro APP_UNASSOCIATE "fdt" "FlashDevelop.Template"
	!insertmacro APP_UNASSOCIATE "fda" "FlashDevelop.Arguments"
	!insertmacro APP_UNASSOCIATE "fds" "FlashDevelop.Snippet"
	!insertmacro APP_UNASSOCIATE "fdb" "FlashDevelop.Binary"
	!insertmacro APP_UNASSOCIATE "fdl" "FlashDevelop.Layout"

	DeleteRegKey /ifempty HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Product"
	DeleteRegKey /ifempty HKLM "Software\FlashDevelop"

	DeleteRegKey /ifempty HKCR "Applications\FlashDevelop.exe"	
	DeleteRegKey /ifempty HKLM "Software\Classes\Applications\FlashDevelop.exe"
	DeleteRegKey /ifempty HKCU "Software\Classes\Applications\FlashDevelop.exe"

	!insertmacro UPDATEFILEASSOC
	
SectionEnd

Section /o "un.Settings" UninstSettings
	
	SectionIn 2

	RMDir /r "$INSTDIR\Data"
	RMDir /r "$INSTDIR\Settings"
	RMDir /r "$LOCALAPPDATA\FlashDevelop"
	RMDir /r "$SMPROGRAMS\FlashDevelop"
	RMDir "$INSTDIR"

SectionEnd

;--------------------------------

; Uninstall section strings

!insertmacro MUI_UNFUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${UninstMain} "Uninstalls the main program, other required files and registry modifications."
!insertmacro MUI_DESCRIPTION_TEXT ${UninstSettings} "Uninstalls all setting files from the install directory and user's application data directory."
!insertmacro MUI_UNFUNCTION_DESCRIPTION_END

;--------------------------------
