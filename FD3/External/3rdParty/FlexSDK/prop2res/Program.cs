using System;
using System.Collections.Generic;
using System.IO;
using System.Resources;
using System.Text;


namespace prop2res
{
    class Program
    {
        static void Main(string[] args)
        {
            for (int index = 0; (index + 2) <= args.Length; index += 2)
            {
                ProcessModule(new DirectoryInfo(args[index]), args[index + 1]);
            }
        }

        static void ProcessModule(DirectoryInfo dir, String localeName)
        {
            FileInfo resourceFile = new FileInfo(dir.FullName + Path.DirectorySeparatorChar + dir.Name + '.' + localeName + ".resX");

            if (resourceFile.Exists)
            {
                resourceFile.Delete();
            }

			IResourceWriter writer = new ResXResourceWriter(resourceFile.FullName);

            ProcessDirectory(dir, writer, localeName, "");

			writer.Generate();
            writer.Close();
        }

        static void ProcessDirectory(DirectoryInfo dir, IResourceWriter writer, String localeName, String prefix)
        {
            foreach (FileInfo name in dir.GetFiles("*_" + localeName + ".properties"))
            {
                ProcessFile(name, writer, prefix + name.Name.Split(new char[] { '_' })[0] + ".");
            }

            foreach (DirectoryInfo name in dir.GetDirectories())
            {
                ProcessDirectory(name, writer, localeName, prefix + name + ".");
            }
        }

        static void ProcessFile(FileInfo name, IResourceWriter writer, String prefix)
        {
            Properties properties = new Properties();

            properties.load(name.OpenRead());

            foreach (String key in properties.Keys)
            {
                writer.AddResource(prefix + key, properties.getProperty(key));
            }
        }
    }
}
