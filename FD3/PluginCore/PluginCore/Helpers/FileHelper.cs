using System;
using System.IO;
using System.Text;
using System.Windows.Forms;
using System.Collections.Generic;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore;

namespace PluginCore.Helpers
{
    public class FileHelper
    {
        /// <summary>
        /// Deletes files/directories by sending them to recycle bin
        /// </summary>
        public static Boolean Recycle(String path)
        {
            InteropSHFileOperation fo = new InteropSHFileOperation();
            fo.wFunc = InteropSHFileOperation.FO_Func.FO_DELETE;
            fo.fFlags.FOF_ALLOWUNDO = true;
            fo.fFlags.FOF_NOCONFIRMATION = true;
            fo.fFlags.FOF_NOERRORUI = true;
            fo.fFlags.FOF_SILENT = true;
            fo.pFrom = path;
            return fo.Execute();
        }

        /// <summary>
        /// Reads the file and returns it's contents (autodetects encoding) 
        /// </summary>
        public static String ReadFile(String file)
        {
            Int32 codepage = GetFileCodepage(file);
            Encoding encoding = Encoding.GetEncoding(codepage);
            return ReadFile(file, encoding);
        }

        /// <summary>
		/// Reads the file and returns it's contents
		/// </summary>
        public static String ReadFile(String file, Encoding encoding)
        {
            try
            {
                using (StreamReader sr = new StreamReader(file, encoding))
                {
                    String src = sr.ReadToEnd();
                    sr.Close();
                    return src;
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return null;
            }
        }

        /// <summary>
        /// Writes a text file to the specified location
        /// </summary>
        public static void WriteFile(String file, String text, Encoding encoding)
        {
            try
            {
                using (StreamWriter sw = new StreamWriter(file, false, encoding))
                {
                    sw.Write(text);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Adds text to the end of the specified file
        /// </summary>
        public static void AddToFile(String file, String text, Encoding encoding)
        {
            try
            {
                using (StreamWriter sw = new StreamWriter(file, true, encoding))
                {
                    sw.Write(text);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Ensures that the file name is unique by adding a number to it
        /// </summary>
        public static String EnsureUniquePath(String original)
        {
            try
            {
                Int32 counter = 0;
                String result = original;
                String folder = Path.GetDirectoryName(original);
                String filename = Path.GetFileNameWithoutExtension(original);
                String extension = Path.GetExtension(original);
                while (File.Exists(result))
                {
                    counter++;
                    String fullname = filename + " (" + counter + ")" + extension;
                    result = Path.Combine(folder, fullname);
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
        /// Checks that if the file is read only
        /// </summary>
        public static Boolean FileIsReadOnly(String file)
        {
            try
            {
                if (!File.Exists(file)) return true;
                FileAttributes fileAttr = File.GetAttributes(file);
                if ((fileAttr & FileAttributes.ReadOnly) == FileAttributes.ReadOnly) return true;
                else return false;
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return false;
            }
        }

        /// <summary>
        /// Reads the file codepage from the file data
        /// </summary>
        public static Int32 GetFileCodepage(String file)
        {
            try
            {
                Byte[] bom = new Byte[4];
                FileStream fs = new FileStream(file, FileMode.Open, FileAccess.Read, FileShare.Read);
                if (fs.CanSeek)
                {
                    fs.Read(bom, 0, 4); 
                    fs.Close();
                    if (bom[0] == 0xef && bom[1] == 0xbb && bom[2] == 0xbf)
                    {
                        return Encoding.UTF8.CodePage;
                    }
                    else if (bom[0] == 0xff && bom[1] == 0xfe && bom[2] == 0x00 && bom[3] == 0x00)
                    {
                        return Encoding.UTF32.CodePage;
                    }
                    else if ((bom[0] == 0x2b && bom[1] == 0x2f && bom[2] == 0x76) || bom[3] == 0x38 || bom[3] == 0x39 || bom[3] == 0x2b || bom[3] == 2f)
                    {
                        return Encoding.UTF7.CodePage;
                    }
                    else if (bom[0] == 0xff && bom[1] == 0xfe)
                    {
                        return Encoding.Unicode.CodePage;
                    }
                    else if (bom[0] == 0xfe && bom[1] == 0xff)
                    {
                        return Encoding.BigEndianUnicode.CodePage;
                    }
                    else return (Int32)PluginBase.Settings.FallbackCodePage;
                }
                else
                {
                    fs.Close();
                    return (Int32)PluginBase.Settings.FallbackCodePage;
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return -1;
            }
        }

    }

}
