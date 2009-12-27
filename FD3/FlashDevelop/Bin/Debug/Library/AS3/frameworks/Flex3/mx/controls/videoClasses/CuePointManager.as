package mx.controls.videoClasses
{
	import flash.events.Event;
	import mx.controls.VideoDisplay;
	import mx.core.mx_internal;
	import mx.events.MetadataEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

include "../../core/Version.as"
	/**
	 *  The CuePointManager class lets you use ActionScript code to 
 *  manage the cue points associated with the VideoDisplay control.  
 *
 *  @see mx.controls.VideoDisplay
	 */
	public class CuePointManager
	{
		/**
		 *  @private
		 */
		private var _owner : VideoPlayer;
		private var _metadataLoaded : Boolean;
		private var _disabledCuePoints : Array;
		private var _disabledCuePointsByNameOnly : Object;
		private var _cuePointIndex : uint;
		private var _cuePointTolerance : Number;
		private var _linearSearchTolerance : Number;
		private static var DEFAULT_LINEAR_SEARCH_TOLERANCE : Number;
		private var cuePoints : Array;
		/**
		 *  @private
     *  Reference to VideoDisplay object associated with this CuePointManager
     *  instance.
		 */
		var videoDisplay : VideoDisplay;
		/**
		 *  @private
     *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  @private
     *  read only, has metadata been loaded
		 */
		private function get metadataLoaded () : Boolean;

		/**
		 *  @private
     *  <p>Set by FLVPlayback to update _cuePointTolerance</p>
     *  Should be exposed in VideoDisplay/ here in Flex 2.0.
		 */
		private function set playheadUpdateInterval (aTime:Number) : void;

		/**
		 *  Constructor.
     *  
     *  @param owner The VideoPlayer instance that is the parent of this CuePointManager.
     *  @param id This parameter is ignored; it is provided only for backwards compatibility.
		 */
		public function CuePointManager (owner:VideoPlayer, id:uint = 0);

		/**
		 *  @private
     *  Reset cue point lists
		 */
		private function reset () : void;

		/**
		 *  Adds a cue point.
     *
     *  <p>You can add multiple cue points with the same
     *  name and time.  When you call the <code>removeCuePoint()</code> method 
     *  with the name and time,  it removes the first matching cue point. 
     *  To remove all matching cue points, you have to make additional calls to
     *  the <code>removeCuePoint()</code> method.</p>
     *
     *  @param cuePoint The Object describes the cue
     *  point.  It must contain the properties <code>name:String</code> 
     *  and <code>time:Number</code> (in seconds).  
     *  If the Object does not conform to these
     *  conventions, it throws a <code>VideoError</code> error.
     *
     *  @return A copy of the cue point Object added. The copy has the
     *  following additional properties:
     *
     *  <ul>
     *    <li><code>array</code> - the Array of all cue points. Treat
     *    this Array as read only because adding, removing or editing objects
     *    within it can cause cue points to malfunction.</li>
     * 
     *    <li><code>index</code> - the index into the Array for the
     *    returned cue point.</li>
     *  </ul>
     * 
     *  @throws mx.controls.videoClasses.VideoError If the arguments are invalid.
		 */
		public function addCuePoint (cuePoint:Object) : Object;

		/**
		 *  Removes a cue point from the currently
     *  loaded FLV file.  Only the <code>name</code> and <code>time</code> 
     *  properties are used from the <code>cuePoint</code> argument to 
     *  determine the cue point to be removed.
     *
     *  <p>If multiple cue points match the search criteria, only
     *  one will be removed.  To remove all cue points, call this function
     *  repeatedly in a loop with the same arguments until it returns
     *  <code>null</code>.</p>
     *
     *  @param cuePoint The Object must contain at least one of
     *  <code>name:String</code> and <code>time:Number</code> properties, and
     *  removes the cue point that matches the specified properties.
     *
     *  @return An object representing the cue point removed. If there was no
     *  matching cue point, then it returns <code>null</code>.
		 */
		public function removeCuePoint (cuePoint:Object) : Object;

		/**
		 *  @private    
     *  removes enabled cue points from _disabledCuePoints
		 */
		private function removeCuePoints (cuePointArray:Array, cuePoint:Object) : Number;

		/**
		 *  @private    
     *  inserts cue points into array
		 */
		private function insertCuePoint (insertIndex:Number, cuePointArray:Array, cuePoint:Object) : Array;

		/**
		 *  @private
     *  <p>Called by FLVPlayback on "playheadUpdate" event
     *  to throw "cuePoint" events when appropriate.</p>
		 */
		function dispatchCuePoints () : void;

		/**
		 *  @private
     *  When our place in the stream is changed, this is called
     *  to reset our index into actionscript cue point array.
     *  Another method is used when cue points are added
     *  are removed.
		 */
		function resetCuePointIndex (time:Number) : void;

		/**
		 *  @private
     *  Search for a cue point in an array sorted by time.  See
     *  closeIsOK parameter for search rules.
     *
     *  @param cuePointArray array to search
     *  @param closeIsOK If true, the behavior differs depending on the
     *  parameters passed in:
     * 
     *  <ul>
     *
     *  <li>If name is null or undefined, then if the specific time is
     *  not found then the closest time earlier than that is returned.
     *  If there is no cue point earlier than time, the first cue point
     *  is returned.</li>
     *
     *  <li>If time is null, undefined or less than 0 then the first
     *  cue point with the given name is returned.</li>
     *
     *  <li>If time and name are both defined then the closest cue
     *  point, then if the specific time and name is not found then the
     *  closest time earlier than that with that name is returned.  If
     *  there is no cue point with that name and with an earlier time,
     *  then the first cue point with that name is returned.  If there
     *  is no cue point with that name, null is returned.</li>
     * 
     *  <li>If time is null, undefined or less than 0 and name is null
     *  or undefined, a VideoError is thrown.</li>
     * 
     *  </ul>
     *
     *  <p>If closeIsOK is false the behavior is:</p>
     *
     *  <ul>
     *
     *  <li>If name is null or undefined and there is a cue point with
     *  exactly that time, it is returned.  Otherwise null is
     *  returned.</li>
     *
     *  <li>If time is null, undefined or less than 0 then the first
     *  cue point with the given name is returned.</li>
     *
     *  <li>If time and name are both defined and there is a cue point
     *  with exactly that time and name, it is returned.  Otherwise null
     *  is returned.</li>
     *
     *  <li>If time is null, undefined or less than 0 and name is null
     *  or undefined, a VideoError is thrown.</li>
     * 
     *  </ul>
     *  @param time search criteria
     *  @param name search criteria
     *  @param start index of first item to be searched, used for
     *  recursive implementation, defaults to 0 if undefined
     *  @param len length of array to search, used for recursive
     *  implementation, defaults to cuePointArray.length if undefined
     *  @returns index for cue point in given array or -1 if no match found
     *  @throws VideoError if time and/or name parameters are bad
     *  @see #cuePointCompare()
		 */
		private function getCuePointIndex (cuePointArray:Array, closeIsOK:Boolean, time:Number, name:String, start:Number, len:Number) : Number;

		/**
		 *  @private
     *  <p>Given a name, array and index, returns the next cue point in
     *  that array after given index with the same name.  Returns null
     *  if no cue point after that one with that name.  Throws
     *  VideoError if argument is invalid.</p>
     *
     *  @returns index for cue point in given array or -1 if no match found
		 */
		private function getNextCuePointIndexWithName (name:String, array:Array, index:Number) : Number;

		/**
		 *  @private
     *  Takes two cue point Objects and returns -1 if first sorts
     *  before second, 1 if second sorts before first and 0 if they are
     *  equal.  First compares times with millisecond precision.  If
     *  they match, compares name if name parameter is not null or undefined.
		 */
		private static function cuePointCompare (time:Number, name:String, cuePoint:Object) : Number;

		/**
		 *  @private
     *
     *  <p>Search for a cue point in the given array at the given time
     *  and/or with given name.</p>
     *
     *  @param closeIsOK If true, the behavior differs depending on the
     *  parameters passed in:
     * 
     *  <ul>
     *
     *  <li>If name is null or undefined, then if the specific time is
     *  not found then the closest time earlier than that is returned.
     *  If there is no cue point earlier than time, the first cue point
     *  is returned.</li>
     *
     *  <li>If time is null, undefined or less than 0 then the first
     *  cue point with the given name is returned.</li>
     *
     *  <li>If time and name are both defined then the closest cue
     *  point, then if the specific time and name is not found then the
     *  closest time earlier than that with that name is returned.  If
     *  there is no cue point with that name and with an earlier time,
     *  then the first cue point with that name is returned.  If there
     *  is no cue point with that name, null is returned.</li>
     * 
     *  <li>If time is null, undefined or less than 0 and name is null
     *  or undefined, a VideoError is thrown.</li>
     * 
     *  </ul>
     *
     *  <p>If closeIsOK is false the behavior is:</p>
     *
     *  <ul>
     *
     *  <li>If name is null or undefined and there is a cue point with
     *  exactly that time, it is returned.  Otherwise null is
     *  returned.</li>
     *
     *  <li>If time is null, undefined or less than 0 then the first
     *  cue point with the given name is returned.</li>
     *
     *  <li>If time and name are both defined and there is a cue point
     *  with exactly that time and name, it is returned.  Otherwise null
     *  is returned.</li>
     *
     *  <li>If time is null, undefined or less than 0 and name is null
     *  or undefined, a VideoError is thrown.</li>
     *  
     *  </ul>
     *  @param timeOrCuePoint If String, then name for search.  If
     *  Number, then time for search.  If Object, then cuepoint object
     *  containing time and/or name parameters for search.
     *  @returns <code>null</code> if no match was found, otherwise
     *  copy of cuePoint object with additional properties:
     *
     *  <ul>
     *  
     *  <li><code>array</code> - the array that was searched. Treat
     *  this array as read only as adding, removing or editing objects
     *  within it can cause cue points to malfunction.</li>
     *
     *  <li><code>index</code> - the index into the array for the
     *  returned cuepoint.</li>
     *
     *  </ul>
     *  @see #getCuePointIndex()
		 */
		private function getCuePoint (cuePointArray:Array, closeIsOK:Boolean, timeNameOrCuePoint:Object = null) : Object;

		/**
		 *  @private
     *  <p>Given a cue point object returned from getCuePoint (needs
     *  the index and array properties added to those cue points),
     *  returns the next cue point in that array after that one with
     *  the same name.  Returns null if no cue point after that one
     *  with that name.  Throws VideoError if argument is invalid.</p>
     *
     *  @returns <code>null</code> if no match was found, otherwise
     *  copy of cuePoint object with additional properties:
     *
     *  <ul>
     *  
     *  <li><code>array</code> - the array that was searched.  Treat
     *  this array as read only as adding, removing or editing objects
     *  within it can cause cue points to malfunction.</li>
     *
     *  <li><code>index</code> - the index into the array for the
     *  returned cuepoint.</li>
     *
     *  </ul>
		 */
		private function getNextCuePointWithName (cuePoint:Object) : Object;

		/**
		 *  Search for a cue point with specified name.
     *
     *  @param name The name of the cue point.
     *  
     *  @return <code>null</code> if no match was found, or 
     *  a copy of the matching cue point Object with additional properties:
     *
     *  <ul>
     *    <li><code>array</code> - the Array of cue points searched. Treat
     *    this array as read only because adding, removing or editing objects
     *    within it can cause cue points to malfunction.</li>
     *
     *    <li><code>index</code> - the index into the Array for the
     *    returned cue point.</li>
     *  </ul>
		 */
		public function getCuePointByName (name:String) : Object;

		/**
		 *  Returns an Array of all cue points.
     *
     *  @return An Array of cue point objects. 
     *  Each cue point object describes the cue
     *  point, and contains the properties <code>name:String</code> 
     *  and <code>time:Number</code> (in seconds).
		 */
		public function getCuePoints () : Array;

		/**
		 *  Removes all cue points.
		 */
		public function removeAllCuePoints () : void;

		/**
		 * Set the array of cue points.
     *
     * <p>You can add multiple cue points with the same
     * name and time.  When you call the <code>removeCuePoint()</code> method
     * with this name, only the first one is removed.</p>
     *
     *  @param cuePointArray An Array of cue point objects. 
     *  Each cue point object describes the cue
     *  point. It must contain the properties <code>name:String</code> 
     *  and <code>time:Number</code> (in seconds).
		 */
		public function setCuePoints (cuePointArray:Array) : void;

		/**
		 *  @private
     *  Used to make copies of cue point objects.
		 */
		private static function deepCopyObject (obj:Object, recurseLevel:Number = 0) : Object;
	}
}
