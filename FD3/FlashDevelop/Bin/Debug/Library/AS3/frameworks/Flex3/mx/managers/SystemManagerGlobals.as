package mx.managers
{
	/**
	 *  @private
	 */
	public class SystemManagerGlobals
	{
		public static var topLevelSystemManagers : Array;
		/// of SystemManager
		public static var bootstrapLoaderInfoURL : String;
		public static var showMouseCursor : Boolean;
		public static var changingListenersInOtherSystemManagers : Boolean;
		public static var dispatchingEventToOtherSystemManagers : Boolean;
	}
}
