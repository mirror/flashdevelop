@echo off
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApplication.bat

:run_target
goto adl
::goto device


:adl
echo.
echo HINT - edit 'Run.bat' to:
echo - change the device screen size and initial orientation
echo - choose to directly build/test on your device instead of ADL
echo.
echo.
echo Starting AIR Debug Launcher...
echo.

:: Screen size
:: http://help.adobe.com/en_US/air/build/WSfffb011ac560372f-6fa6d7e0128cca93d31-8000.html
set SCREEN_SIZE=NexusOne

:: Run
adl -screensize %SCREEN_SIZE% "%APP_XML%" "%APP_DIR%"
if errorlevel 1 goto error
goto end


:device
echo.
echo Packaging and Installing application for debugging (%DEBUG_IP%)
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

:error
pause

:end