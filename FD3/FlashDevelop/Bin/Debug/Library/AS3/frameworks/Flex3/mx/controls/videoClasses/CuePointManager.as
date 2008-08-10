/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.videoClasses {
	public class CuePointManager {
		/**
		 * Constructor.
		 *
		 * @param owner             <VideoPlayer> 
		 * @param id                <uint (default = 0)> 
		 */
		public function CuePointManager(owner:VideoPlayer, id:uint = 0);
		/**
		 * Adds a cue point.
		 *
		 * @param cuePoint          <Object> The Object describes the cue
		 *                            point.  It must contain the properties name:String
		 *                            and time:Number (in seconds).
		 *                            If the Object does not conform to these
		 *                            conventions, it throws a VideoError error.
		 * @return                  <Object> A copy of the cue point Object added. The copy has the
		 *                            following additional properties:
		 *                            array - the Array of all cue points. Treat
		 *                            this Array as read only because adding, removing or editing objects
		 *                            within it can cause cue points to malfunction.
		 *                            index - the index into the Array for the
		 *                            returned cue point.
		 */
		public function addCuePoint(cuePoint:Object):Object;
		/**
		 * Search for a cue point with specified name.
		 *
		 * @param name              <String> The name of the cue point.
		 * @return                  <Object> null if no match was found, or
		 *                            a copy of the matching cue point Object with additional properties:
		 *                            array - the Array of cue points searched. Treat
		 *                            this array as read only because adding, removing or editing objects
		 *                            within it can cause cue points to malfunction.
		 *                            index - the index into the Array for the
		 *                            returned cue point.
		 */
		public function getCuePointByName(name:String):Object;
		/**
		 * Returns an Array of all cue points.
		 *
		 * @return                  <Array> An Array of cue point objects.
		 *                            Each cue point object describes the cue
		 *                            point, and contains the properties name:String
		 *                            and time:Number (in seconds).
		 */
		public function getCuePoints():Array;
		/**
		 * Removes all cue points.
		 */
		public function removeAllCuePoints():void;
		/**
		 * Removes a cue point from the currently
		 *  loaded FLV file.  Only the name and time
		 *  properties are used from the cuePoint argument to
		 *  determine the cue point to be removed.
		 *
		 * @param cuePoint          <Object> The Object must contain at least one of
		 *                            name:String and time:Number properties, and
		 *                            removes the cue point that matches the specified properties.
		 * @return                  <Object> An object representing the cue point removed. If there was no
		 *                            matching cue point, then it returns null.
		 */
		public function removeCuePoint(cuePoint:Object):Object;
		/**
		 * Set the array of cue points.
		 *
		 * @param cuePointArray     <Array> An Array of cue point objects.
		 *                            Each cue point object describes the cue
		 *                            point. It must contain the properties name:String
		 *                            and time:Number (in seconds).
		 */
		public function setCuePoints(cuePointArray:Array):void;
	}
}
