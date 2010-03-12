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
        /// Reads the file and returns it's contents (autodetects encoding and fallback codepage)
        /// </summary>
        public static String ReadFile(String file)
        {
            Encoding encoding;
            Int32 codepage = GetFileCodepage(file);
            if (codepage == -1) encoding = Encoding.Default;
            else encoding = Encoding.GetEncoding(codepage);
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
        /// Writes a text file to the specified location (if Unicode, with BOM)
        /// </summary>
        public static void WriteFile(String file, String text, Encoding encoding)
        {
            WriteFile(file, text, encoding, true);
        }

        /// <summary>
        /// Writes a text file to the specified location (if Unicode, with or without BOM)
        /// </summary>
        public static void WriteFile(String file, String text, Encoding encoding, Boolean saveBOM)
        {
            try
            {
                Boolean useSkipBomWriter = (encoding == Encoding.UTF8 && !saveBOM);
                using (StreamWriter sw = useSkipBomWriter ? new StreamWriter(file, false) : new StreamWriter(file, false, encoding))
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
                if (!File.Exists(file)) return false;
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
                }
                else fs.Close();
                Byte[] bytes = File.ReadAllBytes(file);
                if (ContainsUTF8Bytes(bytes)) return Encoding.UTF8.CodePage;
                else return Encoding.Default.CodePage;
                
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return -1;
            }
        }

        /// <summary>
        /// Checks if the bytes contains UTF-8 bytes
        /// </summary>
        public static Boolean ContainsUTF8Bytes(Byte[] bytes)
        {
            Int32 bits = 0;
            Int32 i = 0, c = 0, b = 0;
            Int32 length = bytes.Length;
            for (i = 0; i < length; i++)
            {
                c = bytes[i];
                if (c > 128)
                {
                    if ((c >= 254)) return false;
                    else if (c >= 252) bits = 6;
                    else if (c >= 248) bits = 5;
                    else if (c >= 240) bits = 4;
                    else if (c >= 224) bits = 3;
                    else if (c >= 192) bits = 2;
                    else return false;
                    if ((i + bits) > length) return false;
                    while (bits > 1)
                    {
                        i++;
                        b = bytes[i];
                        if (b < 128 || b > 191) return false;
                        bits--;
                    }
                }
            }
            return true;
        }

        /// <summary>
        /// Checks if the file contains BOM
        /// </summary>
        public static Boolean ContainsBOM(String file)
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
                        return true;
                    }
                    else if (bom[0] == 0xff && bom[1] == 0xfe && bom[2] == 0x00 && bom[3] == 0x00)
                    {
                        return true;
                    }
                    else if ((bom[0] == 0x2b && bom[1] == 0x2f && bom[2] == 0x76) || bom[3] == 0x38 || bom[3] == 0x39 || bom[3] == 0x2b || bom[3] == 2f)
                    {
                        return true;
                    }
                    else if (bom[0] == 0xff && bom[1] == 0xfe)
                    {
                        return true;
                    }
                    else if (bom[0] == 0xfe && bom[1] == 0xff)
                    {
                        return true;
                    }
                }
                else fs.Close();
                return false;
                
            }
            catch { return false; }
        }

    }

}
