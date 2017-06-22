using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using NPoco;

namespace Web.Clients.All
{
    public partial class LocationUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ErrorPopup.ShowOnPageLoad = false;
            ConfirmPopup.ShowOnPageLoad = false;
        }

        private int[] InventoryRecordIdsToUpdate
        {
            get
            {
                // Return the selected inventory records from the grid
                List<object> selectedIds = ASPxGridView1.GetSelectedFieldValues(new string[] { "Rec Detail ID" });
                return selectedIds.Cast<int>().ToArray();
            }
        }

        private string NewLocation
        {
            get
            {
                // Return the New Location selected
                if (cboLocations.SelectedIndex > -1)
                {
                    return cboLocations.SelectedItem.Text;
                }
                else
                {
                    return string.Empty;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
            {
                ShowConfirm();
            } 
        }

        protected void btnConfirmOk_Click(object sender, EventArgs e)
        {
            // Execute the location update
            UpdateLocations(NewLocation, InventoryRecordIdsToUpdate);

            // Clear selections and refresh the grid
            ASPxGridView1.Selection.UnselectAll();
            ASPxGridView1.DataBind();
        }

        private void ShowError(string msg)
        {
            lblMessage.Text = msg;
            ErrorPopup.ShowOnPageLoad = true; 
        }


        private void ShowConfirm()
        {
            var count = InventoryRecordIdsToUpdate.Count();
            var itemText = count > 1 ? "items" : "item";

            lblConfirmMessage.Text = string.Format("{0} {1} will be moved to location {2}. {3}{3}Click OK to continue or Cancel to quit.", 
                                        count, 
                                        itemText,
                                        NewLocation, 
                                        Environment.NewLine);
            ConfirmPopup.ShowOnPageLoad = true;
        }

        private void UpdateLocations(string newLocation, int[] invRecIds)
        {
            var sql = @"update [Inventory Detail] set Location=@loc where [Rec Detail ID] in (@recIds)";
            var historySql = @"insert into [Location Change History] ([Rec Detail ref], Location_Hist, Location_Hist_Date, Location_Hist_User) values (@0, @1, @2, @3)";
            var updateDate = DateTime.Now;

            using (Database db = new Database("UPA No Rep DataConnectionString"))
            {
                try 
                {
                    db.BeginTransaction();
                    db.Execute(sql, new { loc = newLocation, recIds = invRecIds });

                    foreach (var recId in invRecIds)
                    {
                        db.Execute(historySql, recId, newLocation, updateDate, HttpContext.Current.User.Identity.Name);
                    }

                    db.CompleteTransaction();
                }
                catch (Exception ex)
                {
                    db.AbortTransaction();
                    throw ex;
                }
            }
        }

        private bool ValidateForm()
        {
            var msg = string.Empty;

            if (string.IsNullOrEmpty(NewLocation))
            {
                msg += "You must select the New Location for the items.";
            }

            if (InventoryRecordIdsToUpdate.Count() == 0)
            {
                if (msg != string.Empty)
                    msg += Environment.NewLine + Environment.NewLine;

                msg += "You must select at least one item to move.";
            }

            if (msg != string.Empty)
            {
                ShowError(msg);
                return false;
            }
            else
            {
                return true;
            }
        }

    }
}