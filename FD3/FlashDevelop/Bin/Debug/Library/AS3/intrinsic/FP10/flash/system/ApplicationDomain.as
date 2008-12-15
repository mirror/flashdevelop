package flash.system
{
	/// The ApplicationDomain class is a container for discrete groups of class definitions.
	public class ApplicationDomain
	{
		/// [FP10] Gets the minimum memory object length required to be used as ApplicationDomain.domainMemory.
		public static const MIN_DOMAIN_MEMORY_LENGTH:uint;

		/// Gets the current application domain in which your code is executing.
		public static var currentDomain:flash.system.ApplicationDomain;

		/// Gets the parent domain of this application domain.
		public var parentDomain:flash.system.ApplicationDomain;

		/// Gets and sets the object on which domain-global memory operations will operate within this ApplicationDomain.
		public var domainMemory:flash.utils.ByteArray;

		/// Creates a new application domain.
		public function ApplicationDomain(parentDomain:flash.system.ApplicationDomain=null);

		/// Gets a public definition from the specified application domain.
		public function getDefinition(name:String):Object;

		/// Checks to see if a public definition exists within the specified application domain.
		public function hasDefinition(name:String):Boolean;

	}

}

