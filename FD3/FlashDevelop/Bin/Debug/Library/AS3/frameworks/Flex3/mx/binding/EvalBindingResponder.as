package mx.binding
{
	import mx.rpc.IResponder;

include "../core/Version.as"
	/**
	 *  @private
 *  This responder is a fallback in case the set or get methods
 *  we are invoking to implement this binding do not properly
 *  catch the ItemPendingError.  There may be some issues with
 *  leaving this in long term as we are not handling the
 *  case where this binding is executed multiple times in
 *  rapid succession (and thus piling up responders) and
 *  also not dealing with a potential stale item responder.
	 */
	public class EvalBindingResponder implements IResponder
	{
		/**
		 *  @private
		 */
		private var binding : Binding;
		/**
		 *  @private
		 */
		private var object : Object;

		/**
		 *  @private
	 *  Constructor.
		 */
		public function EvalBindingResponder (binding:Binding, object:Object);

		/**
		 *  @private
		 */
		public function result (data:Object) : void;

		/**
		 *  @private
		 */
		public function fault (data:Object) : void;
	}
}
