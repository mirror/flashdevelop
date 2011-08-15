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
        Class = 1 << 5,
        Interface = 1 << 6,
        Enum = 1 << 7,
        TypeDef = 1 << 8,
        Extends = 1 << 9,
        Implements = 1 << 10,

        Native = 1 << 11,
        Intrinsic = 1 << 12,
        Extern = 1 << 13,
        Final = 1 << 14,
        Dynamic = 1 << 15,
        Static = 1 << 16,
        Override = 1 << 17,

        Constant = 1 << 18,
        Variable = 1 << 19,
        Function = 1 << 20,
        Getter = 1 << 21,
        Setter = 1 << 22,
        HXProperty = 1 << 23,
        Constructor = 1 << 24,

        LocalVar = 1 << 25,
        ParameterVar = 1 << 26,
        AutomaticVar = 1 << 27,

        Declaration = 1 << 28,
        Template = 1 << 29,
        DocTemplate = 1 << 30,
        CodeTemplate = 1L << 31
    }

    public enum ASMetaKind
    {
        Unknown, Event, Style, Effect, Exclude, Include, DefaultProperty, MaxChildren
    }
}