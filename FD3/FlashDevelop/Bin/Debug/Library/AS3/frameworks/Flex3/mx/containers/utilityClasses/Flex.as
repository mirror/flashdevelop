package mx.containers.utilityClasses
{
	import mx.core.Container;
	import mx.core.IUIComponent;
	import mx.core.FlexVersion;

	/**
	 *  @private *  The Flex class is for internal use only.
	 */
	public class Flex
	{
		/**
		 *  This function sets the width of each child	 *  so that the widths add up to spaceForChildren.	 *  Each child is set to its preferred width	 *  if its percentWidth is zero.	 *  If it's percentWidth is a positive number	 *  the child grows depending on the size of its parent	 *  The height of each child is set to its preferred height.	 *  The return value is any extra space that's left over	 *  after growing all children to their maxWidth.	 *	 *  @param parent The parent container of the children.	 *	 *  @param spaceForChildren The space that is to be	 *  distributed across all the children.	 *	 *  @param h height for all children.	 *	 *  @result Any extra space that's left over	 *  after growing all children to their maxWidth.
		 */
		public static function flexChildWidthsProportionally (parent:Container, spaceForChildren:Number, h:Number) : Number;
		/**
		 *  This function sets the height of each child	 *  so that the heights add up to spaceForChildren. 	 *  Each child is set to its preferred height	 *  if its percentHeight is zero.	 *  If its percentHeight is a positive number,	 *  the child grows (or shrinks) to consume its share of extra space.	 *  The width of each child is set to its preferred width.	 *  The return value is any extra space that's left over	 *  after growing all children to their maxHeight.	 *	 *  @param parent The parent container of the children.	 *	 *  @param spaceForChildren The space that is to be 	 *  distributed across all children .	 *	 *  @param w width for all children.
		 */
		public static function flexChildHeightsProportionally (parent:Container, spaceForChildren:Number, w:Number) : Number;
		/**
		 *  This function distributes excess space among the flexible children.	 *  It does so with a view to keep the children's overall size	 *  close the ratios specified by their percent.	 *	 *  @param spaceForChildren The total space for all children	 *	 *  @param spaceToDistribute The space that needs to be distributed	 *  among the flexible children.	 *	 *  @param childInfoArray An array of Objects. When this function	 *  is called, each object should define the following properties:	 *  - percent: the percentWidth or percentHeight of the child (depending	 *  on whether we're growing in a horizontal or vertical direction)	 *  - min: the minimum width (or height) for that child	 *  - max: the maximum width (or height) for that child	 *	 *  @return When this function finishes executing, a "size" property	 *  will be defined for each child object. The size property contains	 *  the portion of the spaceToDistribute to be distributed to the child.	 *  Ideally, the sum of all size properties is spaceToDistribute.	 *  If all the children hit their minWidth/maxWidth/minHeight/maxHeight	 *  before the space was distributed, then the remaining unused space	 *  is returned. Otherwise, the return value is zero.
		 */
		public static function flexChildrenProportionally (spaceForChildren:Number, spaceToDistribute:Number, totalPercent:Number, childInfoArray:Array) : Number;
		/**
		 *  This function distributes excess space among the flexible children	 *  because of rounding errors where we want to keep children's dimensions 	 *  full pixel amounts.  This only distributes the extra space 	 *  if there was some rounding down and there are still 	 *  flexible children.	 *	 *  @param parent The parent container of the children.	 * 	 *  @param spaceForChildren The total space for all children
		 */
		public static function distributeExtraHeight (parent:Container, spaceForChildren:Number) : void;
		/**
		 *  This function distributes excess space among the flexible children	 *  because of rounding errors where we want to keep children's dimensions 	 *  full pixel amounts.  This only distributes the extra space 	 *  if there was some rounding down and there are still 	 *  flexible children.	 *	 *  @param parent The parent container of the children.	 * 	 *  @param spaceForChildren The total space for all children
		 */
		public static function distributeExtraWidth (parent:Container, spaceForChildren:Number) : void;
	}
}
