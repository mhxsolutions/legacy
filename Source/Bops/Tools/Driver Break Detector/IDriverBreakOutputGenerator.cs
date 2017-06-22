namespace Driver_Break_Detector
{
    interface IDriverBreakOutputGenerator
    {
        void GenerateOutput(string OutputFolderName, IStatusDisplay StatusDisplay);
    }
}
