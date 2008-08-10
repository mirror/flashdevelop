/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	public class SubscriptionInfo {
		/**
		 * The selector.  If null, indicates all messages should be sent.
		 */
		public var selector:String;
		/**
		 * The subtopic - if null, represents a subscription for messages directed to the
		 *  destination with no subtopic.
		 */
		public var subtopic:String;
		/**
		 * Builds a new SubscriptionInfo with the specified subtopic and selector
		 *
		 * @param st                <String> 
		 * @param sel               <String> 
		 */
		public function SubscriptionInfo(st:String, sel:String);
	}
}
