@echo off
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApplication.bat

set APK_TARGET=
::set APK_TARGET=-captive-runtime
set OPTIONS=
call bat\Packager.bat

echo Installing %OUTPUT% on the device...
echo.
adb -d install -r "%OUTPUT%"
if errorlevel 1 goto installfail

echo.
echo Starting application on the device...
echo.
adb shell am start -n air.%APP_ID%/.AppEntry
goto end

:installfail
echo.
echo Installing the app on the device failed
pause

:end
