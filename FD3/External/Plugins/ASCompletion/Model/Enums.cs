using System;

namespace ASCompletion.Model
{
    [Flags]
    public enum Visibility : uint
    {
        Default = 1<<1,
        Public = 1<<2,
        Internal = 1<<3,
        Protected = 1<<4,
        Private = 1<<5
    }

    [Flags]
    public enum FlagType : uint
    {
        Package = 1 << 1,
        Import = 1 << 2,
        Namespace = 1 << 3,
        Access = 1 << 4,
        Class = 1 << 5,
        Interface = 1 << 6,
        Enum = 1 << 7,
        TypeDef = 1 << 8,
        Extends = 1 << 9,
        Implements = 1 << 10,

        Native = 1 << 11,
        Intrinsic = 1 << 12,
        Extern = 1 << 13,
        Dynamic = 1 << 14,
        Static = 1 << 15,
        Override = 1 << 16,

        Constant = 1 << 17,
        Variable = 1 << 18,
        Function = 1 << 19,
        Getter = 1 << 20,
        Setter = 1 << 21,
        HXProperty = 1 << 22,
        Constructor = 1 << 23,

        LocalVar = 1 << 24,
        ParameterVar = 1 << 25,
        AutomaticVar = 1 << 26,

        Declaration = 1 << 27,
        Template = 1 << 28,
        DocTemplate = 1 << 29,
        CodeTemplate = 1 << 30
    }
}