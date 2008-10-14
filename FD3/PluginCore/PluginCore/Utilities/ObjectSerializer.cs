using System;
using System.IO;
using System.Xml;
using System.Text;
using System.Reflection;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using PluginCore.Localization;
using System.Windows.Forms;
using PluginCore.Managers;
using PluginCore.Helpers;

namespace PluginCore.Utilities
{
    public class ObjectSerializer
    {
        private static List<FileDate> fileDates = new List<FileDate>();
        private static BinaryFormatter formatter = new BinaryFormatter();

        static ObjectSerializer()
        {
            AppDomain.CurrentDomain.AssemblyResolve += new ResolveEventHandler(CurrentDomainAssemblyResolve);
        }

        /// <summary>
        /// The BinaryFormatter may need some help finding Assemblies from various directories
        /// </summary>
        static Assembly CurrentDomainAssemblyResolve(Object sender, ResolveEventArgs args)
        {
            AssemblyName assemblyName = new AssemblyName(args.Name);
            String ffile = Path.Combine(PathHelper.AppDir, assemblyName.Name + ".exe");
            String afile = Path.Combine(PathHelper.AppDir, assemblyName.Name + ".dll");
            String dfile = Path.Combine(PathHelper.PluginDir, assemblyName.Name + ".dll");
            String ufile = Path.Combine(PathHelper.UserPluginDir, assemblyName.Name + ".dll");
            if (File.Exists(ffile)) return Assembly.LoadFrom(ffile);
            if (File.Exists(afile)) return Assembly.LoadFrom(afile);
            if (File.Exists(dfile)) return Assembly.LoadFrom(dfile);
            if (File.Exists(ufile)) return Assembly.LoadFrom(ufile);
            return null;
        }

        /// <summary>
        /// Serializes the specified object to a binary file
        /// </summary>
        public static void Serialize(String file, Object obj)
        {
            try
            {
                DateTime modified = File.GetLastWriteTime(file);
                foreach (FileDate fileDate in fileDates)
                {
                    if (fileDate.Path == file && fileDate.Time.CompareTo(modified) < 0) return;
                }
                using (FileStream stream = File.Create(file))
                {
                    formatter.Serialize(stream, obj);
                }
                foreach (FileDate fileDate in fileDates)
                {
                    if (fileDate.Path == file) fileDate.Time = File.GetLastWriteTime(file);
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Forces the serialization to a binary file without any file info checks
        /// </summary>
        public static void ForcedSerialize(String file, Object obj)
        {
            try
            {
                using (FileStream stream = File.Create(file))
                {
                    formatter.Serialize(stream, obj);
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Deserializes the specified object from a binary file
        /// </summary>
        public static Object Deserialize(String file, Object obj)
        {
            try
            {
                fileDates.Add(new FileDate(file));
                return InternalDeserialize(file, obj.GetType());
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return obj;
            }
        }

        /// <summary>
        /// Fixes some common issues when serializing
        /// </summary>
        static Object InternalDeserialize(String file, Type type)
        {
            FileInfo info = new FileInfo(file);
            if (!info.Exists)
            {
                return Activator.CreateInstance(type);
            }
            else if (info.Exists && info.Length == 0)
            {
                info.Delete();
                return Activator.CreateInstance(type);
            }
            else
            {
                using (FileStream stream = info.Open(FileMode.Open, FileAccess.Read))
                {
                    return formatter.Deserialize(stream);
                }
            }
        }

    }

    public class FileDate
    {
        public String Path;
        public DateTime Time;

        public FileDate(String file)
        {
            this.Path = file;
            this.Time = File.GetLastWriteTime(file);
        }

    }

}
