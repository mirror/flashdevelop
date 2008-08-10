using System;
using System.Collections.Generic;
using System.Text;

namespace PluginCore.Localization
{
    // These exist because we want to decorate some of our compiler option classes
    // with localized descriptions for the PropertyGrid, but we don't want fdbuild
    // to have to reference PluginCore.

    class LocalizedDescriptionAttribute : Attribute
    {
        public LocalizedDescriptionAttribute(string fake) { }
    }
    class LocalizedCategoryAttribute : Attribute
    {
        public LocalizedCategoryAttribute(string fake) { }
    }
}

namespace PluginCore
{
    interface IProject { }
}

namespace ProjectManager.Controls
{
    class PropertiesDialog { }
}
namespace ProjectManager.Controls.AS2
{
    class AS2PropertiesDialog : ProjectManager.Controls.PropertiesDialog { }
}
namespace ProjectManager.Controls.AS3
{
    class AS3PropertiesDialog : ProjectManager.Controls.PropertiesDialog { }
}
