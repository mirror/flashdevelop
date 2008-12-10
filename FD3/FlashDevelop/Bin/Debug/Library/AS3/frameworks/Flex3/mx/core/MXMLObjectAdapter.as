package mx.core
{
	/**
	 *  The MXMLObjectAdapter class is a stub implementation *  of the IMXMLObject interface, so that you can implement *  the interface without defining all of the methods. *  All implementations are the equivalent of no-ops. *  If the method is supposed to return something, it is null, 0, or false.
	 */
	public class MXMLObjectAdapter implements IMXMLObject
	{
		/**
		 *  Constructor.
		 */
		public function MXMLObjectAdapter ();
		/**
		 *  @inheritDoc
		 */
		public function initialized (document:Object, id:String) : void;
	}
}
