using System;
using System.Collections.Generic;
using NHibernate;
using NHibernate.Cfg;

namespace NHibernateUtilities
{
    public class SessionManager<T>
    {
        private class SessionDetails
        {
            #region Fields

            private string _ConfigurationFileName;
            private ISession _Session;
            private ITransaction _Transaction;

            #endregion

            #region Properties

            public ISession Session
            {
                get { return _Session; }
            }

            public string ConfigurationFileName
            {
                get { return _ConfigurationFileName; }
            }

            public ITransaction Transaction
            {
                get { return _Transaction; }
            }

            public bool IsInTransaction
            {
                get { return _Transaction != null; }
            }

            #endregion

            public SessionDetails(string _ConfigurationFileName)
            {
                ISessionFactory SessionFactory = new Configuration()
                    .Configure(_ConfigurationFileName)
                    .BuildSessionFactory();

                _Session = SessionFactory.OpenSession();
                this._ConfigurationFileName = _ConfigurationFileName;
                _Transaction = null;

                SessionFactory.Close();
            }

            public void CloseSession(bool Commit)
            {
                if (_Transaction != null)
                    EndTransaction(Commit);
                _Session.Close();
                _Session = null;
            }

            public ITransaction BeginTransaction()
            {
                if (_Transaction != null)
                    throw new InvalidOperationException("Transaction already in progress");
                _Transaction = _Session.BeginTransaction();
                return _Transaction;
            }

            public void EndTransaction(bool Commit)
            {
                if (_Transaction == null)
                    throw new InvalidOperationException("No current transaction");
                if (Commit)
                    _Transaction.Commit();
                else
                    _Transaction.Rollback();
                _Transaction = null;
            }
        }

        private Dictionary<T, SessionDetails> _Sessions;

        public bool HasSession(T ID)
        {
            return _Sessions.ContainsKey(ID);
        }

        public ISession this[T ID]
        {
            get { return _Sessions[ID].Session; }
        }

        public SessionManager()
        {
            _Sessions = new Dictionary<T, SessionDetails>();
        }

        public ISession AddSession(T ID, string ConfigurationFileName)
        {
            SessionDetails NewSession = new SessionDetails(ConfigurationFileName);
            _Sessions.Add(ID, NewSession);
            return NewSession.Session;
        }

        public void CloseSession(T ID, bool Commit)
        {
            SessionDetails DoomedSession = _Sessions[ID];
            DoomedSession.CloseSession(Commit);
        }

        public void CloseAllSessions(bool Commit)
        {
            foreach (KeyValuePair<T, SessionDetails> pair in _Sessions)
            {
                pair.Value.CloseSession(Commit);
            }
        }

        public void RemoveSession(T ID, bool Commit)
        {
            CloseSession(ID, Commit);
            _Sessions.Remove(ID);
        }

        public void RemoveAllSessions(bool Commit)
        {
            CloseAllSessions(Commit);
            _Sessions.Clear();
        }

        public ITransaction BeginTransaction(T ID)
        {
            return _Sessions[ID].BeginTransaction();
        }

        public void EndTransaction(T ID, bool Commit)
        {
            _Sessions[ID].EndTransaction(Commit);
        }
    }
}
