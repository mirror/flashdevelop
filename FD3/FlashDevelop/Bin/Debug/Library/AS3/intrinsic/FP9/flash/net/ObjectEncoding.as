package flash.net 
{
	public final class ObjectEncoding 
	{
		/**
		 * Allows greater control over the serialization of dynamic properties of dynamic objects.
		 *  When this property is set to null,
		 *  the default value, dynamic properties are serialized using native code, which writes
		 *  all dynamic properties excluding those whose value is a function.
		 */
		public static function get dynamicPropertyWriter():IDynamicPropertyWriter;
		public function set dynamicPropertyWriter(value:IDynamicPropertyWriter):void;
		/**
		 * Specifies that objects are serialized using the Action Message Format for ActionScript 1.0 and 2.0.
		 */
		public static const AMF0:uint = 0;
		/**
		 * Specifies that objects are serialized using the Action Message Format for ActionScript 3.0.
		 */
		public static const AMF3:uint = 3;
		/**
		 * Specifies the default (latest) format for the current runtime (either Flash®
		 *  Player or Adobe® AIR. Because object encoding control is only
		 *  available in Flash Player 9 and later and Adobe AIR, the earliest format used will be
		 *  the Action Message Format for ActionScript 3.0.
		 */
		public static const DEFAULT:uint = 3;
	}
	
}
