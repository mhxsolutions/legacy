using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Text;
using log4net;

namespace BopsUtilities
{
    public class EmailDistributionListManager
    {
        public enum SendResult
        {
            None,
            MessageSent,
            ListNotFound,
            ListInCooldown
        }

        private static readonly ILog Log = LogManager.GetLogger(typeof(EmailDistributionListManager));

        private readonly Dictionary<string, EmailDistributionList> _lists;

        public EmailDistributionListManager()
        {
            _lists = new Dictionary<string, EmailDistributionList>();
        }

        public void AddList(string listName, NameValueCollection details)
        {
            var b = new StringBuilder();
            b.AppendFormat("Email distribution list {0} created:", listName);
            var newList = new EmailDistributionList();

            foreach (var key in details.AllKeys)
            {
                var hideValue = false;

                switch (key)
                {
                    case "SmtpServer":
                        newList.SmtpServer = details[key];
                        break;
                    case "SmtpUserId":
                        newList.SmtpUserId = details[key];
                        break;
                    case "SmtpUserPassword":
                        newList.SmtpUserPassword = details[key];
                        hideValue = true;
                        break;
                    case "From":
                        newList.From = details[key];
                        break;
                    case "To":
                        newList.To = details[key];
                        break;
                    case "CC":
                        newList.Cc = details[key];
                        break;
                    case "Cooldown":
                        var cooldown = Convert.ToInt32(details[key]);
                        newList.Cooldown = cooldown;
                        break;
                    case "EnableSsl":
                        var enableSsl = Convert.ToBoolean(details[key]);
                        newList.EnableSsl = enableSsl;
                        break;
                }

                b.AppendFormat(" {0} = '{1}'", key, hideValue ? "*****" : details[key]);
            }

            _lists.Add(listName, newList);
            Log.InfoFormat(b.ToString());
        }

        public EmailDistributionList GetList(string listName)
        {
            return _lists.ContainsKey(listName) ? _lists[listName] : null;
        }

        public SendResult SendMessage(string listName, string subject, string body)
        {
            SendResult returnValue;

            if (_lists.ContainsKey(listName))
            {
                if (_lists[listName].SendMessage(subject, body))
                {
                    Log.InfoFormat("Message sent to {0} list, subject '{1}', body '{2}'", listName, subject, body);
                    returnValue = SendResult.MessageSent;
                }
                else
                {
                    Log.InfoFormat("List {0} cooling down, message not sent: subject '{1}', body '{2}'", listName, subject, body);
                    returnValue = SendResult.ListInCooldown;
                }
            }
            else
            {
                Log.WarnFormat("Email distribution {0} list does not exist for message subject '{1}' body '{2}'", listName, subject, body);
                returnValue = SendResult.ListNotFound;
            }

            return returnValue;
        }
    }
}
