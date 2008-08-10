/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging {
	import mx.collections.ArrayCollection;
	import mx.messaging.messages.IMessage;
	public class MultiTopicProducer extends AbstractProducer {
		/**
		 * Provides access to the list of subtopics used in publishing any messages
		 */
		public function get subtopics():ArrayCollection;
		public function set subtopics(value:ArrayCollection):void;
		/**
		 * Constructs a Producer.
		 */
		public function MultiTopicProducer();
		/**
		 * Adds a subtopic to the current list of subtopics for messages sent by this
		 *  producer.  This is a shortcut to adding this subtopic to the subtopics
		 *  property.
		 *
		 * @param subtopic          <String> 
		 */
		public function addSubtopic(subtopic:String):void;
		/**
		 * @param message           <IMessage> 
		 * @param waitForClientId   <Boolean (default = true)> 
		 */
		protected override function internalSend(message:IMessage, waitForClientId:Boolean = true):void;
		/**
		 * Removes the subtopic from the subtopics property.  Throws an error if the
		 *  subtopic is not in the list.
		 *
		 * @param subtopic          <String> 
		 */
		public function removeSubtopic(subtopic:String):void;
	}
}
