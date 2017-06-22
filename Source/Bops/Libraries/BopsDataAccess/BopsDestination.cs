using System;

namespace BopsDataAccess
{
    public class BopsDestination
    {
        public int DestinationId { get; set; }
        public string Name { get; set; }
        public string StreetAddress1 { get; set; }
        public string StreetAddress2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public string PostalCode { get; set; }
        public string Country { get; set; }
        public string Abbreviation { get; set; }
        public float? Distance { get; set; }
        public DateTime? RunTime { get; set; }
        public float? Zone { get; set; }
        public float? Value { get; set; }
        public bool Receiver { get; set; }
        public bool HrsPtsFlag { get; set; }
        public DateTime? FirstReceive { get; set; }
        public DateTime? LastReceive { get; set; }
        public DateTime? TransitTime { get; set; }
        public float? MinimumShipmentWeight { get; set; }
        public int? FixedPay { get; set; }
        public bool FixedPayFlag { get; set; }
        public bool ShipsToBudway { get; set; }
        public bool StoresAtBudway { get; set; }
        public bool PaysCrossDock { get; set; }
        public bool PaysStorage { get; set; }
        public bool PaysTransportation { get; set; }
        public bool ReceivesFromBudway { get; set; }
        public int? ParentRef { get; set; }
        public bool Broker { get; set; }
        public bool BackhaulDestination { get; set; }
        public float? DetentionAfter { get; set; }
        public string NotificationAddress { get; set; }
        public bool GiveNotification { get; set; }
        public int? UnloadTime { get; set; }
        public string ContactName { get; set; }
        public string ContactVoicePhoneNumber { get; set; }
        public string ContactFaxPhoneNumber { get; set; }
        public string ContactMobilePhoneNumber { get; set; }
        public string ContactEmailAddress { get; set; }
        public DateTime? BreakStart { get; set; }
        public DateTime? BreakEnd { get; set; }
        public string CompanyWebSite { get; set; }
        public string SharePoint { get; set; }
        public bool TempFlag { get; set; }
        public bool StageAnalysis { get; set; }
        public DateTime? LunchStart { get; set; }
        public DateTime? LunchEnd { get; set; }
        public int? MaximumLoadsPerDay { get; set; }
        public string PreferredArrivalTime { get; set; }
        public bool ArrangesLateDelivery { get; set; }
        public bool ArrangesSaturdayDelivery { get; set; }
        public bool AppointmentRequired { get; set; }
        public string Comments { get; set; }
        public int MaximumLoadsPerHour { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public int? AverageRelocate { get; set; }
        public bool Terminal { get; set; }
        public int CompanyRef { get; set; }

        public override string ToString()
        {
            return string.Format("{0}: {1}, {2}", Name, City ?? string.Empty, State ?? string.Empty);
        }
    }
}
