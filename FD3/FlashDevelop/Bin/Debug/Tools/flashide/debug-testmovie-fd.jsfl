var runInFlash = false; // SWF will be played by FD

var version = parseInt(fl.version.split(" ")[1]);
var proj = null; //(version < 10 && fl.getProject) ? fl.getProject() : null; 
if (proj != null && proj.canTestProject()) 
{ 
   if (runInFlash) proj.testProject();
   else proj.publishProject();
} 
else 
{
	var doc = fl.getDocumentDOM();
	if (doc == null) fl.trace("No documents open");
	else if (runInFlash) doc.testMovie();
	else doc.publish();
}

if (fl.compilerErrors && fl.compilerErrors.length > 0) 
{
	var file = fl.configURI;
	if (file.indexOf("Adobe") > 0)
	{
		var path = file.split("Adobe")[0] + "Adobe/FlashDevelop/";
		FLfile.createFolder(path);
		file = path + "FlashErrors.log";
		fl.compilerErrors.save(file);
	}
}
if (!runInFlash) // run SWF
{
	var file = fl.configURI;
	if (file.indexOf("Adobe") > 0)
	{
		var path = file.split("Adobe")[0] + "Adobe/FlashDevelop/";
		file = path + "FlashDocument.log";
		FLfile.write(file, fl.getDocumentDOM().path);
		file = path + "FlashPublish.log";
		fl.getDocumentDOM().exportPublishProfile(file);
	}
}