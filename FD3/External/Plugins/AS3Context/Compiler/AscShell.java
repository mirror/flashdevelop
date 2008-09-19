import java.lang.*;
import java.io.*;
import macromedia.asc.util.Context;
import macromedia.asc.util.ContextStatics;
import macromedia.asc.parser.Parser;
import macromedia.asc.parser.ProgramNode;

/**
* ASC compiler wrapper
*
* Author: Philippe Elsass
*
* Building: javac -classpath "C:\Program Files\Adobe\flex_sdk_3.1.0.2710\lib\asc.jar;." AscShell.java
* Running: java -classpath "C:\Program Files\Adobe\flex_sdk_3.1.0.2710\lib\asc.jar;." AscShell
*/
class AscShell
{
	static private Context ctx;

	// Start a shell waiting for files to parse
	static public void main(String[] args)
	{
		ContextStatics statics = new ContextStatics();
		ctx = new Context(statics);

		try
		{
			BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

			while(true)
			{
				// get command line
				String cmd = in.readLine();
				if (cmd == null) break;
				parseFile(cmd);
			}
			in.close();
		}
		catch (IOException iex)
		{
			System.out.println(iex);
		}
	}

	// Run Flex SDK Actionscript parser against provided file
	static public void parseFile(String filespec)
	{
		if (ctx == null) return;

		try
		{
			BufferedInputStream stream = new BufferedInputStream(new FileInputStream(filespec));

			ProgramNode pn = null;
			try
			{
				Parser parser = new Parser(ctx, stream, filespec);
				pn = parser.parseProgram();
				Thread.sleep(50);
				System.out.println("(ash) Done");
			}
			catch (InterruptedException tex) {}
			finally
			{
				if (stream != null) stream.close();
			}
		}
		catch (IOException iex)
		{
			System.out.println("(ash) File not found: " + filespec);
		}
	}
}