var version = parseInt(fl.version.split(" ")[1]);
var proj = (version < 10 && fl.getProject) ? fl.getProject() : null; 
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
	var file = fl.scriptURI.substr(0, fl.scriptURI.lastIndexOf('/')+1) + "errors.log";
	fl.compilerErrors.save(file);
}