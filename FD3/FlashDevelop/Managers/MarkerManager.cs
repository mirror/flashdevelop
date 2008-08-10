using System;
using System.Text;
using ScintillaNet;
using PluginCore.Managers;
using PluginCore.Controls;
using PluginCore;

namespace FlashDevelop.Managers
{
    class MarkerManager
    {
        /// <summary>
        /// Mask value for all availables markers
        /// </summary>
        public static Int32 MARKERS = 1 << 0 | 1 << 1;

        /// <summary>
        /// Gets the mask of the marker
        /// </summary>
        public static Int32 GetMarkerMask(Int32 marker)
        {
            return 1 << marker;
        }

        /// <summary>
        /// Adds or removes a marker
        /// </summary>
        public static void ToggleMarker(ScintillaControl sci, Int32 marker, Int32 line)
        {
            Int32 lineMask = sci.MarkerGet(line);
            if ((lineMask & GetMarkerMask(marker)) == 0) sci.MarkerAdd(line, marker);
            else sci.MarkerDelete(line, marker);
            UITools.Manager.MarkerChanged(sci, line);
        }

        /// <summary>
        /// Moves the cursor to the next marker
        /// </summary>
        public static void NextMarker(ScintillaControl sci, Int32 marker, Int32 line)
        {
            Int32 next = 0;
            Int32 lineMask = sci.MarkerGet(line);
            if ((lineMask & GetMarkerMask(marker)) != 0)
            {
                next = sci.MarkerNext(line + 1, GetMarkerMask(marker));
                if (next != -1) sci.GotoLine(next);
                else
                {
                    next = sci.MarkerNext(0, GetMarkerMask(marker));
                    if (next != -1) sci.GotoLine(next);
                }
            }
            else
            {
                next = sci.MarkerNext(line, GetMarkerMask(marker));
                if (next != -1) sci.GotoLine(next);
                else
                {
                    next = sci.MarkerNext(0, GetMarkerMask(marker));
                    if (next != -1) sci.GotoLine(next);
                }
            }
        }

        /// <summary>
        /// Moves the cursor to the previous marker
        /// </summary>
        public static void PreviousMarker(ScintillaControl sci, Int32 marker, Int32 line)
        {
            Int32 prev = 0; Int32 count = 0;
            Int32 lineMask = sci.MarkerGet(line);
            if ((lineMask & GetMarkerMask(marker)) != 0)
            {
                prev = sci.MarkerPrevious(line - 1, GetMarkerMask(marker));
                if (prev != -1) sci.GotoLine(prev);
                else
                {
                    count = sci.LineCount;
                    prev = sci.MarkerPrevious(count, GetMarkerMask(marker));
                    if (prev != -1) sci.GotoLine(prev);
                }
            }
            else
            {
                prev = sci.MarkerPrevious(line, GetMarkerMask(marker));
                if (prev != -1) sci.GotoLine(prev);
                else
                {
                    count = sci.LineCount;
                    prev = sci.MarkerPrevious(count, GetMarkerMask(marker));
                    if (prev != -1) sci.GotoLine(prev);
                }
            }
        }

    }

}
