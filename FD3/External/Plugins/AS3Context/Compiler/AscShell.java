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
* Building: javac -classpath "C:\flex_sdk_3.0.2.2113\lib\asc.jar;." AscShell.java
* Running: java -classpath "C:\flex_sdk_3.0.2.2113\lib\asc.jar;." AscShell
*/
class AscShell
{
	static private Context ctx = null;
	
	// Start a shell waiting for files to parse
	static public void main(String[] args)
	{
		ContextStatics statics = new ContextStatics();
		ctx = new Context(statics);
		
		try
		{
			BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
			String rawFile = null;
			StringBuilder src = null;
			
			while(true)
			{
				String cmd = in.readLine();
				if (cmd == null) break;
				
				// parse from provided raw file source
				if (cmd.endsWith("$raw$"))
				{
					if (rawFile != null && src != null) 
					{
						parseSrc(rawFile, src.toString());
						rawFile = null;
						src = null;
					}
					else 
					{
						rawFile = cmd;
						src = new StringBuilder();
					}
				}
				else if (src != null)
				{
					src.append(cmd).append("\n");
				}
				
				// parse from provided filename
				else parseFile(cmd);
			}
			in.close();
		}
		catch (IOException iex)
		{
			System.out.println(iex);
		}
	}
	
	// Run Flex SDK Actionscript parser against provided source
	static public void parseSrc(String filespec, String src)
	{
		if (ctx == null) return;
		
		try
		{
			Parser parser = new Parser(ctx, src, filespec);
			ProgramNode pn = parser.parseProgram();
			Thread.sleep(50);
			System.out.println("(ash) Done");
		}
		catch (InterruptedException tex) {}
	}

	// Run Flex SDK Actionscript parser against provided file
	static public void parseFile(String filespec)
	{
		if (ctx == null) return;
		
		try
		{
			BufferedInputStream stream = new BufferedInputStream(new FileInputStream(filespec));
			try
			{
				Parser parser = new Parser(ctx, stream, filespec);
				ProgramNode pn = parser.parseProgram();
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