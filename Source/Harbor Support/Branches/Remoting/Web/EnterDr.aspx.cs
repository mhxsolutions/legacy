using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI.WebControls;
using BopsDataAccess;
using log4net;
using NHibernate;
using NHibernate.Expression;
using NHibernateUtilities;

public partial class EnterDr : System.Web.UI.Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(EnterDr));

    private const double _PoundsPerKilogram = 2.20462262;
    private const double _PoundsPerMetricTon = 2204.62262;
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    private double? GetWeightInPounds()
    {
        double Weight;

        if (double.TryParse(WeightTextbox.Text, out Weight))
        {
            if (WeightUnitDropdownlist.SelectedValue == "Kilos")
                Weight *= _PoundsPerKilogram;
            else if (WeightUnitDropdownlist.SelectedValue == "Metric Tons")
                Weight *= _PoundsPerMetricTon;
            return Weight;
        }

        return null;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Request.Browser.IsMobileDevice)
        //    Response.Redirect("~/Mobile/");

        bool Finalized = false;
        BlTextbox.Focus();
        WeightUnitDropdownlist.Attributes["onchange"] = "TriggerWeightValidation();";

        if ((Request.Params["DrId"] != null) && !IsPostBack)
        {
            int Drid;

            if (int.TryParse(Request.Params["DrId"], out Drid))
            {
                DrTextbox.Text = Drid.ToString();

                SessionManager<string> Mgr = new SessionManager<string>();

                try
                {
                    string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
                    ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
                    HopsDrEntry Dr = DwsNoRepData.Get<HopsDrEntry>(Drid);
                    Finalized = Dr.Finalized;

                    BlTextbox.Text = Dr.ProjectManagerBolRef.ToString();
                    if (Dr.Count.HasValue)
                        CountTextbox.Text = Dr.Count.ToString();
                    if (Dr.Weight.HasValue)
                        WeightTextbox.Text = Dr.Weight.ToString();
                    GatePassTextbox.Text = Dr.GatePass;
                    LoadTextbox.Text = Dr.LoadRef;
                    TractorTextbox.Text = Dr.Tractor;
                }
                catch (Exception e1)
                {
                    _Log.Error(e1);
                }
                finally
                {
                    Mgr.CloseAllSessions(false);
                }
            }
        }

        SaveButton.Enabled = !Finalized;
        FinalizeButton.Enabled = !Finalized;
    }

    protected void ServerValidateWeight(object sender, ServerValidateEventArgs e)
    {
        bool WeightIsValid = false;

        try
        {
            double? Weight = GetWeightInPounds();
            if (Weight.HasValue && 0 < Weight.Value && Weight.Value <= HopsDrEntry.MaximumWeight)
                WeightIsValid = true;
        }
        catch (Exception e1)
        {
            _Log.Error(e1);
        }
        finally
        {
            e.IsValid = WeightIsValid;
        }
    }

    protected void ServerValidateBlId(object sender, ServerValidateEventArgs e)
    {
        bool BlIsValid = false;
        SessionManager<string> Mgr = new SessionManager<string>();

        try
        {
            int Blid;

            if (int.TryParse(BlTextbox.Text, out Blid))
            {
                string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

                // The BL is valid if it exists, and if it refers to a harbor project that is active.

                BopsProjectManagerBillOfLading Pmbl = DwsNoRepData.Get<BopsProjectManagerBillOfLading>(Blid);
                if (Pmbl != null)
                {
                    BopsProjectManagerDeliveryOrder Pmdo = DwsNoRepData.Get<BopsProjectManagerDeliveryOrder>(Pmbl.PmdoRef);
                    if (Pmdo != null)
                    {
                        BopsProjectManagerStatus.Codes Status = (BopsProjectManagerStatus.Codes)(Pmdo.ProjectStatusRef);
                        BlIsValid = (Status == BopsProjectManagerStatus.Codes.Active);
                    }
                }
            }
        }
        catch (Exception e1)
        {
            _Log.Error(e1);
        }
        finally
        {
            Mgr.CloseAllSessions(false);
            e.IsValid = BlIsValid;
        }
    }

    protected void ServerValidateDrId(object sender, ServerValidateEventArgs e)
    {
        bool DrIsValid = false;
        SessionManager<string> Mgr = new SessionManager<string>();

        try
        {
            int Drid;

            if (int.TryParse(DrTextbox.Text, out Drid))
            {
                string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
                BopsProjectManagerDr Pmdr = DwsNoRepData.Get<BopsProjectManagerDr>(Drid);
                HopsDrEntry Dr = DwsNoRepData.Get<HopsDrEntry>(Drid);

                // The DR is valid if the corresponding project manager DR ID already exists and
                // either the harbor DR entry doesn't exist or isn't finalized. If the DR exists, 
                // and if the user has supplied a BL ID, the DR's BL must match as well.

                DrIsValid = (Pmdr != null) && ((Dr == null) || (!Dr.Finalized));

                // Rather than complicate the above logic, we perform the additional check here and
                // fail if the BL supplied doesn't match the DR's BL.

                int Blid;
                if (int.TryParse(BlTextbox.Text, out Blid))
                {
                    if (Pmdr != null && Blid != Pmdr.BillOfLadingRef)
                        DrIsValid = false;
                }
            }
        }
        catch (Exception e1)
        {
            _Log.Error(e1);
        }
        finally
        {
            Mgr.CloseAllSessions(false);
            e.IsValid = DrIsValid;
        }
    }

    protected void ServerValidateLoad(object sender, ServerValidateEventArgs e)
    {
        bool LoadIsValid = false;
        SessionManager<string> Mgr = new SessionManager<string>();

        try
        {
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
            BopsLoad Load = DwsNoRepData.Get<BopsLoad>(LoadTextbox.Text);
            LoadIsValid = (Load != null);
        }
        catch (Exception e1)
        {
            _Log.Error(e1);
        }
        finally
        {
            Mgr.CloseAllSessions(false);
            e.IsValid = LoadIsValid;
        }
    }

    private void SaveAndRedirect(bool Finalize)
    {
        bool CommitChanges = false;
        SessionManager<string> Mgr = new SessionManager<string>();
        string RedirectPage = "EnterDr.aspx";

        try
        {
            string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
            ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
            Mgr.BeginTransaction(_DwsNoRepData);

            int Drid = Convert.ToInt32(DrTextbox.Text);
            HopsDrEntry NewDrEntry = DwsNoRepData.Get<HopsDrEntry>(Drid);

            if (NewDrEntry == null)
            {
                NewDrEntry = new HopsDrEntry();
                NewDrEntry.DrId = Drid;
            }
            else if (NewDrEntry.Finalized)
            {
                _Log.ErrorFormat("DRID {0} has already been finalized and cannot be edited", Drid);
                RedirectPage = "EnterDrError.aspx";
                return;
            }

            NewDrEntry.ProjectManagerBolRef = Convert.ToInt32(BlTextbox.Text);
            int Count;
            if (int.TryParse(CountTextbox.Text, out Count))
                NewDrEntry.Count = Count;
            else
                NewDrEntry.Count = null;
            NewDrEntry.Weight = GetWeightInPounds();
            NewDrEntry.LastUpdateTime = DateTime.Now;

            if (GatePassTextbox.Text.Length > 0)
                NewDrEntry.GatePass = GatePassTextbox.Text;
            if (LoadTextbox.Text.Length > 0)
                NewDrEntry.LoadRef = LoadTextbox.Text;
            if (TractorTextbox.Text.Length > 0)
                NewDrEntry.Tractor = TractorTextbox.Text;

            // If we're supposed to finalize the record, then it's time to migrate the data to the
            // main [Project Manager DR] table for further processing.

            if (Finalize)
            {
                BopsLoad Load = DwsNoRepData.Get<BopsLoad>(NewDrEntry.LoadRef);
                IList<BopsProjectManagerDr> LoadDrs = DwsNoRepData.CreateCriteria(typeof (BopsProjectManagerDr))
                    .Add(Expression.Eq("LoadKeyRef", Load.LoadKey))
                    .List<BopsProjectManagerDr>();

                if (LoadDrs.Count > 0)
                {
                    DwsNoRepData.SaveOrUpdateCopy(NewDrEntry);
                    RedirectPage = string.Format("EnterDrConfirmFinalize.aspx?DrId={0}&LoadRef={1}", NewDrEntry.DrId, NewDrEntry.LoadRef);
                }
                else
                {
                    BopsProjectManagerDr Pmdr = DwsNoRepData.Get<BopsProjectManagerDr>(Drid);
                    Pmdr.Count = NewDrEntry.Count;
                    Pmdr.Weight = NewDrEntry.Weight;
                    Pmdr.LoadKeyRef = Load.LoadKey;
                    Pmdr.GatePass = NewDrEntry.GatePass;
                    DwsNoRepData.Update(Pmdr);

                    NewDrEntry.Finalized = Finalize;
                    DwsNoRepData.SaveOrUpdateCopy(NewDrEntry);
                }
            }
            else
            {
                DwsNoRepData.SaveOrUpdateCopy(NewDrEntry);
            }

            CommitChanges = true;
        }
        catch (Exception e1)
        {
            RedirectPage = "EnterDrError.aspx";
            _Log.Debug("An exception occured, details follow.", e1);
        }
        finally
        {
            Mgr.CloseAllSessions(CommitChanges);
            Context.Response.Redirect(RedirectPage);
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        Page.Validate("AlwaysRequired");
        if (!Page.IsValid)
        {
            _Log.Debug("Page is invalid for save; skipping data entry.");
            return;
        }

        SaveAndRedirect(false);
    }

    protected void FinalizeButton_Click(object sender, EventArgs e)
    {
        Page.Validate("AlwaysRequired");
        Page.Validate("RequiredForLock");
        if (!Page.IsValid)
        {
            _Log.Debug("Page is invalid for finalize; skipping data entry.");
            return;
        }

        SaveAndRedirect(true);
    }
}
