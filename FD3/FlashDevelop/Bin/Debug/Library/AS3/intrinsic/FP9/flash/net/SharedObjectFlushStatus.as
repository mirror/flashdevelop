package flash.net 
{
	public final class SharedObjectFlushStatus 
	{
		/// Indicates that the flush completed successfully.
		public static const FLUSHED:String = "flushed";
		
		/// Indicates that the user is being prompted to increase disk space for the shared object before the flush can occur.
		public static const PENDING:String = "pending";
	}
	
}
