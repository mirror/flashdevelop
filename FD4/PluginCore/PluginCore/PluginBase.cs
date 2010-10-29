using System;
using System.IO;
using System.Windows.Forms;
using PluginCore.Managers;

namespace PluginCore
{
    public class PluginBase
    {
        private static IProject project;
        private static ISolution solution;
        private static IMainForm instance;
        
        /// <summary>
        /// Activates if the sender is MainForm
        /// </summary>
        public static void Initialize(IMainForm sender)
        {
            if (sender.GetType().ToString() == "FlashDevelop.MainForm")
            {
                instance = sender;
            }
        }

        /// <summary>
        /// Gets the instance of the Settings
        /// </summary>
        public static ISettings Settings
        {
            get { return instance.Settings; }
        }

        /// <summary>
        /// Gets the instance of the MainForm
        /// </summary>
        public static IMainForm MainForm
        {
            get { return instance; }
        }

        /// <summary>
        /// Sets and gets the current project
        /// </summary>
        public static IProject CurrentProject
        {
            get { return project; }
            set { project = value; }
        }

        /// <summary>
        /// Sets and gets the current solution
        /// </summary>
        public static ISolution CurrentSolution
        {
            get { return solution; }
            set { solution = value; }
        }

    }

}
