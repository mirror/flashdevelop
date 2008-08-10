/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public interface IRepeaterClient {
		/**
		 * An Array that contains the indices required
		 *  to reference the repeated component instance from its document.
		 *  This Array is empty unless the component
		 *  is within one or more Repeaters.
		 *  The first element corresponds to the outermost Repeater.
		 *  For example, if the id is "b"
		 *  and instanceIndices is [ 2, 4 ],
		 *  you would reference it on the document as b[2][4].
		 */
		public function get instanceIndices():Array;
		public function set instanceIndices(value:Array):void;
		/**
		 * Determines whether this UIComponent instance is a document object,
		 *  that is, whether it is at the top of the hierarchy of a Flex
		 *  application, MXML component, or ActionScript component.
		 */
		public function get isDocument():Boolean;
		/**
		 * An Array that contains the indices of the items in the data
		 *  providers of the Repeaters that produced the component.
		 *  The Array is empty unless the component is within one or more
		 *  Repeaters.
		 *  The first element corresponds to the outermost Repeater component.
		 *  For example, if repeaterIndices is [ 2, 4 ],
		 *  the outer Repeater component used its dataProvider[2]
		 *  data item and the inner Repeater component used its
		 *  dataProvider[4] data item.
		 */
		public function get repeaterIndices():Array;
		public function set repeaterIndices(value:Array):void;
		/**
		 * An Array that contains any enclosing Repeaters of the component.
		 *  The Array is empty unless the component is within one or more Repeaters.
		 *  The first element corresponds to the outermost Repeater.
		 */
		public function get repeaters():Array;
		public function set repeaters(value:Array):void;
		/**
		 * Initializes the instanceIndices,
		 *  repeaterIndices, and repeaters properties.
		 *
		 * @param parent            <IRepeaterClient> 
		 */
		public function initializeRepeaterArrays(parent:IRepeaterClient):void;
	}
}
