AIR for Android instructions

1. Configuration

	- edit 'bat\SetupSDK.bat' for paths to Flex SDK and Android SDK


2. Creating a self-signed certificate:

	- run 'bat\CreateCertificate.bat' to generate your self-signed certificate,

	(!) wait a minute before packaging.


3. Build from FlashDevelop as usual (F8)


4. Run/debug the application on the desktop as usual (F5 or Ctrl+Enter)


5. Install AIR runtime on your device

	- run 'bat\InstallAirRuntime.bat'


6. Running/debugging the application on the device:

	6.a. Build/Test directly to device
	- edit 'Run.bat' and change the run target 'goto desktop' by 'goto device'
	- build & run as usual (Ctrl+Enter or F5) to package, install & run the application on your device
	
	6.b. Test occasionally on device
	- Debug-build from FlashDevelop (F8)
	- start FlashDevelop debugger: Debug > Start Remote Session
	- run 'DebugDevice.bat' to package, install & run the application on your device
	- the application should connect to FlashDevelop interactive debugger as usual


7. Packaging for release:

	- run 'PackageApp.bat' to only create the APK
	- or run 'PackageInstallApp.bat' to package and run on device at once
