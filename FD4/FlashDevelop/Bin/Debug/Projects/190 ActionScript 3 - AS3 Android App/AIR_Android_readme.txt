
Instructions for DISTRIBUTING* your application:

1. Creating a self-signed certificate:
- edit CreateCertificate.bat to change the path to Flex SDK,
- edit CreateCertificate.bat to set your certificate password (and name if you like),
- run CreateCertificate.bat to generate your self-signed certificate,
- wait a minute before packaging.

2. Installing the AIR runtime on your device:
- edit InstallAirRuntimeDevice.bat / InstallAirRuntimeEmulator.bat to change the path 
  to the Flex SDK and Android SDK's tools
- run InstallAirRuntimeDevice.bat / InstallAirRuntimeEmulator.bat to install the runtime on your device.

3. Packaging & installing the application:
- edit PackageInstallApplication.bat and change the path to Flex SDK and Android SDK's platform-tools
- if you have a signed certificate, you may need to change the path to the certificate,
- run PackageInstallApplication.bat, you will be prompted for the certificate password,
  (note that you may not see '***' when typing your password - it works anyway)
- the packaged application should appear in your project in a new 'apk' directory 
  and be installed on the currently plugged Android device/emulator.
