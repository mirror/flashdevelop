@echo off
set PAUSE_ERRORS=1
call conf\SetupSDK.bat
call conf\SetupApplication.bat

set APK_TARGET=
set OPTIONS=
call conf\Packager.bat

pause