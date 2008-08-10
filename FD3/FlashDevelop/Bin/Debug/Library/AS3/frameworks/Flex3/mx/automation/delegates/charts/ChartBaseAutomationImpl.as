/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.charts {
	import mx.automation.delegates.core.UIComponentAutomationImpl;
	import mx.charts.chartClasses.ChartBase;
	import flash.geom.Point;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	public class ChartBaseAutomationImpl extends UIComponentAutomationImpl {
		/**
		 * Constructor.
		 *
		 * @param obj               <ChartBase> ChartBase object to be automated.
		 */
		public function ChartBaseAutomationImpl(obj:ChartBase);
		/**
		 * @param inPoint           <Point> 
		 * @param targetObj         <DisplayObject> 
		 */
		public override function getLocalPoint(inPoint:Point, targetObj:DisplayObject):Point;
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
		/**
		 */
		public override function isDragEventPositionBased():Boolean;
		/**
		 * @param event             <KeyboardEvent> 
		 */
		protected override function keyDownHandler(event:KeyboardEvent):void;
		/**
		 * @param event             <KeyboardEvent> 
		 */
		protected function keyDownHandler1(event:KeyboardEvent):void;
		/**
		 * @param event             <Event> 
		 */
		public override function replayAutomatableEvent(event:Event):Boolean;
	}
}
