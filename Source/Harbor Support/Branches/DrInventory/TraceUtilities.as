
class TraceUtilities
{
	public static function dumpObject(o:Object, objectName:String):Void
	{
		trace("Dumping " + objectName + ":");
		for (var key in o) {
			trace("  ." + key + " = " + o[key]);
		}
	}
}
