using System;
using System.Collections.Generic;
using System.Reflection;
using NHibernate;
using NHibernate.Criterion;

namespace NHibernateUtilities
{
    /// <summary>
    /// Provides utilities to read database data.
    /// </summary>
    public class ReadUtilities
    {
        static public Dictionary<TKey, TValue> LoadObjectDictionary<TKey, TValue>(ISession NHibernateSession, string IdPropertyName, ICollection<TKey> Ids)
        {
            if (Ids.Count > 0)
            {
                int Index = 0;
                TKey[] IdArray = new TKey[Ids.Count];
                foreach (TKey Id in Ids)
                    IdArray[Index++] = Id;
                return LoadObjectDictionary<TKey, TValue>(NHibernateSession, IdPropertyName, IdArray);
            }

            return new Dictionary<TKey, TValue>();
        }

        /// <summary>
        /// Takes an array of object IDs and returns a dictionary whose keys/values are the object IDs
        /// and objects respectively. The method reads the values in "chunks" to avoid the limitations
        /// of the basic, NHibernate "In" expression.
        /// </summary>
        /// <typeparam name="TKey">The type of the key values.</typeparam>
        /// <typeparam name="TValue">The type of the objects to be read.</typeparam>
        /// <param name="NHibernateSession">The NHibernate session to use for reading the data.</param>
        /// <param name="IdPropertyName">The name of the property exposing the ID.</param>
        /// <param name="Ids">An array of the IDs of the objects to be retrieved.</param>
        /// <returns></returns>
        static public Dictionary<TKey, TValue> LoadObjectDictionary<TKey, TValue>(ISession NHibernateSession, string IdPropertyName, TKey[] Ids)
        {
            const int MaxValuesForInQuery = 300;    // Specifies the maximum size of each chunk of data to read.

            // If we got passed a null array, then just return an empty dictionary.

            Dictionary<TKey, TValue> ReturnValue = new Dictionary<TKey, TValue>();
            if (Ids == null)
                return ReturnValue;

            int DocumentIndex = 0;
            int DocumentsLeft = Ids.Length;

            while (DocumentsLeft > 0)
            {
                // Figure out how many objects to read, up to the maximum chunk size. Then allocate an array
                // of the proper size and fill it up with IDs.

                int ArraySize = Math.Min(DocumentsLeft, MaxValuesForInQuery);
                TKey[] ChunkIds = new TKey[ArraySize];

                for (int I = 0; I < ArraySize; I++)
                {
                    ChunkIds[I] = Ids[DocumentIndex++];
                    DocumentsLeft--;
                }

                // Fetch the current chunk of data and add the resulting key/value pairs to the return value.

                IList<TValue> Chunk = NHibernateSession.CreateCriteria(typeof(TValue))
                    .Add(Expression.In(IdPropertyName, ChunkIds))
                    .List<TValue>();

                foreach (TValue Value in Chunk)
                {
                    Type ObjectType = Value.GetType();
                    PropertyInfo Info = ObjectType.GetProperty(IdPropertyName);
                    ReturnValue.Add((TKey)Info.GetValue(Value, null), Value);
                }
            }

            return ReturnValue;
        }

        static public IList<TValue> LoadObjectList<TKey, TValue>(ISession NHibernateSession, string IdPropertyName, ICollection<TKey> Ids)
        {
            if (Ids.Count > 0)
            {
                int Index = 0;
                TKey[] IdArray = new TKey[Ids.Count];
                foreach (TKey Id in Ids)
                    IdArray[Index++] = Id;
                return LoadObjectList<TKey, TValue>(NHibernateSession, IdPropertyName, IdArray);
            }

            return new List<TValue>();
        }

        static public IList<TValue> LoadObjectList<TKey, TValue>(ISession NHibernateSession, string IdPropertyName, TKey[] Ids)
        {
            const int MaxValuesForInQuery = 300;    // Specifies the maximum size of each chunk of data to read.

            // If we got passed a null array, then just return an empty list.

            List<TValue> ReturnValue = new List<TValue>();
            if (Ids == null)
                return ReturnValue;

            int DocumentIndex = 0;
            int DocumentsLeft = Ids.Length;

            while (DocumentsLeft > 0)
            {
                // Figure out how many objects to read, up to the maximum chunk size. Then allocate an array
                // of the proper size and fill it up with IDs.

                int ArraySize = Math.Min(DocumentsLeft, MaxValuesForInQuery);
                TKey[] ChunkIds = new TKey[ArraySize];

                for (int I = 0; I < ArraySize; I++)
                {
                    ChunkIds[I] = Ids[DocumentIndex++];
                    DocumentsLeft--;
                }

                // Fetch the current chunk of data and add the resulting key/value pairs to the return value.

                IList<TValue> Chunk = NHibernateSession.CreateCriteria(typeof(TValue))
                    .Add(Expression.In(IdPropertyName, ChunkIds))
                    .List<TValue>();

                ReturnValue.AddRange(Chunk);
            }

            return ReturnValue;
        }
    }
}
