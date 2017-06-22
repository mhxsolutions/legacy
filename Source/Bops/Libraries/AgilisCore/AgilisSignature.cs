using System;
using System.IO;

namespace AgilisCore
{
    public class AgilisSignature
    {
        private const string _DefaultType = "UNK";
        private const string _DefaultImageFormat = "png";
        private const string _DefaultFilenameFormat = "{0} {1} {2}.{3}";

        // Fields in memory during parsing and initial storage.
        private string _ImageFormat;
        private string _ImageData;
        private string _WorkOrderNumber;

        // Fields stored in the database.
        private int _SignatureId;
        private int _WorkOrderRef;
        private DateTime _Timestamp;
        private int _Number;
        private string _Folder;
        private string _FileName;
        private string _Type;

        public AgilisSignature()
        {
            _ImageFormat = _DefaultImageFormat;
            _Type = _DefaultType;
        }

        public int Number
        {
            get { return _Number; }
            set { _Number = value; }
        }

        public int SignatureId
        {
            get { return _SignatureId; }
            set { _SignatureId = value; }
        }

        public int WorkOrderRef
        {
            get { return _WorkOrderRef; }
            set { _WorkOrderRef = value; }
        }

        public DateTime Timestamp
        {
            get { return _Timestamp; }
            set { _Timestamp = value; }
        }

        public string Folder
        {
            get { return _Folder; }
            set { _Folder = value; }
        }

        public string FileName
        {
            get { return _FileName; }
            set { _FileName = value; }
        }

        public string Type
        {
            get { return _Type; }
            set { _Type = value; }
        }

        public string FullyQualifiedFileName
        {
            get { return Path.Combine(_Folder, _FileName); }
        }

        public string ImageFormat
        {
            get { return _ImageFormat; }
            set { _ImageFormat = value; }
        }

        public string ImageData
        {
            get { return _ImageData; }
            set { _ImageData = value; }
        }

        public string WorkOrderNumber
        {
            get { return _WorkOrderNumber; }
            set { _WorkOrderNumber = value; }
        }

        public void SetWorkOrderDetails(AgilisWorkOrder WorkOrder)
        {
            WorkOrderRef = WorkOrder.WorkOrderId;
            FileName = string.Format(_DefaultFilenameFormat, Timestamp.ToString("yyyy-MM-dd HH-mm-ss"), WorkOrder.WorkOrderNumber, Number, ImageFormat);
        }

        public void WriteSignatureFile()
        {
            byte[] PngFileData = Convert.FromBase64String(_ImageData);
            FileStream OutputStream = new FileStream(FullyQualifiedFileName, FileMode.Create);
            OutputStream.Write(PngFileData, 0, PngFileData.Length);
            OutputStream.Flush();
            OutputStream.Close();
        }
    }
}
