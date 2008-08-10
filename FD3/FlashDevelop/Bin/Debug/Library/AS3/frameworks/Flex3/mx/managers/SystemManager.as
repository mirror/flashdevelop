/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	import flash.display.MovieClip;
	import mx.core.IChildList;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IUIComponent;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.display.DisplayObject;
	public class SystemManager extends MovieClip implements IChildList, IFlexDisplayObject, IFlexModuleFactory, ISystemManager {
		/**
		 * The application parented by this SystemManager.
		 *  SystemManagers create an instance of an Application
		 *  even if they are loaded into another Application.
		 *  Thus, this may not match mx.core.Application.application
		 *  if the SWF has been loaded into another application.
		 */
		public function get application():IUIComponent;
		/**
		 * An list of the custom cursors
		 *  being parented by this ISystemManager.
		 */
		public function get cursorChildren():IChildList;
		/**
		 * A reference to the document object.
		 *  A document object is an Object at the top of the hierarchy of a
		 *  Flex application, MXML component, or AS component.
		 */
		public function get document():Object;
		public function set document(value:Object):void;
		/**
		 * A table of embedded fonts in this application.  The
		 *  object is a table indexed by the font name.
		 */
		public function get embeddedFontList():Object;
		/**
		 * The explicit width of this object.  For the SystemManager
		 *  this should always be NaN unless the application was loaded
		 *  into another application.  If the application was not loaded
		 *  into another application, setting this value has no effect.
		 */
		public function get explicitHeight():Number;
		public function set explicitHeight(value:Number):void;
		/**
		 * The explicit width of this object.  For the SystemManager
		 *  this should always be NaN unless the application was loaded
		 *  into another application.  If the application was not loaded
		 *  into another application, setting this value has no effect.
		 */
		public function get explicitWidth():Number;
		public function set explicitWidth(value:Number):void;
		/**
		 * The focus pane associated with this object.
		 *  An object has a focus pane when one of its children has focus.
		 */
		public function get focusPane():Sprite;
		public function set focusPane(value:Sprite):void;
		/**
		 * The height of this object.  For the SystemManager
		 *  this should always be the width of the stage unless the application was loaded
		 *  into another application.  If the application was not loaded
		 *  into another application, setting this value has no effect.
		 */
		public function get height():Number;
		public function set height(value:Number):void;
		/**
		 * The measuredHeight is the explicit or measuredHeight of
		 *  the main mx.core.Application window
		 *  or the starting height of the SWF if the main window
		 *  has not yet been created or does not exist.
		 */
		public function get measuredHeight():Number;
		/**
		 * The measuredWidth is the explicit or measuredWidth of
		 *  the main mx.core.Application window,
		 *  or the starting width of the SWF if the main window
		 *  has not yet been created or does not exist.
		 */
		public function get measuredWidth():Number;
		/**
		 * The number of non-floating windows.  This is the main application window
		 *  plus any other windows added to the SystemManager that are not popups,
		 *  tooltips or cursors.
		 */
		public function get numChildren():int;
		/**
		 * The number of modal windows.  Modal windows don't allow
		 *  clicking in another windows which would normally
		 *  activate the FocusManager in that window.  The PopUpManager
		 *  modifies this count as it creates and destroys modal windows.
		 */
		public function get numModalWindows():int;
		public function set numModalWindows(value:int):void;
		/**
		 * An list of the topMost (popup)
		 *  windows being parented by this ISystemManager.
		 */
		public function get popUpChildren():IChildList;
		/**
		 * The background alpha used by the child of the preloader.
		 */
		public function get preloaderBackgroundAlpha():Number;
		/**
		 * The background color used by the child of the preloader.
		 */
		public function get preloaderBackgroundColor():uint;
		/**
		 * The background color used by the child of the preloader.
		 */
		public function get preloaderBackgroundImage():Object;
		/**
		 * The background size used by the child of the preloader.
		 */
		public function get preloaderBackgroundSize():String;
		/**
		 * A list of all children
		 *  being parented by this ISystemManager.
		 */
		public function get rawChildren():IChildList;
		/**
		 * The size and position of the application window.
		 *  The Rectangle object contains x, y,
		 *  width, and height properties.
		 */
		public function get screen():Rectangle;
		/**
		 * A list of the tooltips
		 *  being parented by this ISystemManager.
		 */
		public function get toolTipChildren():IChildList;
		/**
		 * Returns the SystemManager responsible for the application window.  This will be
		 *  the same SystemManager unless this application has been loaded into another
		 *  application.
		 */
		public function get topLevelSystemManager():ISystemManager;
		/**
		 * The width of this object.  For the SystemManager
		 *  this should always be the width of the stage unless the application was loaded
		 *  into another application.  If the application was not loaded
		 *  into another application, setting this value will have no effect.
		 */
		public function get width():Number;
		public function set width(value:Number):void;
		/**
		 * Constructor.
		 */
		public function SystemManager();
		/**
		 * Activates the FocusManager in an IFocusManagerContainer.
		 *
		 * @param f                 <IFocusManagerContainer> IFocusManagerContainer the top-level window
		 *                            whose FocusManager should be activated.
		 */
		public function activate(f:IFocusManagerContainer):void;
		/**
		 * Registers a top-level window containing a FocusManager.
		 *  Called by the FocusManager, generally not called by application code.
		 *
		 * @param f                 <IFocusManagerContainer> The top-level window in the application.
		 */
		public function addFocusManager(f:IFocusManagerContainer):void;
		/**
		 * This method is overridden in the autogenerated subclass.
		 */
		public function create(... params):Object;
		/**
		 * Deactivates the FocusManager in an IFocusManagerContainer, and activate
		 *  the FocusManager of the next highest window that is an IFocusManagerContainer.
		 *
		 * @param f                 <IFocusManagerContainer> IFocusManagerContainer the top-level window
		 *                            whose FocusManager should be deactivated.
		 */
		public function deactivate(f:IFocusManagerContainer):void;
		/**
		 * Converts the given String to a Class or package-level Function.
		 *  Calls the appropriate ApplicationDomain.getDefinition()
		 *  method based on
		 *  whether you are loaded into another application or not.
		 *
		 * @param name              <String> Name of class, for example "mx.video.VideoManager".
		 * @return                  <Object> The Class represented by the name, or null.
		 */
		public function getDefinitionByName(name:String):Object;
		/**
		 * A convenience method for determining whether to use the
		 *  explicit or measured height.
		 *
		 * @return                  <Number> A Number which is the explicitHeight if defined,
		 *                            or the measuredHeight property if not.
		 */
		public function getExplicitOrMeasuredHeight():Number;
		/**
		 * A convenience method for determining whether to use the
		 *  explicit or measured width.
		 *
		 * @return                  <Number> A Number which is the explicitWidth if defined,
		 *                            or the measuredWidth property if not.
		 */
		public function getExplicitOrMeasuredWidth():Number;
		/**
		 * Returns the root DisplayObject of the SWF that contains the code
		 *  for the given object.
		 *
		 * @param object            <Object> Any Object.
		 * @return                  <DisplayObject> The root DisplayObject
		 */
		public static function getSWFRoot(object:Object):DisplayObject;
		/**
		 * Returns true if the required font face is embedded
		 *  in this application, or has been registered globally by using the
		 *  Font.registerFont() method.
		 *
		 * @param tf                <TextFormat> The TextFormat class representing character formatting information.
		 * @return                  <Boolean> true if the required font face is embedded
		 *                            in this application, or has been registered globally by using the
		 *                            Font.registerFont() method.
		 */
		public function isFontFaceEmbedded(tf:TextFormat):Boolean;
		/**
		 * Returns true if this ISystemManager is responsible
		 *  for an application window, and false if this
		 *  application has been loaded into another application.
		 *
		 * @return                  <Boolean> true if this ISystemManager is responsible
		 *                            for an application window.
		 */
		public function isTopLevel():Boolean;
		/**
		 * Returns true if the given DisplayObject is the
		 *  top-level window.
		 *
		 * @param object            <DisplayObject> 
		 * @return                  <Boolean> true if the given DisplayObject is the
		 *                            top-level window.
		 */
		public function isTopLevelWindow(object:DisplayObject):Boolean;
		/**
		 * Calling the move() method
		 *  has no effect as it is directly mapped
		 *  to the application window or the loader.
		 *
		 * @param x                 <Number> The new x coordinate.
		 * @param y                 <Number> The new y coordinate.
		 */
		public function move(x:Number, y:Number):void;
		/**
		 * Unregisters a top-level window containing a FocusManager.
		 *  Called by the FocusManager, generally not called by application code.
		 *
		 * @param f                 <IFocusManagerContainer> The top-level window in the application.
		 */
		public function removeFocusManager(f:IFocusManagerContainer):void;
		/**
		 * Calling the setActualSize() method
		 *  has no effect if it is directly mapped
		 *  to the application window and if it is the top-level window.
		 *  Otherwise attempts to resize itself, clipping children if needed.
		 *
		 * @param newWidth          <Number> The new width.
		 * @param newHeight         <Number> The new height.
		 */
		public function setActualSize(newWidth:Number, newHeight:Number):void;
	}
}
