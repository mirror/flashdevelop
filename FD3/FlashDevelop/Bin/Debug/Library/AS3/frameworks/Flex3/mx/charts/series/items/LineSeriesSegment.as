/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.series.items {
	import mx.charts.series.LineSeries;
	public class LineSeriesSegment {
		/**
		 * The series or element that owns this segment.
		 */
		public var element:LineSeries;
		/**
		 * The index into the items array of the last item
		 *  in this segment, inclusive.
		 */
		public var end:uint;
		/**
		 * The index of this segment in the array of segments
		 *  representing the line series.
		 */
		public var index:uint;
		/**
		 * The array of chartItems representing the full line series
		 *  that owns this segment.
		 */
		public var items:Array;
		/**
		 * The index into the items array of the first item in this segment.
		 */
		public var start:uint;
		/**
		 * Constructor.
		 *
		 * @param element           <LineSeries> The owning series.
		 * @param index             <uint> The index of the segment in the Array of segments
		 *                            representing the line series.
		 * @param items             <Array> The Array of LineSeriesItems
		 *                            representing the full line series.
		 * @param start             <uint> The index in the items Array
		 *                            of the first item in this segment.
		 * @param end               <uint> The index in the items Array
		 *                            of the last item in this segment, inclusive.
		 */
		public function LineSeriesSegment(element:LineSeries, index:uint, items:Array, start:uint, end:uint);
		/**
		 * Returns a copy of this segment.
		 */
		public function clone():LineSeriesSegment;
	}
}
