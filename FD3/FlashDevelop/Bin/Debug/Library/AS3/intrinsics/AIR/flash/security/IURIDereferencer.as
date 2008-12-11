package flash.security
{
	/// IURIDereferencer defines an interface for objects that resolve URIs in an XML signature.
	public class IURIDereferencer
	{
		/// [AIR] Resolves and dereferences the specified URI.
		public function dereference(uri:String):flash.utils.IDataInput;

	}

}

