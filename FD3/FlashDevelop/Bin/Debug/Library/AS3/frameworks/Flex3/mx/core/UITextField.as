package mx.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import flash.utils.getQualifiedClassName;
	import mx.automation.IAutomationObject;
	import mx.core.FlexVersion;
	import mx.managers.ISystemManager;
	import mx.managers.IToolTipManagerClient;
	import mx.managers.SystemManager;
	import mx.managers.ToolTipManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	import mx.styles.StyleProtoChain;
	import mx.utils.StringUtil;

include "../styles/metadata/LeadingStyle.as"
include "../styles/metadata/PaddingStyles.as"
include "../styles/metadata/TextStyles.as"
include "../core/Version.as"
	/**
	 *  The UITextField class defines the component used by many Flex
 *  components to display text.
 *  For example, the mx.controls.Button control uses a 
 *  UITextField component to define the label area of the Button control. 
 * 
 *  <p>The UITextField class extends the flash.text.TextField class to
 *  support additional functionality required by Flex, such as CSS styles,
 *  invalidation/measurement/layout, enabling/disabling, tooltips, and IME
 *  (Input Method Editor) support for entering Chinese, Japanese, and
 *  Korean text.</p>
 *
 *  @see flash.text.TextField
 *  @see mx.core.UITextFormat
	 */
	public class UITextField extends FlexTextField implements IAutomationObject
	{
		/**
		 *  @private
     *  The padding to be added to textWidth to get the width
     *  of a TextField that can display the text without clipping.
		 */
		static const TEXT_WIDTH_PADDING : int = 5;
		/**
		 *  @private
     *  The padding to be added to textHeight to get the height
     *  of a TextField that can display the text without clipping.
		 */
		static const TEXT_HEIGHT_PADDING : int = 4;
		/**
		 *  @private
     *  Most resources are fetched on the fly from the ResourceManager,
     *  so they automatically get the right resource when the locale changes.
     *  But since truncateToFit() can be called frequently,
     *  this class caches this resource value in this variable
     *  and updates it when the locale changes.
		 */
		private static var truncationIndicatorResource : String;
		/**
		 *  @private
		 */
		static var debuggingBorders : Boolean;
		/**
		 *  @private
     *  Storage for the _embeddedFontRegistry property.
     *  Note: This gets initialized on first access,
     *  not when this class is initialized, in order to ensure
     *  that the Singleton registry has already been initialized.
		 */
		private static var _embeddedFontRegistry : IEmbeddedFontRegistry;
		/**
		 *  @private
     *  Cached value of the TextFormat read from the Styles.
		 */
		private var cachedTextFormat : TextFormat;
		/**
		 * @private
     * 
     * Cache last value of embedded font.
		 */
		private var cachedEmbeddedFont : EmbeddedFont;
		/**
		 *  @private
		 */
		private var invalidateDisplayListFlag : Boolean;
		/**
		 *  @private
		 */
		var styleChangedFlag : Boolean;
		/**
		 *  @private
     *  This var is either the last value of 'htmlText' that was set
     *  or null (if 'text' was set instead of 'htmlText').
     *
     *  This var is different from getting the 'htmlText',
     *  because when you set 'htmlText' into a TextField and then get it,
     *  you don't get what you set; what you get includes additional
     *  HTML markup generated from the defaultTextFormat
     *  (which for a Flex component is based on the CSS styles).
     *
     *  When you set 'htmlText', a TextField parses through it
     *  and creates TextFormat runs based on the HTML markup.
     *  It applies these on top of the defaultTextFormat.
     *  A TextField saves the non-markup characters as the 'text',
     *  but it doesn't save the original 'htmlText',
     *  so we have to do this ourselves.
     *
     *  If the CSS styles change, validateNow() will get called
     *  and a new TextFormat based on the new CSS styles
     *  will get applied to the entire TextField, wiping
     *  out any TextFormats that came from the HTML markup.
     *  So we use this var to re-apply the original markup
     *  after a CSS change.
		 */
		private var explicitHTMLText : String;
		/**
		 *  @private
     *  Color set explicitly by setColor(); overrides style lookup.
		 */
		var explicitColor : uint;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var untruncatedText : String;
		/**
		 *  @private
     *  Reference to this component's virtual parent container.
     *  "Virtual" means that this parent may not be the same
     *  as the one that the Player returns as the 'parent'
     *  property of a DisplayObject.
     *  For example, if a Container has created a contentPane
     *  to improve scrolling performance,
     *  then its "children" are really its grandchildren
     *  and their "parent" is actually their grandparent,
     *  because we don't want developers to be concerned with
     *  whether a contentPane exists or not.
		 */
		var _parent : DisplayObjectContainer;
		/**
		 *  @private
		 */
		private var _automationDelegate : IAutomationObject;
		/**
		 *  @private
     *  Storage for the automationName property.
		 */
		private var _automationName : String;
		/**
		 *  @private
     *  Storage for the enabled property.
		 */
		private var _document : Object;
		/**
		 *  @private
     *  Storage for the enabled property.
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
     *  Storage for the explicitHeight property.
		 */
		private var _explicitHeight : Number;
		/**
		 *  @private
     *  Storage for the explicitWidth property.
		 */
		private var _explicitWidth : Number;
		/**
		 *  @private
     *  Storage for the ignorePadding property.
		 */
		private var _ignorePadding : Boolean;
		/**
		 *  @private
     *  Storage for the imeMode property.
		 */
		private var _imeMode : String;
		/**
		 *  @private
     *  Storage for the includeInLayout property.
		 */
		private var _includeInLayout : Boolean;
		/**
		 *  @private
     *  Storage for the inheritingStyles property.
		 */
		private var _inheritingStyles : Object;
		/**
		 *  @private
     *  Storage for the initialize property.
		 */
		private var _initialized : Boolean;
		/**
		 *  @private
     *  Storage for the moduleFactory property.
		 */
		private var _moduleFactory : IFlexModuleFactory;
		/**
		 *  @private
     *  Storage for the nestLevel property.
		 */
		private var _nestLevel : int;
		/**
		 *  @private
     *  Storage for the nonInheritingStyles property.
		 */
		private var _nonInheritingStyles : Object;
		/**
		 *  @private
		 */
		private var _processedDescriptors : Boolean;
		/**
		 *  @private
     *  Storage for the styleName property.
		 */
		private var _styleName : Object;
		/**
		 *  @private
     *  Storage for the toolTip property.
		 */
		var _toolTip : String;
		/**
		 *  @private
     *  Storage for the updateCompletePendingFlag property.
		 */
		private var _updateCompletePendingFlag : Boolean;
		/**
		 *  @private
		 */
		private var _owner : DisplayObjectContainer;

		/**
		 *  @private
     *  A reference to the embedded font registry.
     *  Single registry in the system.
     *  Used to look up the moduleFactory of a font.
		 */
		private static function get embeddedFontRegistry () : IEmbeddedFontRegistry;

		/**
		 *  @private
		 */
		public function set htmlText (value:String) : void;

		/**
		 *  The parent container or component for this component.
		 */
		public function get parent () : DisplayObjectContainer;

		/**
		 *  @private
		 */
		public function set text (value:String) : void;

		/**
		 *  The delegate object which is handling the automation related functionality.
     *
		 */
		public function get automationDelegate () : Object;
		/**
		 *  @private
		 */
		public function set automationDelegate (value:Object) : void;

		/**
		 *  @inheritDoc
		 */
		public function get automationName () : String;
		/**
		 * @private
		 */
		public function set automationName (value:String) : void;

		/**
		 *  @inheritDoc
		 */
		public function get automationValue () : Array;

		/**
		 *  The y-coordinate of the baseline of the first line of text.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  The name of this instance's class, such as
     *  <code>"DataGridItemRenderer"</code>.
     *
     *  <p>This string does not include the package name.
     *  If you need the package name as well, call the
     *  <code>getQualifiedClassName()</code> method in the flash.utils package.
     *  It will return a string such as
     *  <code>"mx.controls.dataGridClasses::DataGridItemRenderer"</code>.</p>
		 */
		public function get className () : String;

		/**
		 *  A reference to the document object associated with this UITextField object. 
     *  A document object is an Object at the top of the hierarchy of a Flex application, 
     *  MXML component, or AS component.
		 */
		public function get document () : Object;
		/**
		 *  @private
		 */
		public function set document (value:Object) : void;

		/**
		 *  A Boolean value that indicates whether the component is enabled. 
     *  This property only affects
     *  the color of the text and not whether the UITextField is editable.
     *  To control editability, use the 
     *  <code>flash.text.TextField.type</code> property.
     *  
     *  @default true
     *  @see flash.text.TextField
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  @copy mx.core.UIComponent#explicitHeight
		 */
		public function get explicitHeight () : Number;
		/**
		 *  @private
		 */
		public function set explicitHeight (value:Number) : void;

		/**
		 *  Number that specifies the maximum height of the component, 
     *  in pixels, in the component's coordinates, if the maxHeight property
     *  is set. Because maxHeight is read-only, this method returns NaN. 
     *  You must override this method and add a setter to use this
     *  property.
     *  
     *  @see mx.core.UIComponent#explicitMaxHeight
     *  
     *  @default NaN
		 */
		public function get explicitMaxHeight () : Number;

		/**
		 *  Number that specifies the maximum width of the component, 
     *  in pixels, in the component's coordinates, if the maxWidth property
     *  is set. Because maxWidth is read-only, this method returns NaN. 
     *  You must override this method and add a setter to use this
     *  property.
     *  
     *  @see mx.core.UIComponent#explicitMaxWidth
     *  
     *  @default NaN
		 */
		public function get explicitMaxWidth () : Number;

		/**
		 *  @copy mx.core.UIComponent#explicitMinHeight
		 */
		public function get explicitMinHeight () : Number;

		/**
		 *  @copy mx.core.UIComponent#explicitMinWidth
		 */
		public function get explicitMinWidth () : Number;

		/**
		 *  @copy mx.core.UIComponent#explicitWidth
		 */
		public function get explicitWidth () : Number;
		/**
		 *  @private
		 */
		public function set explicitWidth (value:Number) : void;

		/**
		 *  @inheritDoc
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;

		/**
		 *  If <code>true</code>, the <code>paddingLeft</code> and
     *  <code>paddingRight</code> styles will not add space
     *  around the text of the component.
     *  
     *  @default true
		 */
		public function get ignorePadding () : Boolean;
		/**
		 *  @private
		 */
		public function set ignorePadding (value:Boolean) : void;

		/**
		 *  Specifies the IME (input method editor) mode.
     *  The IME enables users to enter text in Chinese, Japanese, and Korean.
     *  Flex sets the specified IME mode when the control gets the focus,
     *  and sets it back to the previous value when the control loses the focus.
     *
     * <p>The flash.system.IMEConversionMode class defines constants for the
     *  valid values for this property.
     *  You can also specify <code>null</code> to specify no IME.</p>
     *
     *  @see flash.system.IMEConversionMode
     *
     *  @default null
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;

		/**
		 *  @copy mx.core.UIComponent#includeInLayout
		 */
		public function get includeInLayout () : Boolean;
		/**
		 *  @private
		 */
		public function set includeInLayout (value:Boolean) : void;

		/**
		 *  The beginning of this UITextField's chain of inheriting styles.
     *  The <code>getStyle()</code> method accesses
     *  <code>inheritingStyles[styleName]</code> to search the entire
     *  prototype-linked chain.
     *  This object is set up by the <code>initProtoChain()</code> method.
     *  You typically never need to access this property directly.
		 */
		public function get inheritingStyles () : Object;
		/**
		 *  @private
		 */
		public function set inheritingStyles (value:Object) : void;

		/**
		 *  A flag that determines if an object has been through all three phases
     *  of layout validation (provided that any were required)
		 */
		public function get initialized () : Boolean;
		/**
		 *  @private
		 */
		public function set initialized (value:Boolean) : void;

		/**
		 *  @private
		 */
		private function get isHTML () : Boolean;

		/**
		 *  @copy mx.core.UIComponent#isPopUp
		 */
		public function get isPopUp () : Boolean;
		/**
		 *  @private
		 */
		public function set isPopUp (value:Boolean) : void;

		/**
		 *  @copy mx.core.UIComponent#maxHeight
		 */
		public function get maxHeight () : Number;

		/**
		 *  @copy mx.core.UIComponent#maxWidth
		 */
		public function get maxWidth () : Number;

		/**
		 *  @copy mx.core.UIComponent#measuredHeight
		 */
		public function get measuredHeight () : Number;

		/**
		 *  @copy mx.core.UIComponent#measuredMinHeight
		 */
		public function get measuredMinHeight () : Number;
		/**
		 *  @private
		 */
		public function set measuredMinHeight (value:Number) : void;

		/**
		 *  @copy mx.core.UIComponent#measuredMinWidth
		 */
		public function get measuredMinWidth () : Number;
		/**
		 *  @private
		 */
		public function set measuredMinWidth (value:Number) : void;

		/**
		 *  @copy mx.core.UIComponent#measuredWidth
		 */
		public function get measuredWidth () : Number;

		/**
		 *  @copy mx.core.UIComponent#minHeight
		 */
		public function get minHeight () : Number;

		/**
		 *  @copy mx.core.UIComponent#minWidth
		 */
		public function get minWidth () : Number;

		/**
		 *  The moduleFactory that is used to create TextFields in the correct SWF context. This is necessary so that
     *  embedded fonts will work.
		 */
		public function get moduleFactory () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set moduleFactory (factory:IFlexModuleFactory) : void;

		/**
		 *  @copy mx.core.UIComponent#nestLevel
		 */
		public function get nestLevel () : int;
		/**
		 *  @private
		 */
		public function set nestLevel (value:int) : void;

		/**
		 *  The beginning of this UITextField's chain of non-inheriting styles.
     *  The <code>getStyle()</code> method accesses
     *  <code>nonInheritingStyles[styleName]</code> method to search the entire
     *  prototype-linked chain.
     *  This object is set up by the <code>initProtoChain()</code> method.
     *  You typically never need to access this property directly.
		 */
		public function get nonInheritingStyles () : Object;
		/**
		 *  @private
		 */
		public function set nonInheritingStyles (value:Object) : void;

		/**
		 *  @copy mx.core.UIComponent#percentHeight
		 */
		public function get percentHeight () : Number;
		/**
		 *  @private
		 */
		public function set percentHeight (value:Number) : void;

		/**
		 *  @copy mx.core.UIComponent#percentWidth
		 */
		public function get percentWidth () : Number;
		/**
		 *  @private
		 */
		public function set percentWidth (value:Number) : void;

		/**
		 *  Set to <code>true</code> after the <code>createChildren()</code>
     *  method creates any internal component children.
		 */
		public function get processedDescriptors () : Boolean;
		/**
		 *  @private
		 */
		public function set processedDescriptors (value:Boolean) : void;

		/**
		 *  @copy mx.core.UIComponent#styleName
		 */
		public function get styleName () : Object;
		/**
		 *  @private
		 */
		public function set styleName (value:Object) : void;

		/**
		 *  @copy mx.core.UIComponent#systemManager
		 */
		public function get systemManager () : ISystemManager;
		/**
		 *  @private
		 */
		public function set systemManager (value:ISystemManager) : void;

		/**
		 *  Unlike textHeight, this returns a non-zero value
     *  even when the text is empty.
     *  In this case, it returns what the textHeight would be
     *  if the text weren't empty.
		 */
		public function get nonZeroTextHeight () : Number;

		/**
		 *  @copy mx.core.UIComponent#toolTip
		 */
		public function get toolTip () : String;
		/**
		 *  @private
		 */
		public function set toolTip (value:String) : void;

		/**
		 *  @copy mx.core.UIComponent#tweeningProperties
		 */
		public function get tweeningProperties () : Array;
		/**
		 *  @private
		 */
		public function set tweeningProperties (value:Array) : void;

		/**
		 *  A flag that determines if an object has been through all three phases
     *  of layout validation (provided that any were required)
		 */
		public function get updateCompletePendingFlag () : Boolean;
		/**
		 *  @private
		 */
		public function set updateCompletePendingFlag (value:Boolean) : void;

		/**
		 *  By default, set to the parent container of this object. 
     *  However, if this object is a child component that is 
     *  popped up by its parent, such as the dropdown list of a ComboBox control, 
     *  the owner is the component that popped up this object. 
     *
     *  <p>This property is not managed by Flex, but by each component. 
     *  Therefore, if you use the <code>PopUpManger.createPopUp()</code> or 
     *  <code>PopUpManger.addPopUp()</code> method to pop up a child component, 
     *  you should set the <code>owner</code> property of the child component 
     *  to the component that popped it up.</p>
     * 
     *  <p>The default value is the value of the <code>parent</code> property.</p>
		 */
		public function get owner () : DisplayObjectContainer;
		public function set owner (value:DisplayObjectContainer) : void;

		/**
		 *  @private
		 */
		public function get numAutomationChildren () : int;

		/**
		 *  @private
		 */
		public function get showInAutomationHierarchy () : Boolean;
		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function get automationTabularData () : Object;

		/**
		 *  Constructor.
		 */
		public function UITextField ();

		/**
		 *  @private
		 */
		public function setTextFormat (format:TextFormat, beginIndex:int = -1, endIndex:int = -1) : void;

		/**
		 *  @private
		 */
		public function insertXMLText (beginIndex:int, endIndex:int, richText:String, pasting:Boolean = false) : void;

		/**
		 *  @private
		 */
		public function replaceText (beginIndex:int, endIndex:int, newText:String) : void;

		/**
		 *  Initializes this component.
     *
     *  <p>This method is required by the IUIComponent interface,
     *  but it actually does nothing for a UITextField.</p>
		 */
		public function initialize () : void;

		/**
		 *  @copy mx.core.UIComponent#getExplicitOrMeasuredWidth()
		 */
		public function getExplicitOrMeasuredWidth () : Number;

		/**
		 *  @copy mx.core.UIComponent#getExplicitOrMeasuredHeight()
		 */
		public function getExplicitOrMeasuredHeight () : Number;

		/**
		 *  Sets the <code>visible</code> property of this UITextField object.
     * 
     *  @param visible <code>true</code> to make this UITextField visible, 
     *  and <code>false</code> to make it invisible.
     *
     *  @param noEvent <code>true</code> to suppress generating an event when you change visibility.
		 */
		public function setVisible (visible:Boolean, noEvent:Boolean = false) : void;

		/**
		 *  @copy mx.core.UIComponent#setFocus()
		 */
		public function setFocus () : void;

		/**
		 *  Returns a UITextFormat object that contains formatting information for this component. 
     *  This method is similar to the <code>getTextFormat()</code> method of the 
     *  flash.text.TextField class, but it returns a UITextFormat object instead 
     *  of a TextFormat object.
     *
     *  <p>The UITextFormat class extends the TextFormat class to add the text measurement methods
     *  <code>measureText()</code> and <code>measureHTMLText()</code>.</p>
     *
     *  @return An object that contains formatting information for this component.
     *
     *  @see mx.core.UITextFormat
     *  @see flash.text.TextField
		 */
		public function getUITextFormat () : UITextFormat;

		/**
		 *  @copy mx.core.UIComponent#move()
		 */
		public function move (x:Number, y:Number) : void;

		/**
		 *  @copy mx.core.UIComponent#setActualSize()
		 */
		public function setActualSize (w:Number, h:Number) : void;

		/**
		 *  @copy mx.core.UIComponent#getStyle()
		 */
		public function getStyle (styleProp:String) : *;

		/**
		 *  Does nothing.
     *  A UITextField cannot have inline styles.
     *
     *  @param styleProp Name of the style property.
     *
     *  @param newValue New value for the style.
		 */
		public function setStyle (styleProp:String, value:*) : void;

		/**
		 *  This function is called when a UITextField object is assigned
     *  a parent.
     *  You typically never need to call this method.
     *
     *  @param p The parent of this UITextField object.
		 */
		public function parentChanged (p:DisplayObjectContainer) : void;

		/**
		 *  @copy mx.core.UIComponent#styleChanged()
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @copy mx.core.UIComponent#validateNow()
		 */
		public function validateNow () : void;

		/**
		 *  Returns the TextFormat object that represents 
     *  character formatting information for this UITextField object.
     *
     *  @return A TextFormat object. 
     *
     *  @see flash.text.TextFormat
		 */
		public function getTextStyles () : TextFormat;

		/**
		 *  Sets the font color of the text.
     *
     *  @param color The new font color.
		 */
		public function setColor (color:uint) : void;

		/**
		 *  @copy mx.core.UIComponent#invalidateSize()
		 */
		public function invalidateSize () : void;

		/**
		 *  @copy mx.core.UIComponent#invalidateDisplayList()
		 */
		public function invalidateDisplayList () : void;

		/**
		 *  @copy mx.core.UIComponent#invalidateProperties()
		 */
		public function invalidateProperties () : void;

		/**
		 *  Truncate text to make it fit horizontally in the area defined for the control, 
     *  and append an ellipsis, three periods (...), to the text.
     *
     *  @param truncationIndicator The text to be appended after truncation.
     *  If you pass <code>null</code>, a localizable string
     *  such as <code>"..."</code> will be used.
     *
     *  @return <code>true</code> if the text needed truncation.
		 */
		public function truncateToFit (truncationIndicator:String = null) : Boolean;

		/**
		 *  @private
		 */
		private function changeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function textFieldStyleChangeHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function resourceManager_changeHandler (event:Event) : void;

		/**
		 *  Returns <code>true</code> if the child is parented or owned by this object.
     *
     *  @param child The child DisplayObject.
     *
     *  @return <code>true</code> if the child is parented or owned by this UITextField object.
     * 
     *  @see #owner
		 */
		public function owns (child:DisplayObject) : Boolean;

		private function creatingSystemManager () : ISystemManager;

		/**
		 * @private
     * 
     * Get the embedded font for a set of font attributes.
		 */
		private function getEmbeddedFont (fontName:String, bold:Boolean, italic:Boolean) : EmbeddedFont;

		/**
		 *  @inheritDoc
		 */
		public function replayAutomatableEvent (event:Event) : Boolean;

		/**
		 *  @private
		 */
		public function createAutomationIDPart (child:IAutomationObject) : Object;

		/**
		 *  @private
		 */
		public function resolveAutomationIDPart (criteria:Object) : Array;

		/**
		 *  @private
		 */
		public function getAutomationChildAt (index:int) : IAutomationObject;
	}
}
