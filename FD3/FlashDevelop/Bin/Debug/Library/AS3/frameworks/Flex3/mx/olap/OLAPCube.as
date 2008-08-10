/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.olap {
	import flash.utils.Proxy;
	import flash.events.IEventDispatcher;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import flash.events.Event;
	public class OLAPCube extends Proxy implements IOLAPCube, IEventDispatcher {
		/**
		 * The time interval, in milliseconds, used by the refresh() method
		 *  to iteratively build the cube.
		 *  You can set it to a higher value if you can wait longer before the cube is built.
		 *  You can set it to a lower value, but it might negatively impact responsiveness of your application.
		 */
		protected var cubeBuildingTimeInterval:int = 5;
		/**
		 * The flat data used to populate the OLAP cube.
		 *  You must call the refresh() method
		 *  to initialize the cube after setting this property.
		 */
		public function get dataProvider():ICollectionView;
		public function set dataProvider(value:ICollectionView):void;
		/**
		 * All dimensions in the cube, as a list of IOLAPDimension instances.
		 */
		public function get dimensions():IList;
		public function set dimensions(value:IList):void;
		/**
		 * Processes the input Array and initializes the dimensions
		 *  and measures properties based on the elements of the Array.
		 *  Dimensions are represented in the Array by instances of the OLAPDimension class,
		 *  and measures are represented by instances of the OLAPMeasure class.
		 */
		public function set elements(value:Array):void;
		/**
		 * Sets the name of the dimension for the measures of the OLAP cube.
		 */
		protected var measureDimensionName:String = "Measures";
		/**
		 * Sets the measures of the OLAP cube, as a list of OLAPMeasure instances.
		 */
		public function set measures(value:IList):void;
		/**
		 * The name of the OLAP cube.
		 */
		public function get name():String;
		public function set name(value:String):void;
		/**
		 * The time interval, in milliseconds, used by the timer of the execute() method
		 *  to iteratively process queries.
		 *  You can set it to a higher value if you can wait for longer
		 *  before the cube generates the query result.
		 *  You can set it to a lower value to obtain query results faster,
		 *  but it might negatively impact the responsiveness of your application.
		 */
		protected var queryBuildingTimeInterval:int = 1;
		/**
		 * The class used by an OLAPCube instance to return the result.
		 *  You can replace the default class, OLAPResult, with your own implementation
		 *  of the IOLAPResult interface to customize the result.
		 */
		protected var resultClass:Class;
		/**
		 * Constructor.
		 *
		 * @param name              <String (default = null)> The name of the OLAP cube.
		 */
		public function OLAPCube(name:String = null);
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener
		 *  receives notification of an event.
		 *
		 * @param type              <String> The type of event.
		 * @param listener          <Function> The listener function that processes the event.
		 * @param useCapture        <Boolean (default = false)> Determines whether the listener works in the capture phase
		 *                            or the target and bubbling phases.
		 * @param priority          <int (default = 0)> The priority level of the event listener.
		 * @param useWeakReference  <Boolean (default = false)> Determines whether the reference to the listener is strong or weak.
		 *                            A strong reference (the default) prevents your listener from being garbage-collected.
		 *                            A weak reference does not.
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		/**
		 * Aborts a query that has been submitted for execution.
		 *
		 * @param query             <IOLAPQuery> The query to abort.
		 */
		public function cancelQuery(query:IOLAPQuery):void;
		/**
		 * Aborts the current cube refresh, if one is executing.
		 */
		public function cancelRefresh():void;
		/**
		 * Dispatches an event into the event flow.
		 *  The event target is the object upon which the dispatchEvent() method is called.
		 *
		 * @param event             <Event> The Event object that is dispatched into the event flow.
		 * @return                  <Boolean> A value of true if the event was successfully dispatched.
		 *                            A value of false indicates failure or that the
		 *                            preventDefault() method was called on the event.
		 */
		public function dispatchEvent(event:Event):Boolean;
		/**
		 * Queues an OLAP query for execution.
		 *  After you call the refresh() method to update the cube,
		 *  you must wait for a complete event
		 *  before you call the execute() method.
		 *
		 * @param query             <IOLAPQuery> The query to execute, represented by an IOLAPQuery instance.
		 * @return                  <AsyncToken> An AsyncToken instance.
		 */
		public function execute(query:IOLAPQuery):AsyncToken;
		/**
		 * Returns the dimension with the given name within the OLAP cube.
		 *
		 * @param name              <String> The name of the dimension.
		 * @return                  <IOLAPDimension> An IOLAPDimension instance representing the dimension,
		 *                            or null if a dimension is not found.
		 */
		public function findDimension(name:String):IOLAPDimension;
		/**
		 * Checks whether the object has any listeners registered for a specific type of event.
		 *  This lets you determine where an object has altered handling of
		 *  an event type in the event flow hierarchy.
		 *
		 * @param type              <String> The type of event.
		 * @return                  <Boolean> A value of true if a listener of the specified type
		 *                            is registered; false otherwise.
		 */
		public function hasEventListener(type:String):Boolean;
		/**
		 * Refreshes the cube from the data provider.
		 *  After setting the cube's schema, you must call this method to build the cube.
		 */
		public function refresh():void;
		/**
		 * Removes a listener.
		 *  If there no matching listener is registered,
		 *  a call to this method has no effect.
		 *
		 * @param type              <String> The type of event.
		 * @param listener          <Function> The listener object to remove.
		 * @param useCapture        <Boolean (default = false)> Specifies whether the listener was registered for
		 *                            the capture phase or the target and bubbling phases.
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		/**
		 * Returns the name of the cube
		 *
		 * @return                  <String> The name of the cube.
		 */
		public function toString():String;
		/**
		 * Checks whether an event listener is registered with this object or any of its ancestors for the specified event type.
		 *  This method returns true if an event listener is triggered during any phase of the event flow
		 *  when an event of the specified type is dispatched to this object or to any of its descendants.
		 *
		 * @param type              <String> The type of event.
		 * @return                  <Boolean> A value of true if a listener of the
		 *                            specified type is triggered; false otherwise.
		 */
		public function willTrigger(type:String):Boolean;
	}
}
