@echo off
if not exist %CERT_FILE% goto certificate

:: APK output
if not exist %APK_PATH% md %APK_PATH%
set OUTPUT=%APK_PATH%\%APK_NAME%%APK_TARGET%.apk

:: Package
echo Packaging %APK_NAME%%APK_TARGET%.apk using certificate %CERT_FILE%...
call adt -package -target apk%APK_TARGET% %OPTIONS% %SIGNING_OPTIONS% "%OUTPUT%" "%APP_XML%" %FILE_OR_DIR%
if errorlevel 1 goto failed
goto end

:certificate
echo Certificate not found: %CERT_FILE%
echo.
echo Troubleshooting: 
echo - generate a default certificate using 'bat\CreateCertificate.bat'
echo.
if %PAUSE_ERRORS%==1 pause
exit

:failed
echo APK setup creation FAILED.
echo.
echo Troubleshooting: 
echo - did you build your project in FlashDevelop?
echo - verify AIR SDK target version in %APP_XML%
echo.
if %PAUSE_ERRORS%==1 pause
exit

:end
echo.