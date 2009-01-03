package flash.security
{
	import flash.utils.IDataInput;

	/// IURIDereferencer defines an interface for objects that resolve URIs in an XML signature.
	public interface IURIDereferencer extends *
	{
		/// [AIR] Resolves and dereferences the specified URI.
		public function dereference (uri:String) : IDataInput;

		public function IURIDereferencer ();
	}
}
