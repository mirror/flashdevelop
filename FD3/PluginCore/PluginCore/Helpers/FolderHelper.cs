using System;
using System.IO;
using System.Text;
using PluginCore.Managers;

namespace PluginCore.Helpers
{
    public class FolderHelper
    {
        /// <summary>
        /// Gets a name of the folder 
        /// </summary> 
        public static String GetFolderName(String path)
        {
            try
            {
                String dir = Path.GetFullPath(path);
                Char separator = Path.DirectorySeparatorChar;
                String[] chunks = dir.Split(separator);
                return chunks[chunks.Length - 1];
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return String.Empty;
            }
        }

        /// <summary>
        /// Ensures that the folder name is unique by adding a number to it
        /// </summary>
        public static String EnsureUniquePath(String original)
        {
            try
            {
                Int32 counter = 0;
                String result = original;
                String folder = Path.GetDirectoryName(result);
                String folderName = GetFolderName(result);
                while (Directory.Exists(result))
                {
                    counter++;
                    result = Path.Combine(folder, folderName + " (" + counter + ")");
                }
                return result;
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return String.Empty;
            }
        }

        /// <summary>
        /// Copies the folder structure recursively
        /// </summary> 
        public static void CopyFolder(String source, String destination)
        {
            try
            {
                String[] files = Directory.GetFileSystemEntries(source);
                if (!Directory.Exists(destination)) Directory.CreateDirectory(destination);
                foreach (String file in files)
                {
                    if (Directory.Exists(file)) CopyFolder(file, Path.Combine(destination, Path.GetFileName(file)));
                    else File.Copy(file, Path.Combine(destination, Path.GetFileName(file)), true);
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

    }

}
