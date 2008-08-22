/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	import mx.core.IFlexModuleFactory;
	import flash.events.IEventDispatcher;
	import mx.core.IChildList;
	import flash.display.Sprite;
	import flash.display.LoaderInfo;
	import flash.geom.Rectangle;
	import flash.display.Stage;
	import flash.text.TextFormat;
	public interface ISystemManager extends IEventDispatcher, IChildList, IFlexModuleFactory {
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
		 * A single Sprite shared among components used as an overlay for drawing focus.
		 *  You share it if you parent a focused component, not if you are IFocusManagerComponent.
		 */
		public function get focusPane():Sprite;
		public function set focusPane(value:Sprite):void;
		/**
		 * The LoaderInfo object that represents information about the application.
		 */
		public function get loaderInfo():LoaderInfo;
		/**
		 * The number of modal windows.
		 */
		public function get numModalWindows():int;
		public function set numModalWindows(value:int):void;
		/**
		 * An list of the topMost (popup)
		 *  windows being parented by this ISystemManager.
		 */
		public function get popUpChildren():IChildList;
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
		 * The flash.display.Stage that represents the application window
		 *  mapped to this SystemManager
		 */
		public function get stage():Stage;
		/**
		 * A list of the tooltips
		 *  being parented by this ISystemManager.
		 */
		public function get toolTipChildren():IChildList;
		/**
		 * The ISystemManager responsible for the application window.
		 *  This will be the same ISystemManager unless this application
		 *  has been loaded into another application.
		 */
		public function get topLevelSystemManager():ISystemManager;
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
		 * Unregisters a top-level window containing a FocusManager.
		 *  Called by the FocusManager, generally not called by application code.
		 *
		 * @param f                 <IFocusManagerContainer> The top-level window in the application.
		 */
		public function removeFocusManager(f:IFocusManagerContainer):void;
	}
}
