TRACE MESSAGE:

-> Adds a new log entry to the trace log.

<message cmd="trace" state="1">Hello FlashDevelop!</message>

NOTIFY MESSAGE:

-> Sends the message to the selected plugin.

<message cmd="notify" guid="54749F71-694B-47E0-9B05-E9417F39F20D">Hello plugin!</message>

RETURN MESSAGE:

-> Sends the contents back to the flash movie.

<message cmd="return">
	<mainNode>Some data here.</mainNode> <-- root node required
</message>

GETSETTING MESSAGE:

-> Asks for a setting from the FlashDevelop.

<message cmd="getsetting">FlashDevelop.EOLMode</message>

-> Returns the following message:

<flashconnect>
	<message cmd="getsetting" key="FlashDevelop.EOLMode">0</message>
</flashconnect>
