/* CONFIG */

var buildProject = true;
var tempPath = getTempPath();

/* RUN */

cleanup();
//setDebug(1);
build();
//setDebug(0);
postBuild();


/* OPERATIONS */

function build()
{
	var version = parseInt(fl.version.split(" ")[1]);
	var proj = (buildProject && version < 10 && fl.getProject) ? fl.getProject() : null; 
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
}

function postBuild()
{
	// log errors for FD
	if (fl.compilerErrors)
		fl.compilerErrors.save(tempPath + "FlashErrors.log");
}


/* TOOLS */

function cleanup()
{
	if (FLfile.exists(tempPath + "FlashErrors.log"))
		FLfile.remove(tempPath + "FlashErrors.log");
	if (FLfile.exists(tempPath + "FlashPublish.log"))
		FLfile.remove(tempPath + "FlashPublish.log");
	if (FLfile.exists(tempPath + "FlashDocument.log"))
		FLfile.remove(tempPath + "FlashDocument.log");
}

function getTempPath()
{
	var file = fl.configURI;
	return file.split("Adobe")[0] + "Adobe/FlashDevelop/";
}

function setDebug(value)
{
	var out = tempPath + "temp" + Math.floor(Math.random() * 1000000000) + ".xml";
	var doc = fl.getDocumentDOM();
	if (!doc) return;
	
	doc.exportPublishProfile(out);
	var config = FLfile.read(out);
	FLfile.remove(out);
	
	var rep = "<DebuggingPermitted>" + (value ? 0 : 1) + "</DebuggingPermitted>";
	if (config.indexOf(rep) > 0)
	{
		config = config.split(rep).join("<DebuggingPermitted>" + value + "</DebuggingPermitted>");
		FLfile.write(out, config);
		doc.importPublishProfile(out);
		FLfile.remove(out);
	}
}

