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
    public enum FlagType : ulong
    {
        Package = 1 << 1,
        Import = 1 << 2,
        Namespace = 1 << 3,
        Access = 1 << 4,
        Module = 1 << 5,
        Class = 1 << 6,
        Interface = 1 << 7,
        Enum = 1 << 8,
        TypeDef = 1 << 9,
        Extends = 1 << 10,
        Implements = 1 << 11,

        Native = 1 << 12,
        Intrinsic = 1 << 13,
        Extern = 1 << 14,
        Final = 1 << 15,
        Dynamic = 1 << 16,
        Static = 1 << 17,
        Override = 1 << 18,

        Constant = 1 << 19,
        Variable = 1 << 20,
        Function = 1 << 21,
        Getter = 1 << 22,
        Setter = 1 << 23,
        HXProperty = 1 << 24,
        Constructor = 1 << 25,

        LocalVar = 1 << 26,
        ParameterVar = 1 << 27,
        AutomaticVar = 1 << 28,

        Declaration = 1 << 29,
        Template = 1 << 30,
        DocTemplate = 1L << 31,
        CodeTemplate = 1L << 32
    }

    public enum ASMetaKind
    {
        Unknown, Event, Style, Effect, Exclude, Include, DefaultProperty, MaxChildren
    }
}