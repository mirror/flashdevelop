var version = parseInt(fl.version.split(" ")[1]);
var proj = null; //(version < 10 && fl.getProject) ? fl.getProject() : null; 
if (proj != null && proj.canTestProject()) 
{ 
   proj.testProject();
} 
else 
{
	var doc = fl.getDocumentDOM();
	if (doc == null) fl.trace("No documents open");
	else doc.testMovie();
}

if (fl.compilerErrors) 
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