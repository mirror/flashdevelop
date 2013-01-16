@echo off

set FLEX_HOME="..\..\..\FlashDevelop\bin\Debug\Tools\flexlibs"
set JAVA_HOME="C:\Program Files (x86)\Java\jdk1.7.0.07"
set JAVAC="C:\Program Files (x86)\Java\jdk1.7.0.07\bin\javac.exe"
set JAR="C:\Program Files (x86)\Java\jdk1.7.0.07\bin\jar.exe"

mkdir generated

proxygen.exe fdb.proxygen.xml
IF %ERRORLEVEL% NEQ 0 goto err


mkdir generated\bin

%JAVAC% -nowarn -d generated\bin -sourcepath generated\jvm -cp "jni4net.j-0.8.6.0.jar";"%FLEX_HOME%\lib\fdb.jar" generated\jvm\flash\tools\debugger\*.java
IF %ERRORLEVEL% NEQ 0 goto err
%JAVAC% -nowarn -d generated\bin -sourcepath generated\jvm -cp "jni4net.j-0.8.6.0.jar";"%FLEX_HOME%\lib\fdb.jar" generated\jvm\flash\tools\debugger\events\*.java
IF %ERRORLEVEL% NEQ 0 goto err
::%JAVAC% -nowarn -d generated\bin -sourcepath generated\jvm -cp "jni4net.j-0.8.6.0.jar";"%FLEX_HOME%\lib\fdb.jar" generated\jvm\flash\tools\debugger\threadsafe\*.java
::IF %ERRORLEVEL% NEQ 0 goto err
%JAVAC% -nowarn -d generated\bin -sourcepath generated\jvm -cp "jni4net.j-0.8.6.0.jar";"%FLEX_HOME%\lib\fdb.jar" generated\jvm\flash\tools\debugger\expression\*.java
IF %ERRORLEVEL% NEQ 0 goto err
%JAVAC% -nowarn -d generated\bin -sourcepath generated\jvm -cp "jni4net.j-0.8.6.0.jar";"%FLEX_HOME%\lib\fdb.jar" generated\jvm\java_\io\*.java
IF %ERRORLEVEL% NEQ 0 goto err
%JAVAC% -nowarn -d generated\bin -sourcepath generated\jvm -cp "jni4net.j-0.8.6.0.jar";"%FLEX_HOME%\lib\fdb.jar" generated\jvm\java_\net\*.java
IF %ERRORLEVEL% NEQ 0 goto err
::%JAVAC% -nowarn -d generated\bin -sourcepath generated\jvm -cp "jni4net.j-0.8.6.0.jar";"%FLEX_HOME%\lib\fdb.jar" generated\jvm\flex\tools\debugger\cli\*.java
::IF %ERRORLEVEL% NEQ 0 goto err
%JAVAC% -nowarn -d generated\bin -sourcepath generated\jvm -cp "jni4net.j-0.8.6.0.jar";"%FLEX_HOME%\lib\fdb.jar" generated\jvm\flash\tools\debugger\concrete\*.java
IF %ERRORLEVEL% NEQ 0 goto err

%JAR% cvf fbd.j4n.jar -C generated\bin "."
IF %ERRORLEVEL% NEQ 0 goto err

c:\Windows\Microsoft.NET\Framework\v2.0.50727\csc.exe /optimize /platform:x86 /debug- /nologo /warn:0 /t:library /out:fdb.j4n.dll /recurse:generated\clr\*.cs  /reference:"jni4net.n-0.8.6.0.dll"
::csc /debug+ /nologo /warn:0 /t:library /out:fdb.j4n.dll /recurse:generated\clr\*.cs  /reference:"jni4net.n-0.8.6.0.dll"
IF %ERRORLEVEL% NEQ 0 goto err

pause

:err
pause