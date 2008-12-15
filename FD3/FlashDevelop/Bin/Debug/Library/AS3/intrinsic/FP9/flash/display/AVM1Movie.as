package flash.display
{
	/// The AVM1Movie class represents display objects that represent AVM1 movies.
	public class AVM1Movie
	{
		/// Registers an ActionScript method as callable from the container.
		public function addCallback(functionName:String, closure:Function):void;
		
		/// Calls a function exposed by the AVM1Movie.
		public function call (functionName:String, ...params):*;
	}
	
}