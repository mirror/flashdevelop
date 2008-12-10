package mx.rpc.xml
{
	/**
	 * This internal utility class is used by XMLDecoder. The class is basically * a dynamic version any simple type such as Number, String, Boolean so  * that other properties can be attached to it as annotations. * * @private
	 */
	internal dynamic class SimpleContent
	{
		public var value : *;

		public function SimpleContent (val:*);
		public function toString () : String;
		public function valueOf () : Object;
	}
}
