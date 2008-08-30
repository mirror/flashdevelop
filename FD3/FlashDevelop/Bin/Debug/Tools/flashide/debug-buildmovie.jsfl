var version = parseInt(fl.version.split(" ")[1]);
var proj = (version < 10 && fl.getProject) ? fl.getProject() : null; 
if (proj != null && proj.canTestProject()) 
{ 
   proj.publishProject();
} 
else 
{
	var doc = fl.getDocumentDOM();
	if (doc == null) fl.trace("No documents open");
	else doc.publish();
}

if (fl.compilerErrors) 
{
	var file = fl.configURI;
	if (file.indexOf("Adobe") > 0)
	{
		var path = file.split("Adobe")[0] + "FlashDevelop/Data/FlashIDE/";
		FLfile.createFolder(path);
		file = path + "errors.log";
		fl.compilerErrors.save(file);
	}
}
