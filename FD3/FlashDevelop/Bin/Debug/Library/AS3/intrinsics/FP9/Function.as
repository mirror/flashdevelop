package 
{
	/// A function is the basic unit of code that can be invoked in ActionScript.
	public class Function
	{
		/// Specifies the object instance on which the Function is called.
		public function apply(thisObject:Object, argArray:Array=null):void;

		/// Invokes this Function.
		public function call(thisObject:Object, parameter1:String=null):void;

	}

}

