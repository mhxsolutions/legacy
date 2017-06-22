
class HopsDrEntry
{
	/*
		Taken from the C# class:
		
        private int _DrId;
        private int _ProjectManagerBolRef;
        private int _Count;
        private double _Weight;
        private DateTime _LastUpdateTime;
        private bool _Finalized;
        private string _GatePass;
        private string _LoadRef;
        private string _Tractor;
	*/
	
	var drId:Number;
	var blId:Number;
	var totalCount:Number;
	var totalWeight:Number;
	var isFinalized:Boolean;
	var gatePass:String;
	var loadRef:String;
	var tractorId:String;
	var itemsArray:Array;
}
