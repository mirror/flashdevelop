package mx.resources
{
	public interface IResourceBundle
	{
		public function get bundleName () : String;

		public function get content () : Object;

		public function get locale () : String;
	}
}
