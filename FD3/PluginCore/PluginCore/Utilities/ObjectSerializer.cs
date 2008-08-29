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
        /// The BinaryFormatter will need some help finding Assemblies from both plugins directories
        /// </summary>
        static Assembly CurrentDomainAssemblyResolve(Object sender, ResolveEventArgs args)
        {
            AssemblyName name = new AssemblyName(args.Name);
            String dfile = Path.Combine(PathHelper.PluginDir, name.Name + ".dll");
            String ufile = Path.Combine(PathHelper.UserPluginDir, name.Name + ".dll");
            if (File.Exists(dfile)) return Assembly.LoadFrom(dfile);
            if (File.Exists(ufile)) return Assembly.LoadFrom(ufile);
            else return null;
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
        public static void ForcedSerialize(String file, Object obj)
        {
            using (FileStream stream = File.Create(file))
            {
                formatter.Serialize(stream, obj);
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
                String message = TextHelper.GetString("FlashDevelop.Info.SettingLoadError");
                ErrorManager.ShowWarning(message, new Exception("Error while deserializing: " + file, ex));
                try { ObjectSerializer.Serialize(file, obj); } catch {}
                return obj;
            }
        }

        /// <summary>
        /// Deserializes a previously saved file into the original object type, specified by the generic T parameter.
        /// </summary>
        public static T Deserialize<T>(String file)
        {
             fileDates.Add(new FileDate(file));
             return (T)InternalDeserialize(file, typeof(T));
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
