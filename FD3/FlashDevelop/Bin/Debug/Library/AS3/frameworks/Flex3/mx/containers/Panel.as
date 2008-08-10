/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	import mx.core.Container;
	import mx.containers.utilityClasses.IConstraintLayout;
	import mx.core.IFontContextComponent;
	import mx.core.IFlexModuleFactory;
	import flash.events.MouseEvent;
	public class Panel extends Container implements IConstraintLayout, IFontContextComponent {
		/**
		 * The set of styles to pass from the Panel to the close button.
		 */
		protected function get closeButtonStyleFilters():Object;
		/**
		 * An Array of ConstraintColumn instances that partition this container.
		 *  The ConstraintColumn instance at index 0 is the left-most column;
		 *  indices increase from left to right.
		 */
		public function get constraintColumns():Array;
		public function set constraintColumns(value:Array):void;
		/**
		 * An Array of ConstraintRow instances that partition this container.
		 *  The ConstraintRow instance at index 0 is the top-most row;
		 *  indices increase from top to bottom.
		 */
		public function get constraintRows():Array;
		public function set constraintRows(value:Array):void;
		/**
		 * A reference to this Panel container's control bar, if any.
		 */
		protected var controlBar:IUIComponent;
		/**
		 * The module factory that provides the font context for this component.
		 */
		public function get fontContext():IFlexModuleFactory;
		public function set fontContext(value:IFlexModuleFactory):void;
		/**
		 * Specifies the layout mechanism used for this container.
		 *  Panel containers can use "vertical", "horizontal",
		 *  or "absolute" positioning.
		 *  Vertical positioning lays out the child components vertically from
		 *  the top of the container to the bottom in the specified order.
		 *  Horizontal positioning lays out the child components horizontally
		 *  from the left of the container to the right in the specified order.
		 *  Absolute positioning does no automatic layout and requires you to
		 *  explicitly define the location of each child component.
		 */
		public function get layout():String;
		public function set layout(value:String):void;
		/**
		 * Text in the status area of the title bar.
		 */
		public function get status():String;
		public function set status(value:String):void;
		/**
		 * The UITextField sub-control that displays the status.
		 *  The status field is a child of the titleBar sub-control.
		 */
		protected var statusTextField:IUITextField;
		/**
		 * Title or caption displayed in the title bar.
		 */
		public function get title():String;
		public function set title(value:String):void;
		/**
		 * The TitleBar sub-control that displays the Panel container's title bar.
		 */
		protected var titleBar:UIComponent;
		/**
		 * The icon displayed in the title bar.
		 */
		public function get titleIcon():Class;
		public function set titleIcon(value:Class):void;
		/**
		 * The UITextField sub-control that displays the title.
		 *  The title field is a child of the titleBar sub-control.
		 */
		protected var titleTextField:IUITextField;
		/**
		 * Constructor.
		 */
		public function Panel();
		/**
		 * Returns the height of the header.
		 */
		protected function getHeaderHeight():Number;
		/**
		 * Calculates the default mininum and maximum sizes
		 *  of the Panel container.
		 *  For more information
		 *  about the measure() method, see the
		 *  UIComponent.measure() method.
		 */
		protected override function measure():void;
		/**
		 * Called when the user starts dragging a Panel
		 *  that has been popped up by the PopUpManager.
		 *
		 * @param event             <MouseEvent> 
		 */
		protected function startDragging(event:MouseEvent):void;
		/**
		 * Called when the user stops dragging a Panel
		 *  that has been popped up by the PopUpManager.
		 */
		protected function stopDragging():void;
	}
}
