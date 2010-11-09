Instructions for DISTRIBUTING* your application:

1. Creating a self-signed certificate:

- Edit CreateCertificate.bat to change the path to the Flex SDK
- Edit CreateCertificate.bat to set your certificate password (and name if you like)
- Run CreateCertificate.bat to generate your self-signed certificate
- Wait a minute before packaging

2. Packaging the application:

- Edit PackageApplication.bat and change the path to the Flex SDK
- If you have a signed certificate, edit PackageApplication.bat to change the path to the certificate
- Run PackageApplication.bat, you will be prompted for the certificate password (you may not see '***' when typing your password)
- The packaged application should appear in your project in a new directory called 'air'

* To test your application with FlashDevelop, just press F5 as usual.

