using System.Windows.Forms;

namespace BopsUtilities
{
    public class MessageHelper
    {
        public static void ShowInvalidOperation(string Message)
        {
            MessageBox.Show(Message, "Invalid Operation", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
        }

        public static void ShowWarning(string WarningMessage)
        {
            MessageBox.Show(WarningMessage, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        public static void ShowError(string ErrorMessage)
        {
            MessageBox.Show(ErrorMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
        }

        public static void ShowSecurityError(string ErrorMessage)
        {
            MessageBox.Show(ErrorMessage, "Insufficient Permissions", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
        }

        public static DialogResult ShowConfirm(string YesOrNoQuestion)
        {
            DialogResult ReturnValue = MessageBox.Show(YesOrNoQuestion, "Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            return ReturnValue;
        }

        public static void ShowSuccess(string Message)
        {
            MessageBox.Show(Message, "Success", MessageBoxButtons.OK);
        }
    }
}
