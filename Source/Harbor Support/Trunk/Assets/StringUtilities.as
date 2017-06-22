
function TrimLeading(theString:String, charactersToTrim:String):String {
	while (theString.length > 0 && charactersToTrim.indexOf(theString.charAt(0)) > -1) {
		theString = theString.substring(1, theString.length);
	}
	return theString;
}
