package flash.html.script
{
	public class PropertyEnumHelper extends Object
	{
		public function nextName (index:int) : String;

		public function nextNameIndex (lastIndex:int) : int;

		public function nextValue (index:int) : *;

		public function PropertyEnumHelper (enumPropertiesClosure:Function, getPropertyClosure:Function);
	}
}
