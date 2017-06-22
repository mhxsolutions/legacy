namespace AgilisCore
{
    public enum ImportMode
    {
        Add,
        Update
    }

    public interface IAgilisWorkOrderImportNotifier
    {
        bool BeforeImport(AgilisWorkOrder WorkOrder);
        void AfterImport(AgilisWorkOrder WorkOrder, ImportMode Mode);
    }

    public class AgilisEventHandler
    {
        private IAgilisWorkOrderImportNotifier _WorkOrderImportNotifier;

        public IAgilisWorkOrderImportNotifier WorkOrderImportNotifier
        {
            get { return _WorkOrderImportNotifier; }
            set { _WorkOrderImportNotifier = value; }
        }
    }
}
