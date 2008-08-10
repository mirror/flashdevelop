/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public interface IRepeater {
		/**
		 * The container that contains this Repeater,
		 *  and in which it will create its children.
		 */
		public function get container():IContainer;
		/**
		 * The number of times this Repeater should execute.
		 */
		public function get count():int;
		public function set count(value:int):void;
		/**
		 * The index of the item in the dataProvider currently
		 *  being processed while this Repeater is executing.
		 */
		public function get currentIndex():int;
		/**
		 * The item in the dataProvider currently being processed
		 *  while this Repeater is executing.
		 */
		public function get currentItem():Object;
		/**
		 * The data provider used by this Repeater to create repeated instances
		 *  of its children.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * A Boolean flag indicating whether this Repeater should re-use
		 *  previously created children, or create new ones.
		 */
		public function get recycleChildren():Boolean;
		public function set recycleChildren(value:Boolean):void;
		/**
		 * The index into the dataProvider at which this Repeater
		 *  starts creating children.
		 */
		public function get startingIndex():int;
		public function set startingIndex(value:int):void;
		/**
		 * Executes the bindings into all the UIComponents created
		 *  by this Repeater.
		 */
		public function executeChildBindings():void;
		/**
		 * Initializes a new Repeater object.
		 *
		 * @param container         <IContainer> The Container that contains this Repeater,
		 *                            and in which this Repeater will create its children.
		 * @param recurse           <Boolean> A Boolean flag indicating whether this Repeater
		 *                            should create all descendants of its children.
		 */
		public function initializeRepeater(container:IContainer, recurse:Boolean):void;
	}
}
