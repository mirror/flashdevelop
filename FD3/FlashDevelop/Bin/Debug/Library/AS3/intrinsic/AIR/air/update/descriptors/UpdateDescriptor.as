package air.update.descriptors
{
	public class UpdateDescriptor extends Object
	{
		public static const NAMESPACE_UPDATE_1_0 : Namespace;

		public function get description () : Array;

		public function get url () : String;

		public function get version () : String;

		public static function getLocalizedText (elem:XMLList, ns:Namespace) : Array;

		public function getXML () : XML;

		public static function isThisVersion (ns:Namespace) : Boolean;

		public function UpdateDescriptor (xml:XML);

		public function validate () : void;
	}
}
