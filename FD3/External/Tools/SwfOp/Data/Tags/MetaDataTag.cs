using System;
using System.Collections.Generic;
using System.Text;

namespace SwfOp.Data.Tags
{
    class MetaDataTag : BaseTag
    {
        string _meta;

        public MetaDataTag(string meta)
        {
            _tagCode = (int)TagCodeEnum.MetaData;
            _meta = meta;
        }

        public string meta
        {
            get { return _meta; }
            set { _meta = value; }
        }
    }
}
