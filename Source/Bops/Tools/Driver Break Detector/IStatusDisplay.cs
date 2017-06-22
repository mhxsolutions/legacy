namespace Driver_Break_Detector
{
    public interface IStatusDisplay
    {
        string PrimaryTaskDescription { set; }
        string SecondaryTaskDescription { set; }

        void ShowProgressBar(int InitialValue, int TotalItems);
        void UpdateProgressBar(int NewValue);
        void HideProgressBar();

        void UpdateTasksAndProgressBar(string PrimaryTask, string SecondaryTask, int NewValue);
    }
}
