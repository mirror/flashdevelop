/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import mx.core.IFactory;
	import flash.text.TextFormat;
	public class InstanceCache {
		/**
		 * The number of items currently required in the cache.
		 */
		public function get count():int;
		public function set count(value:int):void;
		/**
		 * A callback invoked when new instances are created.
		 */
		public var creationCallback:Function;
		/**
		 * Determines if unneeded instances are discarded.
		 *  If set to true, extra elements are discarded
		 *  when the cache count is reduced.
		 *  Otherwise, extra elements are kept in a separate cache
		 *  and reused when the count is increased.
		 */
		public var discard:Boolean = false;
		/**
		 * A factory that generates the type of object to cache.
		 *  Assigning to this discards all current instances
		 *  and recreate new instances of the correct type.
		 */
		public function get factory():IFactory;
		public function set factory(value:IFactory):void;
		/**
		 * A TextFormat to apply to any instances created.
		 *  If set, this format is applied as the current and default format
		 *  for the contents of any instances created.
		 *  This property is only relevant if the factory
		 *  generates TextField instances.
		 */
		public function get format():TextFormat;
		public function set format(value:TextFormat):void;
		/**
		 * Determines if unneeded instances should be hidden.
		 *  If true, the visible property
		 *  is set to false on each extra element
		 *  when the cache count is reduced, and set to true
		 *  when the count is increased.
		 */
		public var hide:Boolean = true;
		/**
		 * The position of the instance in the parent's child list.
		 */
		public function set insertPosition(value:int):void;
		/**
		 * The Array of cached instances.
		 *  There may be more instances in this Array than currently requested.
		 *  You should rely on the count property
		 *  of the instance cache rather than the length of this Array.
		 */
		public function get instances():Array;
		/**
		 * A hashmap of properties to assign to new instances.
		 *  Each key/value pair in this hashmap is assigned
		 *  to each new instance created.
		 *  The property hashmap is assigned to any existing instances when set.
		 */
		public function get properties():Object;
		public function set properties(value:Object):void;
		/**
		 * Determines if unneeded instances should be removed from their parent.
		 *  If true, the removeChild() method
		 *  is called on the parent for each extra element
		 *  when the cache count is reduced.
		 */
		public var remove:Boolean = false;
		/**
		 * Constructor.
		 *
		 * @param type              <Object> The type of object to construct.
		 *                            This can be either a Class or an IFactory.
		 * @param parent            <Object (default = null)> An optional DisplayObject to add new instances to.
		 * @param insertPosition    <int (default = -1)> Where in the parent's child list
		 *                            to insert instances. Set to -1 to add the children to the end of the child list.
		 */
		public function InstanceCache(type:Object, parent:Object = null, insertPosition:int = -1);
	}
}
