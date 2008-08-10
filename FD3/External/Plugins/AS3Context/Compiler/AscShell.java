import java.lang.*;
import macromedia.asc.embedding.Shell;

/**
* ASC compiler wrapper
*
* Author: Philippe Elsass
*
* Building: javac -classpath "c:\flex_2_sdk\lib\asc.jar;." AscShell.java
*/
class AscShell
{
	static public void main(String[] args)
	{
		try
		{
			Shell.main(args);
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}
}