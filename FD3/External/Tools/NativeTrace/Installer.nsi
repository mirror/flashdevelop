;--------------------------------

!include "MUI.nsh"
!include "LogicLib.nsh"
!include "WordFunc.nsh"

;--------------------------------

; Define version info
!define VERSION "1.0.0"

; The name of the installer
Name "Native Trace ${VERSION}"

; The file to write
OutFile "Binary\NativeTrace-${VERSION}.exe"

; Vista redirects $SMPROGRAMS to all users without this
RequestExecutionLevel admin

; Required props
SetCompressor /SOLID lzma
XPStyle on

; Use replace and version compare
!insertmacro WordReplace
!insertmacro VersionCompare

; Installer details
VIAddVersionKey "CompanyName" "FlashDevelop.org"
VIAddVersionKey "ProductName" "Native Trace Installer"
VIAddVersionKey "LegalCopyright" "FlashDevelop.org 2005-2008"
VIAddVersionKey "FileDescription" "Native Trace Installer"
VIAddVersionKey "ProductVersion" "1.0.0.0"
VIAddVersionKey "FileVersion" "1.0.0.0"
VIProductVersion "1.0.0.0"

;--------------------------------

; Interface Configuration

!define MUI_HEADERIMAGE
!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_FUNCTION "LaunchXPI"
!define MUI_FINISHPAGE_RUN_TEXT "Install FlashTracer for Firefox 3"
!define MUI_PAGE_HEADER_SUBTEXT "Please view the licence before installing Native Trace ${VERSION}."
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of $(^NameDA).\r\n\r\nIt is recommended that you close all other applications before starting Setup. This will make it possible to update relevant system files without having to reboot your computer.\r\n\r\nTo get the tracing working in Firefox with FlashTracer plugin you need atleast Flash 9 Debug Player installed.\r\n\r\n$_CLICK"

;--------------------------------

; Pages

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "License.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

;--------------------------------

; Functions

Function LaunchXPI

	ReadRegStr $0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe" ""
	StrCmp $0 "" FirefoxNotFound FirefoxFound
	
	FirefoxNotFound:
	MessageBox MB_OK|MB_ICONSTOP "Firefox 3 could not be found on your system, please install it first and then run the installer again."
	Abort
	
	FirefoxFound:
	Exec '"$0" "$TEMP\FlashTracer-2.3.1.xpi"'
	
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

Function .onInit
	
	; Check if the installer is already running
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "Native Trace ${VERSION}") i .r1 ?e'
	Pop $0
	StrCmp $0 0 +3
	MessageBox MB_OK|MB_ICONSTOP "The Native Trace ${VERSION} installer is already running."
	Abort

	Call GetFlashVersion
	Pop $0
	${If} $0 == "not_found"
	MessageBox MB_OK|MB_ICONEXCLAMATION "You should install atleast Flash 9 Debug Player for Firefox before installing Native Trace ${VERSION}."
	${Else}
	${VersionCompare} $0 "9.0" $1
	${If} $1 == 2
	MessageBox MB_OK|MB_ICONEXCLAMATION "You should install atleast Flash 9 Debug Player for Firefox before installing Native Trace ${VERSION}. You have $0."
	${EndIf}
	${EndIf}

FunctionEnd

;--------------------------------

; Install Sections

Section "Log And Config Files" Main
	
	SectionIn RO
	SetOverwrite on
	
	SetOutPath "$TEMP"
	File "Assets\FlashTracer-2.3.1.xpi"
	
	SetOutPath "$APPDATA\Macromedia\Flash Player\Logs\"
	File "Assets\policyfiles.txt"
	File "Assets\flashlog.txt"
	
	SetOutPath "$PROFILE"
	File "Assets\mm.cfg"
	
SectionEnd

;--------------------------------
