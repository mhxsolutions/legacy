using System;
using BopsDataAccess;
using FlashGateway.IO;

namespace DrServices
{
    internal class RemotingTranslator
    {
        public static HopsDrEntry FlashToHopsDrEntry(ASObject Aso)
        {
            HopsDrEntry ReturnValue = null;

            if (Aso != null)
            {
                ReturnValue = new HopsDrEntry();

                if (Aso.ContainsKey("drId"))
                    ReturnValue.DrId = Convert.ToInt32(Aso["drId"]);
                if (Aso.ContainsKey("blId"))
                    ReturnValue.ProjectManagerBolRef = Convert.ToInt32(Aso["blId"]);
                if (Aso.ContainsKey("totalCount") && Aso["totalCount"].ToString() != "NaN")
                {
                    int Count;
                    if (int.TryParse(Aso["totalCount"].ToString(), out Count))
                        ReturnValue.Count = Count;
                }
                if (Aso.ContainsKey("totalWeight") && Aso["totalWeight"].ToString() != "NaN")
                {
                    double Weight;
                    if (double.TryParse(Aso["totalWeight"].ToString(), out Weight))
                        ReturnValue.Weight = Weight;
                }
                ReturnValue.LastUpdateTime = DateTime.Now;
                if (Aso.ContainsKey("isFinalized"))
                    ReturnValue.Finalized = Convert.ToBoolean(Aso["isFinalized"]);
                if (Aso.ContainsKey("gatePass"))
                    ReturnValue.GatePass = Aso["gatePass"].ToString();
                if (Aso.ContainsKey("loadRef"))
                    ReturnValue.LoadRef = Aso["loadRef"].ToString();
                if (Aso.ContainsKey("tractorId"))
                    ReturnValue.Tractor = Aso["tractorId"].ToString();
            }

            return ReturnValue;
        }

        public static ASObject HopsDrEntryToFlash(HopsDrEntry Hdr)
        {
            ASObject ReturnValue = null;

            if (Hdr != null)
            {
                ReturnValue = new ASObject();
                ReturnValue.ASType = "HopsDrEntry";

                ReturnValue.Add("drId", Hdr.DrId);
                ReturnValue.Add("blId", Hdr.ProjectManagerBolRef);
                ReturnValue.Add("totalCount", Hdr.Count);
                ReturnValue.Add("totalWeight", Hdr.Weight);
                ReturnValue.Add("isFinalized", Hdr.Finalized);
                ReturnValue.Add("gatePass", Hdr.GatePass ?? string.Empty);
                ReturnValue.Add("loadRef", Hdr.LoadRef ?? string.Empty);
                ReturnValue.Add("tractorId", Hdr.Tractor ?? string.Empty);
            }

            return ReturnValue;
        }
    }
}
