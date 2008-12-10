package mx.binding
{
	/**
	 *  @private
	 */
	public interface IWatcherSetupUtil
	{
		/**
		 *  @private
		 */
		public function setup (target:Object, propertyGetter:Function, bindings:Array, watchers:Array) : void;
	}
}
