/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import mx.automation.IAutomationObject;
	import mx.styles.ISimpleStyleClient;
	import mx.managers.IToolTipManagerClient;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import mx.managers.ISystemManager;
	import flash.display.DisplayObject;
	import flash.events.Event;
	public class UITextField extends FlexTextField implements IAutomationObject, IIMESupport, IFlexModule, IInvalidating, ISimpleStyleClient, IToolTipManagerClient, IUITextField {
		/**
		 * The delegate object which is handling the automation related functionality.
		 */
		public function get automationDelegate():Object;
		public function set automationDelegate(value:Object):void;
		/**
		 * Name that can be used as an identifier for this object.
		 */
		public function get automationName():String;
		public function set automationName(value:String):void;
		/**
		 * This value generally corresponds to the rendered appearance of the
		 *  object and should be usable for correlating the identifier with
		 *  the object as it appears visually within the application.
		 */
		public function get automationValue():Array;
		/**
		 * The y-coordinate of the baseline of the first line of text.
		 */
		public function get baselinePosition():Number;
		/**
		 * The name of this instance's class, such as
		 *  "DataGridItemRenderer".
		 */
		public function get className():String;
		/**
		 * A reference to the document object associated with this UITextField object.
		 *  A document object is an Object at the top of the hierarchy of a Flex application,
		 *  MXML component, or AS component.
		 */
		public function get document():Object;
		public function set document(value:Object):void;
		/**
		 * A Boolean value that indicates whether the component is enabled.
		 *  This property only affects
		 *  the color of the text and not whether the UITextField is editable.
		 *  To control editability, use the
		 *  flash.text.TextField.type property.
		 */
		public function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		/**
		 * Number that specifies the explicit height of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitHeight():Number;
		public function set explicitHeight(value:Number):void;
		/**
		 * Number that specifies the maximum height of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitMaxHeight():Number;
		/**
		 * Number that specifies the maximum width of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitMaxWidth():Number;
		/**
		 * Number that specifies the minimum height of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitMinHeight():Number;
		/**
		 * Number that specifies the minimum width of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitMinWidth():Number;
		/**
		 * Number that specifies the explicit width of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitWidth():Number;
		public function set explicitWidth(value:Number):void;
		/**
		 * A single Sprite object that is shared among components
		 *  and used as an overlay for drawing focus.
		 *  Components share this object if their parent is a focused component,
		 *  not if the component implements the IFocusManagerComponent interface.
		 */
		public function get focusPane():Sprite;
		public function set focusPane(value:Sprite):void;
		/**
		 * If true, the paddingLeft and
		 *  paddingRight styles will not add space
		 *  around the text of the component.
		 */
		public function get ignorePadding():Boolean;
		public function set ignorePadding(value:Boolean):void;
		/**
		 * Specifies the IME (input method editor) mode.
		 *  The IME enables users to enter text in Chinese, Japanese, and Korean.
		 *  Flex sets the specified IME mode when the control gets the focus,
		 *  and sets it back to the previous value when the control loses the focus.
		 */
		public function get imeMode():String;
		public function set imeMode(value:String):void;
		/**
		 * Specifies whether this component is included in the layout of the
		 *  parent container.
		 *  If true, the object is included in its parent container's
		 *  layout.  If false, the object is positioned by its parent
		 *  container as per its layout rules, but it is ignored for the purpose of
		 *  computing the position of the next child.
		 */
		public function get includeInLayout():Boolean;
		public function set includeInLayout(value:Boolean):void;
		/**
		 * The beginning of this UITextField's chain of inheriting styles.
		 *  The getStyle() method accesses
		 *  inheritingStyles[styleName] to search the entire
		 *  prototype-linked chain.
		 *  This object is set up by the initProtoChain() method.
		 *  You typically never need to access this property directly.
		 */
		public function get inheritingStyles():Object;
		public function set inheritingStyles(value:Object):void;
		/**
		 * A flag that determines if an object has been through all three phases
		 *  of layout validation (provided that any were required)
		 */
		public function get initialized():Boolean;
		public function set initialized(value:Boolean):void;
		/**
		 * Set to true by the PopUpManager to indicate
		 *  that component has been popped up.
		 */
		public function get isPopUp():Boolean;
		public function set isPopUp(value:Boolean):void;
		/**
		 * Number that specifies the maximum height of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get maxHeight():Number;
		/**
		 * Number that specifies the maximum width of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get maxWidth():Number;
		/**
		 * The default height of the component, in pixels.
		 *  This value is set by the measure() method.
		 */
		public function get measuredHeight():Number;
		/**
		 * The default minimum height of the component, in pixels.
		 *  This value is set by the measure() method.
		 */
		public function get measuredMinHeight():Number;
		public function set measuredMinHeight(value:Number):void;
		/**
		 * The default minimum width of the component, in pixels.
		 *  This value is set by the measure() method.
		 */
		public function get measuredMinWidth():Number;
		public function set measuredMinWidth(value:Number):void;
		/**
		 * The default width of the component, in pixels.
		 *  This value is set by the measure() method.
		 */
		public function get measuredWidth():Number;
		/**
		 * Number that specifies the minimum height of the component,
		 *  in pixels, in the component's coordinates.
		 *  The default value depends on the component implementation.
		 */
		public function get minHeight():Number;
		/**
		 * Number that specifies the minimum width of the component,
		 *  in pixels, in the component's coordinates.
		 *  The default value depends on the component implementation.
		 */
		public function get minWidth():Number;
		/**
		 * The moduleFactory that is used to create TextFields in the correct SWF context. This is necessary so that
		 *  embedded fonts will work.
		 */
		public function get moduleFactory():IFlexModuleFactory;
		public function set moduleFactory(value:IFlexModuleFactory):void;
		/**
		 * Depth of this object in the containment hierarchy.
		 *  This number is used by the measurement and layout code.
		 *  The value is 0 if this component is not on the DisplayList.
		 */
		public function get nestLevel():int;
		public function set nestLevel(value:int):void;
		/**
		 * The beginning of this UITextField's chain of non-inheriting styles.
		 *  The getStyle() method accesses
		 *  nonInheritingStyles[styleName] method to search the entire
		 *  prototype-linked chain.
		 *  This object is set up by the initProtoChain() method.
		 *  You typically never need to access this property directly.
		 */
		public function get nonInheritingStyles():Object;
		public function set nonInheritingStyles(value:Object):void;
		/**
		 * Unlike textHeight, this returns a non-zero value
		 *  even when the text is empty.
		 *  In this case, it returns what the textHeight would be
		 *  if the text weren't empty.
		 */
		public function get nonZeroTextHeight():Number;
		/**
		 * By default, set to the parent container of this object.
		 *  However, if this object is a child component that is
		 *  popped up by its parent, such as the dropdown list of a ComboBox control,
		 *  the owner is the component that popped up this object.
		 */
		public function get owner():DisplayObjectContainer;
		public function set owner(value:DisplayObjectContainer):void;
		/**
		 * The parent container or component for this component.
		 */
		public function get parent():DisplayObjectContainer;
		/**
		 * Number that specifies the height of a component as a percentage
		 *  of its parent's size. Allowed values are 0-100. The default value is NaN.
		 *  Setting the height or explicitHeight properties
		 *  resets this property to NaN.
		 */
		public function get percentHeight():Number;
		public function set percentHeight(value:Number):void;
		/**
		 * Number that specifies the width of a component as a percentage
		 *  of its parent's size. Allowed values are 0-100. The default value is NaN.
		 *  Setting the width or explicitWidth properties
		 *  resets this property to NaN.
		 */
		public function get percentWidth():Number;
		public function set percentWidth(value:Number):void;
		/**
		 * Set to true after the createChildren()
		 *  method creates any internal component children.
		 */
		public function get processedDescriptors():Boolean;
		public function set processedDescriptors(value:Boolean):void;
		/**
		 * The class style used by this component. This can be a String, CSSStyleDeclaration
		 *  or an IStyleClient.
		 */
		public function get styleName():Object;
		public function set styleName(value:Object):void;
		/**
		 * Returns the SystemManager object used by this component.
		 */
		public function get systemManager():ISystemManager;
		public function set systemManager(value:ISystemManager):void;
		/**
		 * Text to display in the ToolTip.
		 */
		public function get toolTip():String;
		public function set toolTip(value:String):void;
		/**
		 * Array of properties that are currently being tweened on this object.
		 */
		public function get tweeningProperties():Array;
		public function set tweeningProperties(value:Array):void;
		/**
		 * A flag that determines if an object has been through all three phases
		 *  of layout validation (provided that any were required)
		 */
		public function get updateCompletePendingFlag():Boolean;
		public function set updateCompletePendingFlag(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function UITextField();
		/**
		 * A convenience method for determining whether to use the
		 *  explicit or measured height
		 *
		 * @return                  <Number> A Number which is explicitHeight if defined
		 *                            or measuredHeight if not.
		 */
		public function getExplicitOrMeasuredHeight():Number;
		/**
		 * A convenience method for determining whether to use the
		 *  explicit or measured width
		 *
		 * @return                  <Number> A Number which is explicitWidth if defined
		 *                            or measuredWidth if not.
		 */
		public function getExplicitOrMeasuredWidth():Number;
		/**
		 * Gets a style property that has been set anywhere in this
		 *  component's style lookup chain.
		 *
		 * @param styleProp         <String> Name of the style property.
		 * @return                  <*> Style value.
		 */
		public function getStyle(styleProp:String):*;
		/**
		 * Returns the TextFormat object that represents
		 *  character formatting information for this UITextField object.
		 *
		 * @return                  <TextFormat> A TextFormat object.
		 */
		public function getTextStyles():TextFormat;
		/**
		 * Returns a UITextFormat object that contains formatting information for this component.
		 *  This method is similar to the getTextFormat() method of the
		 *  flash.text.TextField class, but it returns a UITextFormat object instead
		 *  of a TextFormat object.
		 *
		 * @return                  <UITextFormat> An object that contains formatting information for this component.
		 */
		public function getUITextFormat():UITextFormat;
		/**
		 * Initializes this component.
		 */
		public function initialize():void;
		/**
		 * Marks a component so that its updateDisplayList()
		 *  method gets called during a later screen update.
		 */
		public function invalidateDisplayList():void;
		/**
		 * Marks a component so that its commitProperties()
		 *  method gets called during a later screen update.
		 */
		public function invalidateProperties():void;
		/**
		 * Marks a component so that its measure()
		 *  method gets called during a later screen update.
		 */
		public function invalidateSize():void;
		/**
		 * Moves the component to a specified position within its parent.
		 *  Calling this method is exactly the same as
		 *  setting the component's x and y properties.
		 *
		 * @param x                 <Number> Left position of the component within its parent.
		 * @param y                 <Number> Top position of the component within its parent.
		 */
		public function move(x:Number, y:Number):void;
		/**
		 * Returns true if the child is parented or owned by this object.
		 *
		 * @param child             <DisplayObject> The child DisplayObject.
		 * @return                  <Boolean> true if the child is parented or owned by this UITextField object.
		 */
		public function owns(child:DisplayObject):Boolean;
		/**
		 * This function is called when a UITextField object is assigned
		 *  a parent.
		 *  You typically never need to call this method.
		 *
		 * @param p                 <DisplayObjectContainer> The parent of this UITextField object.
		 */
		public function parentChanged(p:DisplayObjectContainer):void;
		/**
		 * Replays the specified event.  A component author should probably call
		 *  super.replayAutomatableEvent in case default replay behavior has been defined
		 *  in a superclass.
		 *
		 * @param event             <Event> The event to replay.
		 * @return                  <Boolean> true if a replay was successful.
		 */
		public function replayAutomatableEvent(event:Event):Boolean;
		/**
		 * Sizes the object.
		 *  Unlike directly setting the width and height
		 *  properties, calling the setActualSize() method
		 *  does not set the explictWidth and
		 *  explicitHeight properties, so a future layout
		 *  calculation may result in the object returning to its previous size.
		 *  This method is used primarily by component developers implementing
		 *  the updateDisplayList() method, by Effects,
		 *  and by the LayoutManager.
		 *
		 * @param w                 <Number> Width of the object.
		 * @param h                 <Number> Height of the object.
		 */
		public function setActualSize(w:Number, h:Number):void;
		/**
		 * Sets the font color of the text.
		 *
		 * @param color             <uint> The new font color.
		 */
		public function setColor(color:uint):void;
		/**
		 * Sets the focus to this component.
		 *  The component may in turn pass focus to a subcomponent.
		 */
		public function setFocus():void;
		/**
		 * Does nothing.
		 *  A UITextField cannot have inline styles.
		 *
		 * @param styleProp         <String> Name of the style property.
		 * @param value             <*> New value for the style.
		 */
		public function setStyle(styleProp:String, value:*):void;
		/**
		 * Sets the visible property of this UITextField object.
		 *
		 * @param visible           <Boolean> true to make this UITextField visible,
		 *                            and false to make it invisible.
		 * @param noEvent           <Boolean (default = false)> true to suppress generating an event when you change visibility.
		 */
		public function setVisible(visible:Boolean, noEvent:Boolean = false):void;
		/**
		 * Detects changes to style properties. When any style property is set,
		 *  Flex calls the styleChanged() method,
		 *  passing to it the name of the style being set.
		 *
		 * @param styleProp         <String> The name of the style property, or null if all styles for this
		 *                            component have changed.
		 */
		public function styleChanged(styleProp:String):void;
		/**
		 * Truncate text to make it fit horizontally in the area defined for the control,
		 *  and append an ellipsis, three periods (...), to the text.
		 *
		 * @param truncationIndicator<String (default = null)> The text to be appended after truncation.
		 *                            If you pass null, a localizable string
		 *                            such as "..." will be used.
		 * @return                  <Boolean> true if the text needed truncation.
		 */
		public function truncateToFit(truncationIndicator:String = null):Boolean;
		/**
		 * Validate and update the properties and layout of this object
		 *  and redraw it, if necessary.
		 *  Processing properties that require substantial computation are normally
		 *  not processed until the script finishes executing.
		 *  For example setting the width property is delayed, because it may
		 *  require recalculating the widths of the objects children or its parent.
		 *  Delaying the processing prevents it from being repeated
		 *  multiple times if the script sets the width property more than once.
		 *  This method lets you manually override this behavior.
		 */
		public function validateNow():void;
	}
}
