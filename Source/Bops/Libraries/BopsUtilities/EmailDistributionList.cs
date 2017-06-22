using System;
using System.Net;
using System.Net.Mail;

namespace BopsUtilities
{
    public class EmailDistributionList
    {
        private DateTime _lastMessageTime;
        public string SmtpServer { get; set; }
        public string SmtpUserId { get; set; }
        public string SmtpUserPassword { get; set; }
        public string From { get; set; }
        public string To { get; set; }
        public string Cc { get; set; }
        public int Cooldown { get; set; }
        public bool EnableSsl { get; set; }

        public EmailDistributionList()
        {
            SmtpServer = SmtpUserId = SmtpUserPassword = From = To = Cc = string.Empty;

            // No matter what the cooldown is set to, the following guarantees that the
            // cooldown is effectively elapsed from the outset.

            _lastMessageTime = DateTime.MinValue;
        }

        public void ForceCooldown()
        {
            _lastMessageTime = DateTime.Now;
        }

        public bool SendMessage(string subject, string body)
        {
            if (SmtpServer == string.Empty)
                throw new InvalidOperationException("EmailDistributionList has no SMTP server");
            if (From == string.Empty)
                throw new InvalidOperationException("EmailDistributionList has no from address");
            if (To == string.Empty)
                throw new InvalidOperationException("EmailDistributionList has no to address");
            if (string.IsNullOrEmpty(subject))
                throw new ArgumentException("EmailDistributionList.SendMessage invalid subject", "subject");

            var intervalSinceLastEmail = DateTime.Now - _lastMessageTime;

            if (!(intervalSinceLastEmail.TotalMilliseconds > Cooldown)) return false;

            var message = new MailMessage(From, To, subject, body) {IsBodyHtml = false};
            if (Cc != string.Empty)
                message.CC.Add(Cc);

            var client = new SmtpClient(SmtpServer) {EnableSsl = EnableSsl};
            if (SmtpUserId != string.Empty && SmtpUserPassword != string.Empty)
            {
                client.UseDefaultCredentials = false;
                client.Credentials = new NetworkCredential(SmtpUserId, SmtpUserPassword);
            }

            client.Send(message);
            ForceCooldown();
            return true;
        }
    }
}
