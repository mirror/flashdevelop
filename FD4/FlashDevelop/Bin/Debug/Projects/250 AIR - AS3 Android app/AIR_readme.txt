
Instructions for DISTRIBUTING* your application:

1. Creating a self-signed certificate:
- edit CreateCertificate.bat to change the path to Flex SDK,
- edit CreateCertificate.bat to set your certificate password (and name if you like),
- run CreateCertificate.bat to generate your self-signed certificate,
- wait a minute before packaging.

2. Packaging the application:
- edit APK_PackagerApplication.bat and change the path to Flex SDK, and android tools directory
- edit also the air runtime installer for froyo if your emulator has got not yet.
- if you have a signed certificate, edit APK_PackagerApplication.bat to change the path to the certificate,
- run APK_PackagerApplication.bat, you will be prompted for the certificate password,
  (note that you may not see '***' when typing your password - it works anyway)
- the packaged application should appear in your project in a new 'air' directory.

* to test your application from FlashDevelop, just press F5 as usual.
