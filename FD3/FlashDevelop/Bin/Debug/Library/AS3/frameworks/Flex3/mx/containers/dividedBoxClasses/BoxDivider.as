package mx.containers.dividedBoxClasses
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import mx.containers.DividedBox;
	import mx.containers.DividerState;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.SandboxMouseEvent;

include "../../styles/metadata/GapStyles.as"
	/**
	 *  @copy mx.containers.DividedBox#style:dividerAffordance
	 */
	[Style(name="dividerAffordance", type="Number", format="Length", inherit="no")] 

	/**
	 *  @copy mx.containers.DividedBox#style:dividerAlpha
	 */
	[Style(name="dividerAlpha", type="Number", inherit="no")] 

	/**
	 *  @copy mx.containers.DividedBox#style:dividerColor
	 */
	[Style(name="dividerColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  @copy mx.containers.DividedBox#style:dividerThickness
	 */
	[Style(name="dividerThickness", type="Number", format="Length", inherit="no")] 

include "../../core/Version.as"
	/**
	 *  The BoxDivider class represents the divider between children of a DividedBox container.
 *
 *  @see mx.containers.DividedBox
	 */
	public class BoxDivider extends UIComponent
	{
		/**
		 *  @private
		 */
		private var knob : DisplayObject;
		/**
		 *  @private
		 */
		private var isMouseOver : Boolean;
		/**
		 *  @private
     *  Storage for the state property.
		 */
		private var _state : String;

		/**
		 *  @private
		 */
		public function set x (value:Number) : void;

		/**
		 *  @private
		 */
		public function set y (value:Number) : void;

		/**
		 *  @private
		 */
		function get state () : String;
		/**
		 *  @private
		 */
		function set state (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function BoxDivider ();

		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		private function mouseOverHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function mouseOutHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function mouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
     * 
     *  @param event MouseEvent or SandboxMouseEvent.
		 */
		private function mouseUpHandler (event:Event) : void;
	}
}
