//*****************************************************************//
//                                                                 //
// This file is generated automatically by Aurigma COM to .NET 1.0 //
//                                                                 //
//*****************************************************************//

using System;
using System.IO;
using System.Reflection;
using System.ComponentModel;
using System.Runtime.InteropServices;
using System.Runtime.CompilerServices;

// Type library name: stdole
// Type library description: OLE Automation
// Type library version: 2.0
// Type library language: Neutral
// Type library guid: {00020430-0000-0000-C000-000000000046}
// Type library source file name: C:\WINDOWS\System32\stdole2.tlb

namespace Interop.stdole
{
  /// <summary><para>LoadPictureConstants enumeration.</para></summary>
  [Guid("E6C8FA08-BD9F-11D0-985E-00C04FC29993")]
  [TypeLibType((short)0)]
  public enum LoadPictureConstants
  {
    /// <summary><para><c>Default</c> constant of <c>LoadPictureConstants</c> enumeration.  </para><para>Constant value is 0.</para></summary>
    Default = 0,

    /// <summary><para><c>Monochrome</c> constant of <c>LoadPictureConstants</c> enumeration.  </para><para>Constant value is 1.</para></summary>
    Monochrome = 1,

    /// <summary><para><c>VgaColor</c> constant of <c>LoadPictureConstants</c> enumeration.  </para><para>Constant value is 2.</para></summary>
    VgaColor = 2,

    /// <summary><para><c>Color</c> constant of <c>LoadPictureConstants</c> enumeration.  </para><para>Constant value is 4.</para></summary>
    Color = 4
  }

  /// <summary><para>OLE_TRISTATE enumeration.</para></summary>
  [Guid("6650430A-BE0F-101A-8BBB-00AA00300CAB")]
  [TypeLibType((short)0)]
  public enum OLE_TRISTATE
  {
    /// <summary><para><c>Unchecked</c> constant of <c>OLE_TRISTATE</c> enumeration.  </para><para>Constant value is 0.</para></summary>
    Unchecked = 0,

    /// <summary><para><c>Checked</c> constant of <c>OLE_TRISTATE</c> enumeration.  </para><para>Constant value is 1.</para></summary>
    Checked = 1,

    /// <summary><para><c>Gray</c> constant of <c>OLE_TRISTATE</c> enumeration.  </para><para>Constant value is 2.</para></summary>
    Gray = 2
  }

  /// <summary><para><c>DISPPARAMS</c> record.</para></summary>
  [TypeLibType((short)512)]
  [StructLayout(LayoutKind.Sequential)]
  public struct DISPPARAMS // RECORD
  {
    /// <summary><para><c>rgvarg</c> field of <c>DISPPARAMS</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>rgvarg</c> field was the following:  <c>VARIANT* rgvarg</c>;</para></remarks>
    // IDL: VARIANT* rgvarg;
    // VB6: rgvarg As Long
    [ComConversionLoss]
    [MarshalAs(UnmanagedType.I4)]
    public IntPtr rgvarg;

    /// <summary><para><c>rgdispidNamedArgs</c> field of <c>DISPPARAMS</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>rgdispidNamedArgs</c> field was the following:  <c>long* rgdispidNamedArgs</c>;</para></remarks>
    // IDL: long* rgdispidNamedArgs;
    // VB6: rgdispidNamedArgs As Long
    [ComConversionLoss]
    [MarshalAs(UnmanagedType.I4)]
    public IntPtr rgdispidNamedArgs;

    /// <summary><para><c>cArgs</c> field of <c>DISPPARAMS</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>cArgs</c> field was the following:  <c>unsigned int cArgs</c>;</para></remarks>
    // IDL: unsigned int cArgs;
    // VB6: cArgs As Long
    public uint cArgs;

    /// <summary><para><c>cNamedArgs</c> field of <c>DISPPARAMS</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>cNamedArgs</c> field was the following:  <c>unsigned int cNamedArgs</c>;</para></remarks>
    // IDL: unsigned int cNamedArgs;
    // VB6: cNamedArgs As Long
    public uint cNamedArgs;
  }

  /// <summary><para><c>EXCEPINFO</c> record.</para></summary>
  [TypeLibType((short)512)]
  [StructLayout(LayoutKind.Sequential)]
  public struct EXCEPINFO // RECORD
  {
    /// <summary><para><c>wCode</c> field of <c>EXCEPINFO</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>wCode</c> field was the following:  <c>unsigned short wCode</c>;</para></remarks>
    // IDL: unsigned short wCode;
    // VB6: wCode As Integer
    public ushort wCode;

    /// <summary><para><c>wReserved</c> field of <c>EXCEPINFO</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>wReserved</c> field was the following:  <c>unsigned short wReserved</c>;</para></remarks>
    // IDL: unsigned short wReserved;
    // VB6: wReserved As Integer
    public ushort wReserved;

    /// <summary><para><c>bstrSource</c> field of <c>EXCEPINFO</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>bstrSource</c> field was the following:  <c>BSTR bstrSource</c>;</para></remarks>
    // IDL: BSTR bstrSource;
    // VB6: bstrSource As String
    [MarshalAs(UnmanagedType.BStr)]
    public string bstrSource;

    /// <summary><para><c>bstrDescription</c> field of <c>EXCEPINFO</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>bstrDescription</c> field was the following:  <c>BSTR bstrDescription</c>;</para></remarks>
    // IDL: BSTR bstrDescription;
    // VB6: bstrDescription As String
    [MarshalAs(UnmanagedType.BStr)]
    public string bstrDescription;

    /// <summary><para><c>bstrHelpFile</c> field of <c>EXCEPINFO</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>bstrHelpFile</c> field was the following:  <c>BSTR bstrHelpFile</c>;</para></remarks>
    // IDL: BSTR bstrHelpFile;
    // VB6: bstrHelpFile As String
    [MarshalAs(UnmanagedType.BStr)]
    public string bstrHelpFile;

    /// <summary><para><c>dwHelpContext</c> field of <c>EXCEPINFO</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>dwHelpContext</c> field was the following:  <c>unsigned long dwHelpContext</c>;</para></remarks>
    // IDL: unsigned long dwHelpContext;
    // VB6: dwHelpContext As Long
    public uint dwHelpContext;

    /// <summary><para><c>pvReserved</c> field of <c>EXCEPINFO</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>pvReserved</c> field was the following:  <c>void* pvReserved</c>;</para></remarks>
    // IDL: void* pvReserved;
    // VB6: pvReserved As Long
    [ComConversionLoss]
    [MarshalAs(UnmanagedType.I4)]
    public IntPtr pvReserved;

    /// <summary><para><c>pfnDeferredFillIn</c> field of <c>EXCEPINFO</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>pfnDeferredFillIn</c> field was the following:  <c>void* pfnDeferredFillIn</c>;</para></remarks>
    // IDL: void* pfnDeferredFillIn;
    // VB6: pfnDeferredFillIn As Long
    [ComConversionLoss]
    [MarshalAs(UnmanagedType.I4)]
    public IntPtr pfnDeferredFillIn;

    /// <summary><para><c>scode</c> field of <c>EXCEPINFO</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>scode</c> field was the following:  <c>long scode</c>;</para></remarks>
    // IDL: long scode;
    // VB6: scode As Long
    public int scode;
  }

  /// <summary><para><c>GUID</c> record.</para></summary>
  [TypeLibType((short)16)]
  [StructLayout(LayoutKind.Sequential)]
  public struct GUID // RECORD
  {
    /// <summary><para><c>Data1</c> field of <c>GUID</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Data1</c> field was the following:  <c>unsigned long Data1</c>;</para></remarks>
    // IDL: unsigned long Data1;
    // VB6: Data1 As Long
    public uint Data1;

    /// <summary><para><c>Data2</c> field of <c>GUID</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Data2</c> field was the following:  <c>unsigned short Data2</c>;</para></remarks>
    // IDL: unsigned short Data2;
    // VB6: Data2 As Integer
    public ushort Data2;

    /// <summary><para><c>Data3</c> field of <c>GUID</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Data3</c> field was the following:  <c>unsigned short Data3</c>;</para></remarks>
    // IDL: unsigned short Data3;
    // VB6: Data3 As Integer
    public ushort Data3;

    /// <summary><para><c>Data4</c> field of <c>GUID</c> record.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Data4</c> field was the following:  <c>unsigned byte[8] Data4</c>;</para></remarks>
    // IDL: unsigned byte[8] Data4;
    // VB6: Data4(8) As Byte
    [MarshalAs(UnmanagedType.LPArray, SizeConst = 8)]
    public byte[] Data4;
  }

  /// <summary><para><c>IFontDisp</c> interface.</para></summary>
  [Guid("BEF6E003-A874-101A-8BBA-00AA00300CAB")]
  [ComImport]
  [TypeLibType((short)4096)]
  [DefaultMember("Name")]
  [InterfaceTypeAttribute(ComInterfaceType.InterfaceIsIDispatch)]
  public interface IFontDisp
  {
    /// <summary><para>Name property of IFontDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Name</c> property was the following:  <c>BSTR Name</c>;</para></remarks>
    // IDL: BSTR Name;
    // VB6: Property Name As String
    [DispId(0)]
    string Name
    {
      [return: MarshalAs(UnmanagedType.BStr)]
      get;
      [param: MarshalAs(UnmanagedType.BStr)]
      set;
    }

    /// <summary><para>Size property of IFontDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Size</c> property was the following:  <c>CURRENCY Size</c>;</para></remarks>
    // IDL: CURRENCY Size;
    // VB6: Property Size As Currency
    [ComConversionLoss]
    [DispId(2)]
    double Size
    {
      [return: MarshalAs(UnmanagedType.Currency)]
      get;
      [param: MarshalAs(UnmanagedType.Currency)]
      set;
    }

    /// <summary><para>Bold property of IFontDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Bold</c> property was the following:  <c>VARIANT_BOOL Bold</c>;</para></remarks>
    // IDL: VARIANT_BOOL Bold;
    // VB6: Property Bold As Boolean
    [DispId(3)]
    bool Bold
    {
      [return: MarshalAs(UnmanagedType.VariantBool)]
      get;
      [param: MarshalAs(UnmanagedType.VariantBool)]
      set;
    }

    /// <summary><para>Italic property of IFontDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Italic</c> property was the following:  <c>VARIANT_BOOL Italic</c>;</para></remarks>
    // IDL: VARIANT_BOOL Italic;
    // VB6: Property Italic As Boolean
    [DispId(4)]
    bool Italic
    {
      [return: MarshalAs(UnmanagedType.VariantBool)]
      get;
      [param: MarshalAs(UnmanagedType.VariantBool)]
      set;
    }

    /// <summary><para>Underline property of IFontDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Underline</c> property was the following:  <c>VARIANT_BOOL Underline</c>;</para></remarks>
    // IDL: VARIANT_BOOL Underline;
    // VB6: Property Underline As Boolean
    [DispId(5)]
    bool Underline
    {
      [return: MarshalAs(UnmanagedType.VariantBool)]
      get;
      [param: MarshalAs(UnmanagedType.VariantBool)]
      set;
    }

    /// <summary><para>Strikethrough property of IFontDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Strikethrough</c> property was the following:  <c>VARIANT_BOOL Strikethrough</c>;</para></remarks>
    // IDL: VARIANT_BOOL Strikethrough;
    // VB6: Property Strikethrough As Boolean
    [DispId(6)]
    bool Strikethrough
    {
      [return: MarshalAs(UnmanagedType.VariantBool)]
      get;
      [param: MarshalAs(UnmanagedType.VariantBool)]
      set;
    }

    /// <summary><para>Weight property of IFontDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Weight</c> property was the following:  <c>short Weight</c>;</para></remarks>
    // IDL: short Weight;
    // VB6: Property Weight As Integer
    [DispId(7)]
    short Weight
    {
      get;
      set;
    }

    /// <summary><para>Charset property of IFontDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Charset</c> property was the following:  <c>short Charset</c>;</para></remarks>
    // IDL: short Charset;
    // VB6: Property Charset As Integer
    [DispId(8)]
    short Charset
    {
      get;
      set;
    }
  }

  /// <summary><para><c>IFontEventsDisp</c> interface.</para></summary>
  [Guid("4EF6100A-AF88-11D0-9846-00C04FC29993")]
  [ComImport]
  [TypeLibType((short)4112)]
  [InterfaceTypeAttribute(ComInterfaceType.InterfaceIsIDispatch)]
  public interface IFontEventsDisp
  {
    /// <summary><para><c>FontChanged</c> method of <c>IFontEventsDisp</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>FontChanged</c> method was the following:  <c>HRESULT FontChanged (BSTR PropertyName)</c>;</para></remarks>
    // IDL: HRESULT FontChanged (BSTR PropertyName);
    // VB6: Sub FontChanged (ByVal PropertyName As String)
    [DispId(9)]
    void FontChanged ([MarshalAs(UnmanagedType.BStr)] string PropertyName);
  }

  /// <summary><para><c>IPictureDisp</c> interface.</para></summary>
  [Guid("7BF80981-BF32-101A-8BBB-00AA00300CAB")]
  [ComImport]
  [TypeLibType((short)4096)]
  [DefaultMember("Handle")]
  [InterfaceTypeAttribute(ComInterfaceType.InterfaceIsIDispatch)]
  public interface IPictureDisp
  {
    /// <summary><para><c>Render</c> method of <c>IPictureDisp</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Render</c> method was the following:  <c>HRESULT Render (int hdc, long x, long y, long cx, long cy, long xSrc, long ySrc, long cxSrc, long cySrc, void* prcWBounds)</c>;</para></remarks>
    // IDL: HRESULT Render (int hdc, long x, long y, long cx, long cy, long xSrc, long ySrc, long cxSrc, long cySrc, void* prcWBounds);
    // VB6: Sub Render (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal cxSrc As Long, ByVal cySrc As Long, ByVal prcWBounds As Long)
    [DispId(6)]
    void Render (int hdc, int x, int y, int cx, int cy, int xSrc, int ySrc, int cxSrc, int cySrc, [ComConversionLoss, MarshalAs(UnmanagedType.I4)] IntPtr prcWBounds);

    /// <summary><para>Handle property of IPictureDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Handle</c> property was the following:  <c>int Handle</c>;</para></remarks>
    // IDL: int Handle;
    // VB6: Property Handle As Long
    [DispId(0)]
    int Handle
    {
      get;
    }

    /// <summary><para>hPal property of IPictureDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>hPal</c> property was the following:  <c>int hPal</c>;</para></remarks>
    // IDL: int hPal;
    // VB6: Property hPal As Long
    [DispId(2)]
    int hPal
    {
      get;
      set;
    }

    /// <summary><para>Type property of IPictureDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Type</c> property was the following:  <c>short Type</c>;</para></remarks>
    // IDL: short Type;
    // VB6: Property Type As Integer
    [DispId(3)]
    short Type
    {
      get;
    }

    /// <summary><para>Width property of IPictureDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Width</c> property was the following:  <c>long Width</c>;</para></remarks>
    // IDL: long Width;
    // VB6: Property Width As Long
    [DispId(4)]
    int Width
    {
      get;
    }

    /// <summary><para>Height property of IPictureDisp interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Height</c> property was the following:  <c>long Height</c>;</para></remarks>
    // IDL: long Height;
    // VB6: Property Height As Long
    [DispId(5)]
    int Height
    {
      get;
    }
  }

  /// <summary><para><c>Font</c> interface.</para></summary>
  [Guid("BEF6E003-A874-101A-8BBA-00AA00300CAB")]
  [ComImport]
  [TypeLibType((short)4096)]
  [DefaultMember("Name")]
  [InterfaceTypeAttribute(ComInterfaceType.InterfaceIsIDispatch)]
  public interface Font
  {
    /// <summary><para>Name property of Font interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Name</c> property was the following:  <c>BSTR Name</c>;</para></remarks>
    // IDL: BSTR Name;
    // VB6: Property Name As String
    [DispId(0)]
    string Name
    {
      [return: MarshalAs(UnmanagedType.BStr)]
      get;
      [param: MarshalAs(UnmanagedType.BStr)]
      set;
    }

    /// <summary><para>Size property of Font interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Size</c> property was the following:  <c>CURRENCY Size</c>;</para></remarks>
    // IDL: CURRENCY Size;
    // VB6: Property Size As Currency
    [ComConversionLoss]
    [DispId(2)]
    double Size
    {
      [return: MarshalAs(UnmanagedType.Currency)]
      get;
      [param: MarshalAs(UnmanagedType.Currency)]
      set;
    }

    /// <summary><para>Bold property of Font interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Bold</c> property was the following:  <c>VARIANT_BOOL Bold</c>;</para></remarks>
    // IDL: VARIANT_BOOL Bold;
    // VB6: Property Bold As Boolean
    [DispId(3)]
    bool Bold
    {
      [return: MarshalAs(UnmanagedType.VariantBool)]
      get;
      [param: MarshalAs(UnmanagedType.VariantBool)]
      set;
    }

    /// <summary><para>Italic property of Font interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Italic</c> property was the following:  <c>VARIANT_BOOL Italic</c>;</para></remarks>
    // IDL: VARIANT_BOOL Italic;
    // VB6: Property Italic As Boolean
    [DispId(4)]
    bool Italic
    {
      [return: MarshalAs(UnmanagedType.VariantBool)]
      get;
      [param: MarshalAs(UnmanagedType.VariantBool)]
      set;
    }

    /// <summary><para>Underline property of Font interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Underline</c> property was the following:  <c>VARIANT_BOOL Underline</c>;</para></remarks>
    // IDL: VARIANT_BOOL Underline;
    // VB6: Property Underline As Boolean
    [DispId(5)]
    bool Underline
    {
      [return: MarshalAs(UnmanagedType.VariantBool)]
      get;
      [param: MarshalAs(UnmanagedType.VariantBool)]
      set;
    }

    /// <summary><para>Strikethrough property of Font interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Strikethrough</c> property was the following:  <c>VARIANT_BOOL Strikethrough</c>;</para></remarks>
    // IDL: VARIANT_BOOL Strikethrough;
    // VB6: Property Strikethrough As Boolean
    [DispId(6)]
    bool Strikethrough
    {
      [return: MarshalAs(UnmanagedType.VariantBool)]
      get;
      [param: MarshalAs(UnmanagedType.VariantBool)]
      set;
    }

    /// <summary><para>Weight property of Font interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Weight</c> property was the following:  <c>short Weight</c>;</para></remarks>
    // IDL: short Weight;
    // VB6: Property Weight As Integer
    [DispId(7)]
    short Weight
    {
      get;
      set;
    }

    /// <summary><para>Charset property of Font interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Charset</c> property was the following:  <c>short Charset</c>;</para></remarks>
    // IDL: short Charset;
    // VB6: Property Charset As Integer
    [DispId(8)]
    short Charset
    {
      get;
      set;
    }
  }

  /// <summary><para><c>FontEvents</c> interface.  </para><para>Event interface for the Font object</para></summary>
  // Event interface for the Font object
  [Guid("4EF6100A-AF88-11D0-9846-00C04FC29993")]
  [ComImport]
  [TypeLibType((short)4112)]
  [InterfaceTypeAttribute(ComInterfaceType.InterfaceIsIDispatch)]
  public interface FontEvents
  {
    /// <summary><para><c>FontChanged</c> method of <c>FontEvents</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>FontChanged</c> method was the following:  <c>HRESULT FontChanged (BSTR PropertyName)</c>;</para></remarks>
    // IDL: HRESULT FontChanged (BSTR PropertyName);
    // VB6: Sub FontChanged (ByVal PropertyName As String)
    [DispId(9)]
    void FontChanged ([MarshalAs(UnmanagedType.BStr)] string PropertyName);
  }

  /// <summary><para>Delegate for handling <c>FontChanged</c> event of <c>FontEvents</c> interface.</para></summary>
  /// <remarks><para>An original IDL definition of <c>FontChanged</c> event was the following:  <c>HRESULT FontEvents_FontChangedEventHandler (BSTR PropertyName)</c>;</para></remarks>
  // IDL: HRESULT FontEvents_FontChangedEventHandler (BSTR PropertyName);
  // VB6: Sub FontEvents_FontChangedEventHandler (ByVal PropertyName As String)
  public delegate void FontEvents_FontChangedEventHandler ([MarshalAs(UnmanagedType.BStr)] string PropertyName);

  /// <summary><para>Declaration of events of <c>FontEvents</c> source interface.  </para><para>Event interface for the Font object</para></summary>
  // Event interface for the Font object
  [ComEventInterface(typeof(FontEvents),typeof(FontEvents_EventProvider))]
  [ComVisible(false)]
  public interface FontEvents_Event
  {
    /// <summary><para><c>FontChanged</c> event of <c>FontEvents</c> interface.</para></summary>
    event FontEvents_FontChangedEventHandler FontChanged;
  }

  [ClassInterface(ClassInterfaceType.None)]
  internal class FontEvents_SinkHelper: FontEvents
  {
    public int Cookie = 0;

    public event FontEvents_FontChangedEventHandler FontChangedDelegate = null;
    public void Set_FontChangedDelegate(FontEvents_FontChangedEventHandler deleg)
    {
      FontChangedDelegate = deleg;
    }
    public bool Is_FontChangedDelegate(FontEvents_FontChangedEventHandler deleg)
    {
      return (FontChangedDelegate == deleg);
    }
    public void Clear_FontChangedDelegate()
    {
      FontChangedDelegate = null;
    }
    void FontEvents.FontChanged (string PropertyName)
    {
      if (FontChangedDelegate!=null)
        FontChangedDelegate(PropertyName);
    }
  }

  internal class FontEvents_EventProvider: IDisposable, FontEvents_Event
  {
    UCOMIConnectionPointContainer ConnectionPointContainer;
    UCOMIConnectionPoint ConnectionPoint;
    FontEvents_SinkHelper EventSinkHelper;
    int ConnectionCount;

    // Constructor: remember ConnectionPointContainer
    FontEvents_EventProvider(object CPContainer) : base()
    {
      ConnectionPointContainer = (UCOMIConnectionPointContainer)CPContainer;
    }

    // Force disconnection from ActiveX event source
    ~FontEvents_EventProvider()
    {
      Disconnect();
      ConnectionPointContainer = null;
    }

    // Aletnative to destructor
    void IDisposable.Dispose()
    {
      Disconnect();
      ConnectionPointContainer = null;
      System.GC.SuppressFinalize(this);
    }

    // Connect to ActiveX event source
    void Connect()
    {
      if (ConnectionPoint == null)
      {
        ConnectionCount = 0;
        Guid g = new Guid("4EF6100A-AF88-11D0-9846-00C04FC29993");
        ConnectionPointContainer.FindConnectionPoint(ref g, out ConnectionPoint);
        EventSinkHelper = new FontEvents_SinkHelper();
        ConnectionPoint.Advise(EventSinkHelper, out EventSinkHelper.Cookie);
      }
    }

    // Disconnect from ActiveX event source
    void Disconnect()
    {
      System.Threading.Monitor.Enter(this);
      try {
        if (EventSinkHelper != null)
          ConnectionPoint.Unadvise(EventSinkHelper.Cookie);
        ConnectionPoint = null;
        EventSinkHelper = null;
      } catch { }
      System.Threading.Monitor.Exit(this);
    }

    // If no event handler present then disconnect from ActiveX event source
    void CheckDisconnect()
    {
      ConnectionCount--;
      if (ConnectionCount <= 0)
        Disconnect();
    }

    event FontEvents_FontChangedEventHandler FontEvents_Event.FontChanged
    {
      add
      {
        System.Threading.Monitor.Enter(this);
        try {
          Connect();
          EventSinkHelper.FontChangedDelegate += value;
          ConnectionCount++;
        } catch { }
        System.Threading.Monitor.Exit(this);
      }
      remove
      {
        if (EventSinkHelper != null)
        {
          System.Threading.Monitor.Enter(this);
          try {
            EventSinkHelper.FontChangedDelegate -= value;
            CheckDisconnect();
          } catch { }
          System.Threading.Monitor.Exit(this);
        }
      }
    }
  }

  /// <summary><para><c>Picture</c> interface.</para></summary>
  [Guid("7BF80981-BF32-101A-8BBB-00AA00300CAB")]
  [ComImport]
  [TypeLibType((short)4096)]
  [DefaultMember("Handle")]
  [InterfaceTypeAttribute(ComInterfaceType.InterfaceIsIDispatch)]
  public interface Picture
  {
    /// <summary><para><c>Render</c> method of <c>Picture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Render</c> method was the following:  <c>HRESULT Render (int hdc, long x, long y, long cx, long cy, long xSrc, long ySrc, long cxSrc, long cySrc, void* prcWBounds)</c>;</para></remarks>
    // IDL: HRESULT Render (int hdc, long x, long y, long cx, long cy, long xSrc, long ySrc, long cxSrc, long cySrc, void* prcWBounds);
    // VB6: Sub Render (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal cxSrc As Long, ByVal cySrc As Long, ByVal prcWBounds As Long)
    [DispId(6)]
    void Render (int hdc, int x, int y, int cx, int cy, int xSrc, int ySrc, int cxSrc, int cySrc, [ComConversionLoss, MarshalAs(UnmanagedType.I4)] IntPtr prcWBounds);

    /// <summary><para>Handle property of Picture interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Handle</c> property was the following:  <c>int Handle</c>;</para></remarks>
    // IDL: int Handle;
    // VB6: Property Handle As Long
    [DispId(0)]
    int Handle
    {
      get;
    }

    /// <summary><para>hPal property of Picture interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>hPal</c> property was the following:  <c>int hPal</c>;</para></remarks>
    // IDL: int hPal;
    // VB6: Property hPal As Long
    [DispId(2)]
    int hPal
    {
      get;
      set;
    }

    /// <summary><para>Type property of Picture interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Type</c> property was the following:  <c>short Type</c>;</para></remarks>
    // IDL: short Type;
    // VB6: Property Type As Integer
    [DispId(3)]
    short Type
    {
      get;
    }

    /// <summary><para>Width property of Picture interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Width</c> property was the following:  <c>long Width</c>;</para></remarks>
    // IDL: long Width;
    // VB6: Property Width As Long
    [DispId(4)]
    int Width
    {
      get;
    }

    /// <summary><para>Height property of Picture interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Height</c> property was the following:  <c>long Height</c>;</para></remarks>
    // IDL: long Height;
    // VB6: Property Height As Long
    [DispId(5)]
    int Height
    {
      get;
    }
  }

  /// <summary><para><c>IDispatch</c> interface.</para></summary>
  [Guid("00020400-0000-0000-C000-000000000046")]
  [ComImport]
  [TypeLibType((short)512)]
  [InterfaceTypeAttribute(ComInterfaceType.InterfaceIsIUnknown)]
  public interface IDispatch
  {
    /// <summary><para><c>GetTypeInfoCount</c> method of <c>IDispatch</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>GetTypeInfoCount</c> method was the following:  <c>HRESULT GetTypeInfoCount ([out] unsigned int* pctinfo)</c>;</para></remarks>
    // IDL: HRESULT GetTypeInfoCount ([out] unsigned int* pctinfo);
    // VB6: Sub GetTypeInfoCount (pctinfo As Long)
    void GetTypeInfoCount ([Out] out uint pctinfo);

    /// <summary><para><c>GetTypeInfo</c> method of <c>IDispatch</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>GetTypeInfo</c> method was the following:  <c>HRESULT GetTypeInfo (unsigned int itinfo, unsigned long lcid, void** pptinfo)</c>;</para></remarks>
    // IDL: HRESULT GetTypeInfo (unsigned int itinfo, unsigned long lcid, void** pptinfo);
    // VB6: Sub GetTypeInfo (ByVal itinfo As Long, ByVal lcid As Long, pptinfo As Long)
    void GetTypeInfo (uint itinfo, uint lcid, [ComConversionLoss, MarshalAs(UnmanagedType.I4)] IntPtr pptinfo);

    /// <summary><para><c>GetIDsOfNames</c> method of <c>IDispatch</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>GetIDsOfNames</c> method was the following:  <c>HRESULT GetIDsOfNames ([in] GUID* riid, byte** rgszNames, unsigned int cNames, unsigned long lcid, [out] long* rgdispid)</c>;</para></remarks>
    // IDL: HRESULT GetIDsOfNames ([in] GUID* riid, byte** rgszNames, unsigned int cNames, unsigned long lcid, [out] long* rgdispid);
    // VB6: Sub GetIDsOfNames (riid As GUID, ByVal rgszNames As Long, ByVal cNames As Long, ByVal lcid As Long, rgdispid As Long)
    void GetIDsOfNames ([In] ref GUID riid, [ComConversionLoss, MarshalAs(UnmanagedType.I4)] IntPtr rgszNames, uint cNames, uint lcid, [Out] out int rgdispid);

    /// <summary><para><c>Invoke</c> method of <c>IDispatch</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Invoke</c> method was the following:  <c>HRESULT Invoke (long dispidMember, [in] GUID* riid, unsigned long lcid, unsigned short wFlags, [in] DISPPARAMS* pdispparams, [out] VARIANT* pvarResult, [out] EXCEPINFO* pexcepinfo, [out] unsigned int* puArgErr)</c>;</para></remarks>
    // IDL: HRESULT Invoke (long dispidMember, [in] GUID* riid, unsigned long lcid, unsigned short wFlags, [in] DISPPARAMS* pdispparams, [out] VARIANT* pvarResult, [out] EXCEPINFO* pexcepinfo, [out] unsigned int* puArgErr);
    // VB6: Sub Invoke (ByVal dispidMember As Long, riid As GUID, ByVal lcid As Long, ByVal wFlags As Integer, pdispparams As DISPPARAMS, pvarResult As Any, pexcepinfo As EXCEPINFO, puArgErr As Long)
    void Invoke (int dispidMember, [In] ref GUID riid, uint lcid, ushort wFlags, [In] ref DISPPARAMS pdispparams, [Out] out object pvarResult, [Out] out EXCEPINFO pexcepinfo, [Out] out uint puArgErr);
  }

  /// <summary><para><c>IEnumVARIANT</c> interface.</para></summary>
  [Guid("00020404-0000-0000-C000-000000000046")]
  [ComImport]
  [TypeLibType((short)16)]
  [InterfaceTypeAttribute(ComInterfaceType.InterfaceIsIUnknown)]
  public interface IEnumVARIANT
  {
    /// <summary><para><c>Next</c> method of <c>IEnumVARIANT</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Next</c> method was the following:  <c>HRESULT Next (unsigned long celt, [in] VARIANT* rgvar, [out] unsigned long* pceltFetched)</c>;</para></remarks>
    // IDL: HRESULT Next (unsigned long celt, [in] VARIANT* rgvar, [out] unsigned long* pceltFetched);
    // VB6: Sub Next (ByVal celt As Long, rgvar As Any, pceltFetched As Long)
    void Next (uint celt, [In] ref object rgvar, [Out] out uint pceltFetched);

    /// <summary><para><c>Skip</c> method of <c>IEnumVARIANT</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Skip</c> method was the following:  <c>HRESULT Skip (unsigned long celt)</c>;</para></remarks>
    // IDL: HRESULT Skip (unsigned long celt);
    // VB6: Sub Skip (ByVal celt As Long)
    void Skip (uint celt);

    /// <summary><para><c>Reset</c> method of <c>IEnumVARIANT</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Reset</c> method was the following:  <c>HRESULT Reset (void)</c>;</para></remarks>
    // IDL: HRESULT Reset (void);
    // VB6: Sub Reset
    void Reset ();

    /// <summary><para><c>Clone</c> method of <c>IEnumVARIANT</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Clone</c> method was the following:  <c>HRESULT Clone ([out] IEnumVARIANT** ppenum)</c>;</para></remarks>
    // IDL: HRESULT Clone ([out] IEnumVARIANT** ppenum);
    // VB6: Sub Clone (ppenum As IEnumVARIANT)
    void Clone ([Out] out IEnumVARIANT ppenum);
  }

  /// <summary><para><c>IFont</c> interface.  </para><para>Font Object</para></summary>
  // Font Object
  [Guid("BEF6E002-A874-101A-8BBA-00AA00300CAB")]
  [ComImport]
  [TypeLibType((short)16)]
  [InterfaceTypeAttribute(ComInterfaceType.InterfaceIsIUnknown)]
  public interface IFont
  {
    /// <summary><para><c>Name</c> property get of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Name</c> property get was the following:  <c>HRESULT Name ([out, retval] BSTR* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Name ([out, retval] BSTR* ReturnValue);
    // VB6: Function Name () As String
    [return: MarshalAs(UnmanagedType.BStr)]
    string Name () /* property get method */;

    /// <summary><para><c>Name</c> property put of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Name</c> property put was the following:  <c>HRESULT put_Name (BSTR pname)</c>;</para></remarks>
    // IDL: HRESULT put_Name (BSTR pname);
    // VB6: Sub put_Name (ByVal pname As String)
    void put_Name ([MarshalAs(UnmanagedType.BStr)] string pname) /* property put method */;

    /// <summary><para><c>Size</c> property get of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Size</c> property get was the following:  <c>HRESULT Size ([out, retval] CURRENCY* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Size ([out, retval] CURRENCY* ReturnValue);
    // VB6: Function Size () As Currency
    [return: MarshalAs(UnmanagedType.Currency)]
    double Size () /* property get method */;

    /// <summary><para><c>Size</c> property put of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Size</c> property put was the following:  <c>HRESULT put_Size (CURRENCY psize)</c>;</para></remarks>
    // IDL: HRESULT put_Size (CURRENCY psize);
    // VB6: Sub put_Size (ByVal psize As Currency)
    void put_Size ([ComConversionLoss, MarshalAs(UnmanagedType.Currency)] double psize) /* property put method */;

    /// <summary><para><c>Bold</c> property get of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Bold</c> property get was the following:  <c>HRESULT Bold ([out, retval] VARIANT_BOOL* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Bold ([out, retval] VARIANT_BOOL* ReturnValue);
    // VB6: Function Bold () As Boolean
    [return: MarshalAs(UnmanagedType.VariantBool)]
    bool Bold () /* property get method */;

    /// <summary><para><c>Bold</c> property put of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Bold</c> property put was the following:  <c>HRESULT put_Bold (VARIANT_BOOL pbold)</c>;</para></remarks>
    // IDL: HRESULT put_Bold (VARIANT_BOOL pbold);
    // VB6: Sub put_Bold (ByVal pbold As Boolean)
    void put_Bold ([MarshalAs(UnmanagedType.VariantBool)] bool pbold) /* property put method */;

    /// <summary><para><c>Italic</c> property get of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Italic</c> property get was the following:  <c>HRESULT Italic ([out, retval] VARIANT_BOOL* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Italic ([out, retval] VARIANT_BOOL* ReturnValue);
    // VB6: Function Italic () As Boolean
    [return: MarshalAs(UnmanagedType.VariantBool)]
    bool Italic () /* property get method */;

    /// <summary><para><c>Italic</c> property put of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Italic</c> property put was the following:  <c>HRESULT put_Italic (VARIANT_BOOL pitalic)</c>;</para></remarks>
    // IDL: HRESULT put_Italic (VARIANT_BOOL pitalic);
    // VB6: Sub put_Italic (ByVal pitalic As Boolean)
    void put_Italic ([MarshalAs(UnmanagedType.VariantBool)] bool pitalic) /* property put method */;

    /// <summary><para><c>Underline</c> property get of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Underline</c> property get was the following:  <c>HRESULT Underline ([out, retval] VARIANT_BOOL* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Underline ([out, retval] VARIANT_BOOL* ReturnValue);
    // VB6: Function Underline () As Boolean
    [return: MarshalAs(UnmanagedType.VariantBool)]
    bool Underline () /* property get method */;

    /// <summary><para><c>Underline</c> property put of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Underline</c> property put was the following:  <c>HRESULT put_Underline (VARIANT_BOOL punderline)</c>;</para></remarks>
    // IDL: HRESULT put_Underline (VARIANT_BOOL punderline);
    // VB6: Sub put_Underline (ByVal punderline As Boolean)
    void put_Underline ([MarshalAs(UnmanagedType.VariantBool)] bool punderline) /* property put method */;

    /// <summary><para><c>Strikethrough</c> property get of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Strikethrough</c> property get was the following:  <c>HRESULT Strikethrough ([out, retval] VARIANT_BOOL* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Strikethrough ([out, retval] VARIANT_BOOL* ReturnValue);
    // VB6: Function Strikethrough () As Boolean
    [return: MarshalAs(UnmanagedType.VariantBool)]
    bool Strikethrough () /* property get method */;

    /// <summary><para><c>Strikethrough</c> property put of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Strikethrough</c> property put was the following:  <c>HRESULT put_Strikethrough (VARIANT_BOOL pstrikethrough)</c>;</para></remarks>
    // IDL: HRESULT put_Strikethrough (VARIANT_BOOL pstrikethrough);
    // VB6: Sub put_Strikethrough (ByVal pstrikethrough As Boolean)
    void put_Strikethrough ([MarshalAs(UnmanagedType.VariantBool)] bool pstrikethrough) /* property put method */;

    /// <summary><para><c>Weight</c> property get of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Weight</c> property get was the following:  <c>HRESULT Weight ([out, retval] short* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Weight ([out, retval] short* ReturnValue);
    // VB6: Function Weight () As Integer
    short Weight () /* property get method */;

    /// <summary><para><c>Weight</c> property put of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Weight</c> property put was the following:  <c>HRESULT put_Weight (short pweight)</c>;</para></remarks>
    // IDL: HRESULT put_Weight (short pweight);
    // VB6: Sub put_Weight (ByVal pweight As Integer)
    void put_Weight (short pweight) /* property put method */;

    /// <summary><para><c>Charset</c> property get of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Charset</c> property get was the following:  <c>HRESULT Charset ([out, retval] short* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Charset ([out, retval] short* ReturnValue);
    // VB6: Function Charset () As Integer
    short Charset () /* property get method */;

    /// <summary><para><c>Charset</c> property put of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Charset</c> property put was the following:  <c>HRESULT put_Charset (short pcharset)</c>;</para></remarks>
    // IDL: HRESULT put_Charset (short pcharset);
    // VB6: Sub put_Charset (ByVal pcharset As Integer)
    void put_Charset (short pcharset) /* property put method */;

    /// <summary><para><c>hFont</c> property get of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>hFont</c> property get was the following:  <c>HRESULT hFont ([out, retval] int* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT hFont ([out, retval] int* ReturnValue);
    // VB6: Function hFont () As Long
    int hFont () /* property get method */;

    /// <summary><para><c>Clone</c> method of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Clone</c> method was the following:  <c>HRESULT Clone ([out] IFont** ppfont)</c>;</para></remarks>
    // IDL: HRESULT Clone ([out] IFont** ppfont);
    // VB6: Sub Clone (ppfont As IFont)
    void Clone ([Out] out IFont ppfont);

    /// <summary><para><c>IsEqual</c> method of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>IsEqual</c> method was the following:  <c>HRESULT IsEqual (IFont* pfontOther)</c>;</para></remarks>
    // IDL: HRESULT IsEqual (IFont* pfontOther);
    // VB6: Sub IsEqual (ByVal pfontOther As IFont)
    void IsEqual (IFont pfontOther);

    /// <summary><para><c>SetRatio</c> method of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>SetRatio</c> method was the following:  <c>HRESULT SetRatio (long cyLogical, long cyHimetric)</c>;</para></remarks>
    // IDL: HRESULT SetRatio (long cyLogical, long cyHimetric);
    // VB6: Sub SetRatio (ByVal cyLogical As Long, ByVal cyHimetric As Long)
    void SetRatio (int cyLogical, int cyHimetric);

    /// <summary><para><c>AddRefHfont</c> method of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>AddRefHfont</c> method was the following:  <c>HRESULT AddRefHfont (int hFont)</c>;</para></remarks>
    // IDL: HRESULT AddRefHfont (int hFont);
    // VB6: Sub AddRefHfont (ByVal hFont As Long)
    void AddRefHfont (int hFont);

    /// <summary><para><c>ReleaseHfont</c> method of <c>IFont</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>ReleaseHfont</c> method was the following:  <c>HRESULT ReleaseHfont (int hFont)</c>;</para></remarks>
    // IDL: HRESULT ReleaseHfont (int hFont);
    // VB6: Sub ReleaseHfont (ByVal hFont As Long)
    void ReleaseHfont (int hFont);
  }

  /// <summary><para><c>IPicture</c> interface.  </para><para>Picture Object</para></summary>
  // Picture Object
  [Guid("7BF80980-BF32-101A-8BBB-00AA00300CAB")]
  [ComImport]
  [TypeLibType((short)16)]
  [InterfaceTypeAttribute(ComInterfaceType.InterfaceIsIUnknown)]
  public interface IPicture
  {
    /// <summary><para><c>Handle</c> property get of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Handle</c> property get was the following:  <c>HRESULT Handle ([out, retval] int* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Handle ([out, retval] int* ReturnValue);
    // VB6: Function Handle () As Long
    int Handle () /* property get method */;

    /// <summary><para><c>hPal</c> property get of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>hPal</c> property get was the following:  <c>HRESULT hPal ([out, retval] int* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT hPal ([out, retval] int* ReturnValue);
    // VB6: Function hPal () As Long
    int hPal () /* property get method */;

    /// <summary><para><c>Type</c> property get of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Type</c> property get was the following:  <c>HRESULT Type ([out, retval] short* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Type ([out, retval] short* ReturnValue);
    // VB6: Function Type () As Integer
    short Type () /* property get method */;

    /// <summary><para><c>Width</c> property get of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Width</c> property get was the following:  <c>HRESULT Width ([out, retval] long* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Width ([out, retval] long* ReturnValue);
    // VB6: Function Width () As Long
    int Width () /* property get method */;

    /// <summary><para><c>Height</c> property get of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Height</c> property get was the following:  <c>HRESULT Height ([out, retval] long* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Height ([out, retval] long* ReturnValue);
    // VB6: Function Height () As Long
    int Height () /* property get method */;

    /// <summary><para><c>Render</c> method of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Render</c> method was the following:  <c>HRESULT Render (int hdc, long x, long y, long cx, long cy, long xSrc, long ySrc, long cxSrc, long cySrc, void* prcWBounds)</c>;</para></remarks>
    // IDL: HRESULT Render (int hdc, long x, long y, long cx, long cy, long xSrc, long ySrc, long cxSrc, long cySrc, void* prcWBounds);
    // VB6: Sub Render (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal cxSrc As Long, ByVal cySrc As Long, ByVal prcWBounds As Long)
    void Render (int hdc, int x, int y, int cx, int cy, int xSrc, int ySrc, int cxSrc, int cySrc, [ComConversionLoss, MarshalAs(UnmanagedType.I4)] IntPtr prcWBounds);

    /// <summary><para><c>hPal</c> property put of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>hPal</c> property put was the following:  <c>HRESULT put_hPal (int phpal)</c>;</para></remarks>
    // IDL: HRESULT put_hPal (int phpal);
    // VB6: Sub put_hPal (ByVal phpal As Long)
    void put_hPal (int phpal) /* property put method */;

    /// <summary><para><c>CurDC</c> property get of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>CurDC</c> property get was the following:  <c>HRESULT CurDC ([out, retval] int* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT CurDC ([out, retval] int* ReturnValue);
    // VB6: Function CurDC () As Long
    int CurDC () /* property get method */;

    /// <summary><para><c>SelectPicture</c> method of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>SelectPicture</c> method was the following:  <c>HRESULT SelectPicture (int hdcIn, [out] int* phdcOut, [out] int* phbmpOut)</c>;</para></remarks>
    // IDL: HRESULT SelectPicture (int hdcIn, [out] int* phdcOut, [out] int* phbmpOut);
    // VB6: Sub SelectPicture (ByVal hdcIn As Long, phdcOut As Long, phbmpOut As Long)
    void SelectPicture (int hdcIn, [Out] out int phdcOut, [Out] out int phbmpOut);

    /// <summary><para><c>KeepOriginalFormat</c> property get of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>KeepOriginalFormat</c> property get was the following:  <c>HRESULT KeepOriginalFormat ([out, retval] VARIANT_BOOL* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT KeepOriginalFormat ([out, retval] VARIANT_BOOL* ReturnValue);
    // VB6: Function KeepOriginalFormat () As Boolean
    [return: MarshalAs(UnmanagedType.VariantBool)]
    bool KeepOriginalFormat () /* property get method */;

    /// <summary><para><c>KeepOriginalFormat</c> property put of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>KeepOriginalFormat</c> property put was the following:  <c>HRESULT put_KeepOriginalFormat (VARIANT_BOOL pfkeep)</c>;</para></remarks>
    // IDL: HRESULT put_KeepOriginalFormat (VARIANT_BOOL pfkeep);
    // VB6: Sub put_KeepOriginalFormat (ByVal pfkeep As Boolean)
    void put_KeepOriginalFormat ([MarshalAs(UnmanagedType.VariantBool)] bool pfkeep) /* property put method */;

    /// <summary><para><c>PictureChanged</c> method of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>PictureChanged</c> method was the following:  <c>HRESULT PictureChanged (void)</c>;</para></remarks>
    // IDL: HRESULT PictureChanged (void);
    // VB6: Sub PictureChanged
    void PictureChanged ();

    /// <summary><para><c>SaveAsFile</c> method of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>SaveAsFile</c> method was the following:  <c>HRESULT SaveAsFile (void* pstm, VARIANT_BOOL fSaveMemCopy, [out] long* pcbSize)</c>;</para></remarks>
    // IDL: HRESULT SaveAsFile (void* pstm, VARIANT_BOOL fSaveMemCopy, [out] long* pcbSize);
    // VB6: Sub SaveAsFile (ByVal pstm As Long, ByVal fSaveMemCopy As Boolean, pcbSize As Long)
    void SaveAsFile ([ComConversionLoss, MarshalAs(UnmanagedType.I4)] IntPtr pstm, [MarshalAs(UnmanagedType.VariantBool)] bool fSaveMemCopy, [Out] out int pcbSize);

    /// <summary><para><c>Attributes</c> property get of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>Attributes</c> property get was the following:  <c>HRESULT Attributes ([out, retval] long* ReturnValue)</c>;</para></remarks>
    // IDL: HRESULT Attributes ([out, retval] long* ReturnValue);
    // VB6: Function Attributes () As Long
    int Attributes () /* property get method */;

    /// <summary><para><c>SetHdc</c> method of <c>IPicture</c> interface.</para></summary>
    /// <remarks><para>An original IDL definition of <c>SetHdc</c> method was the following:  <c>HRESULT SetHdc (int hdc)</c>;</para></remarks>
    // IDL: HRESULT SetHdc (int hdc);
    // VB6: Sub SetHdc (ByVal hdc As Long)
    void SetHdc (int hdc);
  }

  /// <summary><para><c>IUnknown</c> interface.</para></summary>
  [Guid("00000000-0000-0000-C000-000000000046")]
  [ComImport]
  [TypeLibType((short)16)]
  [InterfaceTypeAttribute(ComInterfaceType.InterfaceIsIUnknown)]
  public interface IUnknown
  {
  }

  /// <summary><para><c>StdFont</c> interface.</para></summary>
  [Guid("BEF6E003-A874-101A-8BBA-00AA00300CAB")]
  [ComImport]
  [CoClass(typeof(StdFontClass))]
  public interface StdFont: Font
  {
  }

  /// <summary><para><c>StdFontClass</c> class.</para></summary>
  /// <remarks>The following sample shows how to use StdFontClass class.  You should simply create new class instance and cast it to StdFont interface.  After this you can call interface methods and access its properties: <code>
  /// StdFont A = (StdFont) new StdFontClass();
  /// A.[method name]();  A.[property name] = [value]; [variable] = A.[property name];
  /// </code></remarks>
  [Guid("0BE35203-8F91-11CE-9DE3-00AA004BB851")]
  [ComImport]
  [TypeLibType((short)2)]
  [ClassInterface(ClassInterfaceType.None)]
  [ComSourceInterfaces("FontEvents")]
  public class StdFontClass // : IFont, Font, StdFont, FontEvents_Event
  {
  }

  /// <summary><para><c>StdPicture</c> interface.</para></summary>
  [Guid("7BF80981-BF32-101A-8BBB-00AA00300CAB")]
  [ComImport]
  [CoClass(typeof(StdPictureClass))]
  public interface StdPicture: Picture
  {
  }

  /// <summary><para><c>StdPictureClass</c> class.</para></summary>
  /// <remarks>The following sample shows how to use StdPictureClass class.  You should simply create new class instance and cast it to StdPicture interface.  After this you can call interface methods and access its properties: <code>
  /// StdPicture A = (StdPicture) new StdPictureClass();
  /// A.[method name]();  A.[property name] = [value]; [variable] = A.[property name];
  /// </code></remarks>
  [Guid("0BE35204-8F91-11CE-9DE3-00AA004BB851")]
  [ComImport]
  [TypeLibType((short)2)]
  [ClassInterface(ClassInterfaceType.None)]
  public class StdPictureClass // : IPicture, Picture, StdPicture
  {
  }

  /// <summary><para>StdFunctions module.  </para><para>Functions for Standard OLE Objects</para></summary>
    // Functions for Standard OLE Objects
  [Guid("91209AC0-60F6-11CF-9C5D-00AA00C1489E")]
  public sealed class StdFunctions // MODULE
  {
    /// <summary><para><c>LoadPicture</c> method of #1StdFunctions#1 module.  </para><para>Loads a picture from a file</para></summary>
    /// <remarks><para>An original IDL definition of <c>LoadPicture</c> member was the following:  <c>HRESULT LoadPicture ([optional] VARIANT filename, [optional, defaultvalue(0)] int widthDesired, [optional, defaultvalue(0)] int heightDesired, [optional, defaultvalue(0)] LoadPictureConstants flags, [out, retval] Picture** ReturnValue)</c>;</para></remarks>
    // Loads a picture from a file
    // IDL: HRESULT LoadPicture ([optional] VARIANT filename, [optional, defaultvalue(0)] int widthDesired, [optional, defaultvalue(0)] int heightDesired, [optional, defaultvalue(0)] LoadPictureConstants flags, [out, retval] Picture** ReturnValue);
    // VB6: Function LoadPicture ([ByVal filename As Any], [ByVal widthDesired As Long = 0], [ByVal heightDesired As Long = 0], [ByVal flags As LoadPictureConstants = 0]) As Picture
      [DllImport("oleaut32.dll", EntryPoint="OleLoadPictureFileEx", ExactSpelling=true, PreserveSig = false, SetLastError=true)]
    public static extern Picture LoadPicture (object filename, int widthDesired, int heightDesired, LoadPictureConstants flags);

    /// <summary><para><c>SavePicture</c> method of #1StdFunctions#1 module.  </para><para>Saves a picture to a file</para></summary>
    /// <remarks><para>An original IDL definition of <c>SavePicture</c> member was the following:  <c>HRESULT SavePicture (Picture* Picture, BSTR filename)</c>;</para></remarks>
    // Saves a picture to a file
    // IDL: HRESULT SavePicture (Picture* Picture, BSTR filename);
    // VB6: Sub SavePicture (ByVal Picture As Picture, ByVal filename As String)
      [DllImport("oleaut32.dll", EntryPoint="OleSavePictureFile", ExactSpelling=true, PreserveSig = false, SetLastError=true)]
    public static extern void SavePicture (Picture Picture, [MarshalAs(UnmanagedType.BStr)] string filename);
  }
}
