using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Windows.Forms;
using BopsDataAccess;
using BopsUtilities;
using log4net;
using Scm.OpsCore.Legacy.DataLayer;

namespace RFS_Invoice_Utility
{
    public partial class InvoiceEditLinesForm : Form
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(InvoiceEditLinesForm));

        private readonly bool _isBopsAdministrator;
        private readonly bool _isReadOnly;
        private readonly BopsRfsInvoice _invoice;
        private readonly IList<BopsRfsServicesOffered> _servicesOffered;
        private readonly IList<BopsRfsLocation> _rfsLocations;
        private string _lastSelectSearchText;

        public List<BopsRfsInvoiceDetail> Lines { get; set; }
        public List<BopsRfsInvoiceDetail> UnapprovedBills { get; set; }
        private CompanyDetails UserCompanyDetails { get; set; }

        public InvoiceEditLinesForm(int invoiceId, bool isBopsAdministrator, bool isReadOnly, CompanyDetails companyDetails)
        {
            InitializeComponent();

            // Initialize the data context by retrieving the relevant interface through the kernel.

            var rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
            _lastSelectSearchText = string.Empty;
            UserCompanyDetails = companyDetails;

            try
            {
                _servicesOffered = rfsDataContext.GetServicesOffered(UserCompanyDetails.Company.CompanyId);
                _rfsLocations = rfsDataContext.GetLocations(UserCompanyDetails.Company.CompanyId);

                // We create duplicate objects for all the lines to avoid messing up the originals.

                var initialLines = rfsDataContext.GetInvoiceDetailsByInvoiceId(invoiceId);
                Lines = new List<BopsRfsInvoiceDetail>(initialLines);
                UnapprovedBills = new List<BopsRfsInvoiceDetail>();

                _invoice = rfsDataContext.GetInvoiceById(invoiceId);
                _isBopsAdministrator = isBopsAdministrator;
                _isReadOnly = isReadOnly;

                if (_isReadOnly)
                {
                    StripAllModificationControls();

                    // Remove the cancel button and change the text on the OK button.
                    Controls.RemoveByKey("CloseButton");
                    OkButton.Text = "Close";
                }
                else if (!_isBopsAdministrator)
                {
                    StripAdministratorControls();
                }

                PopulateInvoiceContentListview(-1);
            }
            catch(Exception e)
            {
                Log.Error("An exception occurred constructing the invoice edit lines form. Details follow.", e);
            }
            finally
            {
                // TODO: free RFS data context
            }
        }

        private void StripAllModificationControls()
        {
            Controls.RemoveByKey("MoveUpButton");
            Controls.RemoveByKey("MoveDownButton");
            Controls.RemoveByKey("GroupButton");
            Controls.RemoveByKey("UngroupButton");
            Controls.RemoveByKey("ClearAllGroupsButton");
            Controls.RemoveByKey("EditInvoiceLineButton");
            Controls.RemoveByKey("AddBillsButton");
            Controls.RemoveByKey("UnapproveBillsButton");
            Controls.RemoveByKey("AddManualChargeButton");
            Controls.RemoveByKey("DeleteManualBillButton");
        }

        private void StripAdministratorControls()
        {
            Controls.RemoveByKey("UnapproveBillsButton");
        }

        private void AddInvoiceLineToListview(BopsRfsInvoiceDetail newLine, BopsRfsInvoiceDetail tagLine)
        {
            var newItem = new ListViewItem(newLine.LineNumberDisplayed.ToString(CultureInfo.InvariantCulture));
            newItem.SubItems.Add(newLine.DetailTypeString);
            newItem.SubItems.Add(newLine.GroupName);
            newItem.SubItems.Add(newLine.ItemDate.ToString("d"));
            newItem.SubItems.Add(string.Format("{0:c}", newLine.ItemTotal));

            if (!string.IsNullOrEmpty(newLine.GroupName) && !ShowGroupDetailCheckbox.Checked)
                newItem.SubItems.Add(newLine.GroupName);
            else
                newItem.SubItems.Add(newLine.ItemDescription);

            newItem.Tag = tagLine ?? newLine;

            //if (!string.IsNullOrEmpty(NewLine.GroupName))
            //    NewItem.BackColor = Color.LightGray;

            EditInvoiceDetailsListview.Items.Add(newItem);
        }

        static Dictionary<string, double> GetGroupTotals(IEnumerable<BopsRfsInvoiceDetail> detailLines)
        {
            var returnValue = new Dictionary<string, double>();

            foreach (var line in detailLines)
            {
                if (string.IsNullOrEmpty(line.GroupName)) continue;

                if (returnValue.ContainsKey(line.GroupName))
                    returnValue[line.GroupName] += line.ItemTotal;
                else
                    returnValue.Add(line.GroupName, line.ItemTotal);
            }

            return returnValue;
        }

        private void PopulateInvoiceContentListview(int selectedIndex)
        {
            EditInvoiceDetailsListview.Items.Clear();
            EditInvoiceDetailsListview.SuspendLayout();

            // Columns:
            //
            //  0	Line
            //  1	Manual
            //  2	Group
            //  3	Date
            //  4	Amount
            //  5	Description

            var invoiceTotal = 0.0;
            var currentGroup = string.Empty;
            var groupTotals = GetGroupTotals(Lines);

            foreach (var detail in Lines)
            {
                if (!string.IsNullOrEmpty(detail.GroupName) && !ShowGroupDetailCheckbox.Checked)
                {
                    if (currentGroup == detail.GroupName)
                        continue;

                    var lineToAdd = new BopsRfsInvoiceDetail(detail) {ItemTotal = groupTotals[detail.GroupName]};
                    currentGroup = detail.GroupName;

                    AddInvoiceLineToListview(lineToAdd, detail);
                    invoiceTotal += lineToAdd.ItemTotal;
                }
                else
                {
                    currentGroup = string.Empty;
                    AddInvoiceLineToListview(detail, null);
                    invoiceTotal += detail.ItemTotal;
                }
            }

            foreach (ColumnHeader hdr in EditInvoiceDetailsListview.Columns)
                hdr.Width = -2;
            if (-1 < selectedIndex && selectedIndex < EditInvoiceDetailsListview.Items.Count)
                EditInvoiceDetailsListview.SelectedIndices.Add(selectedIndex);
            EditInvoiceDetailsListview.ResumeLayout();

            InvoiceTotalLabel.Text = string.Format("Invoice Total: {0:c}", invoiceTotal);
        }

        private void RenumberLines()
        {
            var lineNumber = 1;
            var lineNumberDisplayed = 0;
            var currentGroup = string.Empty;

            foreach (var line in Lines)
            {
                line.LineNumber = lineNumber++;

                if (!string.IsNullOrEmpty(line.GroupName))
                {
                    if (line.GroupName == currentGroup)
                    {
                        line.LineNumberDisplayed = lineNumberDisplayed;
                        continue;
                    }

                    line.LineNumberDisplayed = ++lineNumberDisplayed;
                    currentGroup = line.GroupName;
                }
                else
                {
                    line.LineNumberDisplayed = ++lineNumberDisplayed;
                    currentGroup = string.Empty;
                }
            }
        }

        private void GroupButton_Click(object sender, EventArgs e)
        {
            if (_isReadOnly) return;

            if (EditInvoiceDetailsListview.SelectedItems.Count > 0)
            {
                var groupNames = new List<string>();
                foreach (var line in Lines)
                {
                    if (string.IsNullOrEmpty(line.GroupName)) continue;
                    var detail = line; // Not really necessary but makes ReSharper happy.
                    if (groupNames.Find(delegate(string s) { return s == detail.GroupName; } ) == null)
                        groupNames.Add(line.GroupName);
                }

                var firstSelectedLine = EditInvoiceDetailsListview.SelectedItems[0].Tag as BopsRfsInvoiceDetail;

                var newForm = new GroupPromptForm(groupNames.Count > 0 ? groupNames : null, firstSelectedLine != null ? firstSelectedLine.GroupName : null);
                if (newForm.ShowDialog() == DialogResult.OK)
                {
                    foreach (ListViewItem item in EditInvoiceDetailsListview.SelectedItems)
                    {
                        var line = item.Tag as BopsRfsInvoiceDetail;
                        if (line != null)
                        {
                            line.GroupName = newForm.GroupName;
                        }
                    }

                    GroupLines();
                    RenumberLines();
                    PopulateInvoiceContentListview(-1);
                }
            }
            else
            {
                MessageHelper.ShowInvalidOperation("You must select the detail line(s) to group.");
            }
        }

        private void GroupLines()
        {
            var groupsProcessed = new Dictionary<string, int>();
            var newLines = new List<BopsRfsInvoiceDetail>();

            for (var i = 0; i < Lines.Count; i++)
            {
                if (string.IsNullOrEmpty(Lines[i].GroupName))
                {
                    newLines.Add(Lines[i]);
                }
                else
                {
                    if (groupsProcessed.ContainsKey(Lines[i].GroupName))
                        continue;

                    groupsProcessed.Add(Lines[i].GroupName, 0);
                    newLines.Add(Lines[i]);

                    for (var j = i + 1; j < Lines.Count; j++)
                    {
                        if (Lines[j].GroupName == Lines[i].GroupName)
                            newLines.Add(Lines[j]);
                    }
                }
            }

            Lines = newLines;
        }

        private void UngroupButton_Click(object sender, EventArgs e)
        {
            if (_isReadOnly) return;

            if (EditInvoiceDetailsListview.SelectedItems.Count > 0)
            {
                if (ShowGroupDetailCheckbox.Checked)
                {
                    // In this case, every individual line has to be ungrouped.

                    foreach (ListViewItem item in EditInvoiceDetailsListview.SelectedItems)
                    {
                        var line = item.Tag as BopsRfsInvoiceDetail;
                        if (line != null)
                            line.GroupName = null;
                    }
                }
                else
                {
                    // In this case, the group names have to be used to ungroup lines.

                    var doomedGroupNames = new Dictionary<string, int>();

                    foreach (ListViewItem item in EditInvoiceDetailsListview.SelectedItems)
                    {
                        var line = item.Tag as BopsRfsInvoiceDetail;
                        if (line != null && !string.IsNullOrEmpty(line.GroupName))
                            if (!doomedGroupNames.ContainsKey(line.GroupName))
                                doomedGroupNames.Add(line.GroupName, 0);
                    }

                    foreach (var line in Lines)
                    {
                        if (!string.IsNullOrEmpty(line.GroupName) 
                            && doomedGroupNames.ContainsKey(line.GroupName))
                            line.GroupName = null;
                    }
                }

                GroupLines();
                RenumberLines();
                PopulateInvoiceContentListview(-1);
            }
            else
            {
                MessageHelper.ShowInvalidOperation("You must select the detail line(s) to ungroup.");
            }
        }

        private void ClearAllGroupsButton_Click(object sender, EventArgs e)
        {
            if (_isReadOnly) return;
            foreach (var detail in Lines)
                detail.GroupName = null;
            RenumberLines();
            PopulateInvoiceContentListview(-1);
        }

        private void EditSelectedInvoiceLine()
        {
            if (_isReadOnly) return;

            if (EditInvoiceDetailsListview.SelectedItems.Count != 1)
            {
                MessageHelper.ShowInvalidOperation("You must select a single line to edit.");
                return;
            }

            var selectedIndex = EditInvoiceDetailsListview.SelectedIndices[0];
            var line = EditInvoiceDetailsListview.SelectedItems[0];
            var detail = line.Tag as BopsRfsInvoiceDetail;
            Debug.Assert(detail != null);

            // If we're not showing group details, don't let the user click on a group line to edit it.

            if (!string.IsNullOrEmpty(detail.GroupName) && !ShowGroupDetailCheckbox.Checked)
            {
                MessageHelper.ShowInvalidOperation("To edit a grouped invoice line, first click the show group detail lines checkbox then edit the individual line.");
                return;
            }

            DialogResult result;
            if (detail.IsManualBill)
            {
                var newForm = new InvoiceDetailManualChargeForm(_servicesOffered, _rfsLocations) {InvoiceLine = detail};
                result = newForm.ShowDialog();
            }
            else
            {
                var newForm = new InvoiceDetailDetailsForm {InvoiceLine = detail};
                result = newForm.ShowDialog();
            }

            if (result == DialogResult.OK)
                PopulateInvoiceContentListview(selectedIndex);
        }

        private void EditInvoiceLineButton_Click(object sender, EventArgs e)
        {
            if (!_isReadOnly)
                EditSelectedInvoiceLine();
        }

        private void EditInvoiceDetailsListview_DoubleClick(object sender, EventArgs e)
        {
            if (!_isReadOnly)
                EditSelectedInvoiceLine();
        }

        private void AddManualChargeButton_Click(object sender, EventArgs e)
        {
            if (_isReadOnly) return;
            var newForm = new InvoiceDetailManualChargeForm(_servicesOffered, _rfsLocations);
            var result = newForm.ShowDialog();
            if (result != DialogResult.OK) return;

            var detailLine = newForm.InvoiceLine;
            detailLine.InvoiceRef = _invoice.InvoiceId;
            Lines.Add(detailLine);

            RenumberLines();
            PopulateInvoiceContentListview(-1);
        }

        private void UnapproveBillsButton_Click(object sender, EventArgs e)
        {
            if (_isReadOnly) return;

            if (!_isBopsAdministrator)
            {
                MessageHelper.ShowSecurityError("Sorry, but you must be a member of the Bops Administrators group to unapprove a bill that has already been added to an invoice.");
                return;
            }

            if (EditInvoiceDetailsListview.SelectedItems.Count > 0)
            {
                // If the show group details box is not checked, then we do not allow unapproving an entire group at once.
                // This avoids the possibility of painful user mistakes and the possibility that the group contains something
                // that cannot be unapproved (e.g., a manual bill).

                if (!ShowGroupDetailCheckbox.Checked)
                {
                    foreach (ListViewItem item in EditInvoiceDetailsListview.SelectedItems)
                    {
                        var detail = item.Tag as BopsRfsInvoiceDetail;
                        if (detail != null && detail.GroupName != null)
                        {
                            MessageHelper.ShowInvalidOperation("You cannot unapprove groups. Show the group details and select the bills to be unapproved within it.");
                            return;
                        }
                    }
                }

                // Make sure the list of items to be unapproved does not contain a manual bill.

                foreach (ListViewItem item in EditInvoiceDetailsListview.SelectedItems)
                {
                    var detail = item.Tag as BopsRfsInvoiceDetail;
                    if (detail != null && detail.IsManualBill)
                    {
                        MessageHelper.ShowInvalidOperation("You have selected at least one manual bill, which cannot be unapproved. Please change the selection and try again.");
                        return;
                    }
                }

                // Make sure that the operation won't leave the invoice empty.

                if (EditInvoiceDetailsListview.SelectedItems.Count == EditInvoiceDetailsListview.Items.Count)
                {
                    MessageHelper.ShowInvalidOperation("An invoice cannot be empty.");
                    return;
                }

                // If we've made it this far, we're good to go, but we do need to confirm the operation.

                var result = MessageHelper.ShowConfirm("Are you sure you want to unapprove the selected bills?");
                if (result != DialogResult.Yes)
                    return;

                // TODO: update this to remove the bill from the bills added list.

                foreach (ListViewItem item in EditInvoiceDetailsListview.SelectedItems)
                {
                    var detail = item.Tag as BopsRfsInvoiceDetail;
                    if (detail != null)
                    {
                        UnapprovedBills.Add(detail);
                        Lines.Remove(detail);
                    }
                }

                RenumberLines();
                PopulateInvoiceContentListview(-1);
            }
            else
            {
                MessageHelper.ShowInvalidOperation("You must select at least one bill to unapprove.");
            }
        }

        private void ShowGroupDetailCheckbox_CheckedChanged(object sender, EventArgs e)
        {
            PopulateInvoiceContentListview(-1);
        }

        private void SwapLinesAndRepopulate(int index1, int index2, int selectedIndex)
        {
            Debug.Assert(-1 < index1 && index1 < Lines.Count);
            Debug.Assert(-1 < index2 && index2 < Lines.Count);

            var temp = Lines[index1];
            Lines[index1] = Lines[index2];
            Lines[index2] = temp;

            GroupLines();
            RenumberLines();
            PopulateInvoiceContentListview(selectedIndex);
        }

        private void MoveUpButton_Click(object sender, EventArgs e)
        {
            if (_isReadOnly) return;

            if (EditInvoiceDetailsListview.SelectedItems.Count == 1)
            {
                var item = EditInvoiceDetailsListview.SelectedItems[0];
                var detail = item.Tag as BopsRfsInvoiceDetail;
                var indexToMoveUp = -1;

                if (detail != null)
                {
                    if (!string.IsNullOrEmpty(detail.GroupName))
                    {
                        indexToMoveUp = Lines.FindIndex(delegate(BopsRfsInvoiceDetail D) { return D.GroupName == detail.GroupName; });
                        Debug.Assert(indexToMoveUp > -1);   // At least one item in the group must exist, the selection if nothing else.
                    }
                    else
                    {
                        indexToMoveUp = EditInvoiceDetailsListview.SelectedIndices[0];
                    }
                }

                if (indexToMoveUp < 1)
                {
                    MessageHelper.ShowInvalidOperation("The detail line/group is already at the top.");
                    return;
                }

                SwapLinesAndRepopulate(indexToMoveUp - 1, indexToMoveUp, indexToMoveUp - 1);
            }
            else
            {
                MessageHelper.ShowInvalidOperation("You must select a single the detail line to move up.");
            }
        }

        private void MoveDownButton_Click(object sender, EventArgs e)
        {
            if (_isReadOnly) return;

            if (EditInvoiceDetailsListview.SelectedItems.Count == 1)
            {
                var item = EditInvoiceDetailsListview.SelectedItems[0];
                var detail = item.Tag as BopsRfsInvoiceDetail;
                int indexToMoveDown = Lines.Count, newIndex = Lines.Count;

                if (detail != null)
                {
                    if (!string.IsNullOrEmpty(detail.GroupName))
                    {
                        indexToMoveDown = Lines.FindIndex(delegate(BopsRfsInvoiceDetail D) { return D.GroupName == detail.GroupName; });
                        Debug.Assert(indexToMoveDown > -1);   // At least one item in the group must exist, the selection if nothing else.

                        newIndex = Lines.FindLastIndex(delegate(BopsRfsInvoiceDetail D) { return D.GroupName == detail.GroupName; });
                        Debug.Assert(newIndex> -1);   // At least one item in the group must exist, the selection if nothing else.
                        newIndex++;
                    }
                    else
                    {
                        indexToMoveDown = EditInvoiceDetailsListview.SelectedIndices[0];
                        newIndex = indexToMoveDown + 1;
                    }
                }

                if (indexToMoveDown >= (Lines.Count - 1) || newIndex > (Lines.Count -1))
                {
                    MessageHelper.ShowInvalidOperation("The detail line/group is already at the bottom.");
                    return;
                }

                SwapLinesAndRepopulate(indexToMoveDown, newIndex, indexToMoveDown + 1);
            }
            else
            {
                MessageHelper.ShowInvalidOperation("You must select a single detail line to move down.");
            }
        }

        private void DeleteManualBillButton_Click(object sender, EventArgs e)
        {
            if (_isReadOnly) return;
            if (EditInvoiceDetailsListview.SelectedItems.Count == 1)
            {
                var item = EditInvoiceDetailsListview.SelectedItems[0];
                var detail = item.Tag as BopsRfsInvoiceDetail;

                if (detail != null)
                {
                    if (!detail.IsManualBill)
                    {
                        MessageHelper.ShowInvalidOperation("The selected line is not a manual bill.");
                    }
                    else if (EditInvoiceDetailsListview.Items.Count == 1)
                    {
                        MessageHelper.ShowInvalidOperation("An invoice cannot be empty.");
                    }
                    else
                    {
                        var confirm = MessageHelper.ShowConfirm("Are you sure you want to delete the manual bill?");
                        if (confirm != DialogResult.Yes)
                            return;

                        Lines.Remove(detail);
                        RenumberLines();
                        PopulateInvoiceContentListview(-1);
                    }
                }
            }
            else
            {
                MessageHelper.ShowInvalidOperation("You must select a single manual bill to delete.");
            }
        }

        private void OkButton_Click(object sender, EventArgs e)
        {
            DialogResult = _isReadOnly ? DialogResult.Cancel : DialogResult.OK;
            Close();
        }

        private void AddBillsButton_Click(object sender, EventArgs e)
        {
            //if (_IsReadOnly) return;

            //AddBillsToInvoiceForm NewForm = new AddBillsToInvoiceForm(_Invoice);
            //if (NewForm.ShowDialog() == DialogResult.OK)
            //{
            //    int LineNumber = 1;

            //    foreach (BillingDetails bd in NewForm.SelectedBills)
            //    {
            //        BopsRfsInvoiceDetail NewDetail = new BopsRfsInvoiceDetail();
            //        NewDetail.InvoiceRef = _Invoice.InvoiceId;

            //        NewDetail.LineNumber = NewDetail.LineNumberDisplayed = LineNumber++;
            //    }
            //}
        }

        private void EditInvoiceDetailsListview_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.A && e.Control)
            {
                EditInvoiceDetailsListview.SuspendLayout();
                foreach (ListViewItem item in EditInvoiceDetailsListview.Items)
                    item.Selected = true;
                EditInvoiceDetailsListview.ResumeLayout();
            }
        }

        private void SelectButton_Click(object sender, EventArgs e)
        {
            var newForm = new ListViewSelectTextByColumnForm(EditInvoiceDetailsListview, _lastSelectSearchText);

            if (newForm.ShowDialog() == DialogResult.OK)
            {
                _lastSelectSearchText = newForm.SearchText;
                if (newForm.MatchCount == 0)
                    MessageHelper.ShowError("No matching items found.");
            }
        }
    }
}
