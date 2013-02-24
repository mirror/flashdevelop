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
        Abstract = 1 << 10,
        Extends = 1 << 11,
        Implements = 1 << 12,
        Using = 1 << 13,

        Native = 1 << 14,
        Intrinsic = 1 << 15,
        Extern = 1 << 16,
        Final = 1 << 17,
        Dynamic = 1 << 18,
        Static = 1 << 19,
        Override = 1 << 20,

        Constant = 1 << 21,
        Variable = 1 << 22,
        Function = 1 << 23,
        Getter = 1 << 24,
        Setter = 1 << 25,
        HXProperty = 1 << 26,
        Constructor = 1 << 27,

        LocalVar = 1 << 28,
        ParameterVar = 1 << 29,
        AutomaticVar = 1 << 30,

        Declaration = 1L << 31,
        Template = 1L << 32,
        DocTemplate = 1L << 33,
        CodeTemplate = 1L << 34
    }

    public enum ASMetaKind
    {
        Unknown, Event, Style, Effect, Exclude, Include, DefaultProperty, MaxChildren
    }
}