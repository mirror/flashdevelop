package flash.profiler
{
	public function heapDump (name:String = null) : void;

	public function profile (on:Boolean) : void;

	/// Shows or hides redraw regions.
	public function showRedrawRegions (on:Boolean, color:uint = 16711680) : void;

}
