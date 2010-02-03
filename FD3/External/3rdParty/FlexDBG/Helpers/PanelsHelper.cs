/*
    Copyright (C) 2009  Robert Nelson

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/

using System;
using System.Drawing;
using System.Windows.Forms;
using FlexDbg.Controls;
using PluginCore;
using FlexDbg.Localization;
using WeifenLuo.WinFormsUI.Docking;

namespace FlexDbg
{
    internal class PanelsHelper
    {
		static public String pluginGuid = "f9d8faf1-31f7-45ca-9c14-2cad27d7a19e";
        static public DockContent pluginPanel;
        static public PluginUI pluginUI;

		static public String breakPointGuid = "6ee0f809-a3f7-4365-96c7-3bdf89f3aaa4";
        static public DockContent breakPointPanel;
        static public BreakPointUI breakPointUI;

		static public String stackframeGuid = "49eb0b7e-f601-4860-a190-ae48e122a661";
        static public DockContent stackframePanel;
        static public StackframeUI stackframeUI;

        public PanelsHelper(PluginMain pluginMain, Image pluginImage)
        {
            pluginUI = new PluginUI(pluginMain);
            pluginUI.Text = TextHelper.GetString("Title.LocalVariables");
            pluginPanel = PluginBase.MainForm.CreateDockablePanel(pluginUI, pluginGuid, pluginImage, DockState.Hidden);

            breakPointUI = new BreakPointUI(pluginMain, PluginMain.breakPointManager);
            breakPointUI.Text = TextHelper.GetString("Title.Breakpoints");
            breakPointPanel = PluginBase.MainForm.CreateDockablePanel(breakPointUI, breakPointGuid, pluginImage, DockState.Hidden);

            stackframeUI = new StackframeUI(pluginMain, MenusHelper.imageList);
            stackframeUI.Text = TextHelper.GetString("Title.StackTrace");
            stackframePanel = PluginBase.MainForm.CreateDockablePanel(stackframeUI, stackframeGuid, pluginImage, DockState.Hidden);
        }
	}
}
