package mx.containers.accordionClasses
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mx.containers.Accordion;
	import mx.controls.Button;
	import mx.core.Container;
	import mx.core.FlexVersion;
	import mx.core.EdgeMetrics;
	import mx.core.IDataRenderer;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleManager;

	/**
	 *  The AccordionHeader class defines the appearance of the navigation buttons *  of an Accordion. *  You use the <code>getHeaderAt()</code> method of the Accordion class to get a reference *  to an individual AccordionHeader object. * *  @see mx.containers.Accordion
	 */
	public class AccordionHeader extends Button implements IDataRenderer
	{
		/**
		 *  @private	 *  Placeholder for mixin by AccordionHeaderAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		private var focusObj : DisplayObject;
		/**
		 *  @private
		 */
		private var focusSkin : IFlexDisplayObject;
		/**
		 *  @private	 *  Storage for the _data property.
		 */
		private var _data : Object;

		/**
		 *  Stores a reference to the content associated with the header.
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  @private
		 */
		public function set selected (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function AccordionHeader ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		public function drawFocus (isFocused:Boolean) : void;
		/**
		 *  @private
		 */
		function layoutContents (unscaledWidth:Number, unscaledHeight:Number, offset:Boolean) : void;
		/**
		 *  @private
		 */
		protected function rollOverHandler (event:MouseEvent) : void;
	}
}
