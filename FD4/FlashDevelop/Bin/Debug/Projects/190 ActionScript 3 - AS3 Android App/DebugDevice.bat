@echo off
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApplication.bat

echo Packaging and Installing application for debugging (%DEBUG_IP%)
echo.
echo -- Don't forget to start FlashDevelop debugger: Debug menu, Start Remote Session
echo.

set APK_TARGET=-debug
set OPTIONS=-connect %DEBUG_IP%
call bat\Packager.bat

echo Installing %OUTPUT% on the device...
echo.
adb -d install -r "%OUTPUT%"
if errorlevel 1 goto installfail

echo.
echo Starting application on the device for debugging...
echo.
adb shell am start -n air.%APP_ID%/.AppEntry
goto end

:installfail
echo.
echo Installing the app on the device failed
pause

:end
