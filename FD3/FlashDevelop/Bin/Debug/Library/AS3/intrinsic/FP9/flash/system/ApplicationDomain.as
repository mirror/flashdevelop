package flash.system
{
	import flash.system.ApplicationDomain;

	/// The ApplicationDomain class is a container for discrete groups of class definitions.
	public class ApplicationDomain extends Object
	{
		/// Gets the current application domain in which your code is executing.
		public static function get currentDomain () : ApplicationDomain;

		/// Gets the parent domain of this application domain.
		public function get parentDomain () : ApplicationDomain;

		/// Creates a new application domain.
		public function ApplicationDomain (parentDomain:ApplicationDomain = null);

		/// Gets a public definition from the specified application domain.
		public function getDefinition (name:String) : Object;

		/// Checks to see if a public definition exists within the specified application domain.
		public function hasDefinition (name:String) : Boolean;
	}
}
