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
        Using = 1 << 12,

        Native = 1 << 13,
        Intrinsic = 1 << 14,
        Extern = 1 << 15,
        Final = 1 << 16,
        Dynamic = 1 << 17,
        Static = 1 << 18,
        Override = 1 << 19,

        Constant = 1 << 20,
        Variable = 1 << 21,
        Function = 1 << 22,
        Getter = 1 << 23,
        Setter = 1 << 24,
        HXProperty = 1 << 25,
        Constructor = 1 << 26,

        LocalVar = 1 << 27,
        ParameterVar = 1 << 28,
        AutomaticVar = 1 << 29,

        Declaration = 1L << 30,
        Template = 1L << 31,
        DocTemplate = 1L << 32,
        CodeTemplate = 1L << 33
    }

    public enum ASMetaKind
    {
        Unknown, Event, Style, Effect, Exclude, Include, DefaultProperty, MaxChildren
    }
}