
using System;
namespace BopsDataAccess
{
    /// <summary>
    /// Get invoice details 
    /// </summary>
    public class BopsRfsInvoiceReportDetail
    {
        public int RFSInvoiceID { get; set; }
        public int InvoiceStatusRef { get; set; }
        public double InvoiceTotal { get; set; }
        public DateTime InvoiceDate { get; set; }
        public string PublicNotes { get; set; }
        public string BillTo { get; set; }
        public string Shipper { get; set; }
        public string BillToAddress { get; set; }
        public string ShipperAddress { get; set; }
        public int LineNumber { get; set; }
        public DateTime Itemdate { get; set; }
        public string ItemDescription { get; set; }
        public double ItemTotal { get; set; }

        //    private int _RFSInvoiceID;
        //    private int _InvoiceStatusRef;
        //    private double _InvoiceTotal;
        //    private DateTime _InvoiceDate;
        //    private string _PublicNotes;
        //    private string _BillTo;
        //    private string _Shipper;
        //    private string _BillToAddress;
        //    private string _ShipperAddress;
        //    private int _LineNumber;
        //    private DateTime _Itemdate;
        //    private string _ItemDescription;
        //    private double _ItemTotal;

        //    public int RFSInvoiceID
        //    {
        //        get { return _RFSInvoiceID; }
        //        set { _RFSInvoiceID=value; }
        //    }

        //    public int InvoiceStatusRef
        //    {
        //        get { return _InvoiceStatusRef; }
        //        set { _InvoiceStatusRef = value; }
        //    }

        //    public double InvoiceTotal
        //    {
        //        get { return _InvoiceTotal; }
        //        set { _InvoiceTotal = value; }
        //    }

        //    public DateTime InvoiceDate
        //    {
        //        get { return _InvoiceDate; }
        //        set { _InvoiceDate = value; }
        //    }

        //    public string PublicNotes
        //    {
        //        get { return _PublicNotes; }
        //        set { _PublicNotes = value; }
        //    }
        //    public string BillTo
        //    {
        //        get { return _BillTo; }
        //        set { _BillTo = value; }
        //    }

        //    public string Shipper
        //    {
        //        get { return _Shipper; }
        //        set { _Shipper = value; }
        //    }

        //    public string BillToAddress
        //    {
        //        get { return _BillToAddress; }
        //        set { _BillToAddress = value; }
        //    }

        //    public string ShipperAddress
        //    {
        //        get { return _ShipperAddress; }
        //        set { _ShipperAddress = value; }
        //    }

        //    public int LineNumber
        //    {
        //        get { return _LineNumber; }
        //        set { _LineNumber = value; }
        //    }

        //    public DateTime Itemdate
        //    {
        //        get { return _Itemdate; }
        //        set { _Itemdate = value; }
        //    }
        //    public string ItemDescription
        //    {
        //        get { return _ItemDescription; }
        //        set { _ItemDescription = value; }
        //    }

        //    public double ItemTotal
        //    {
        //        get { return _ItemTotal; }
        //        set { _ItemTotal = value; }
        //    }
    }
}
