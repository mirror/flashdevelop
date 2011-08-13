@echo off
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApplication.bat

set APK_TARGET=
::set APK_TARGET=-captive-runtime
set OPTIONS=
call bat\Packager.bat

pause