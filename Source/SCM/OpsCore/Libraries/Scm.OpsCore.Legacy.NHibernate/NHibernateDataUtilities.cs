using System;
using System.Collections.Generic;
using NHibernate;
using NHibernate.Criterion;

namespace Scm.OpsCore.Legacy.NHibernate
{
    public class NHibernateDataUtilities
    {
        /// <summary>
        /// Generic method to get objects from an array of their unique IDs, "chunking" the data as needed
        /// to avoid hitting the row limits.
        /// </summary>
        /// <typeparam name="TObj">The type of the objects.</typeparam>
        /// <typeparam name="TId">The type of the IDs.</typeparam>
        /// <param name="session">The NHibernate session from which to fetch the objects.</param>
        /// <param name="ids">The array of IDs whose objects should be retrieved.</param>
        /// <param name="propertyName">The name of the object's ID property.</param>
        /// <param name="otherCriteria">A list of other NHibernate criteria for filtering incoming data.</param>
        /// <returns>A list of objects if successful, or an empty list otherwise.</returns>
        public static IList<TObj> GetObjectsByIds<TObj, TId>(ISession session, TId[] ids, string propertyName,
            List<ICriterion> otherCriteria)
        {
            const int maxValuesForInQuery = 300;    // Specifies the maximum size of each chunk of data to read.

            // If we got passed a null array, then just return an empty list.

            var returnValue = new List<TObj>();
            if (ids == null)
                return returnValue;

            var inputIndex = 0;
            var numberRemaining = ids.Length;

            while (numberRemaining > 0)
            {
                // Figure out how many objects to read, up to the maximum chunk size. Then allocate an array
                // of the proper size and fill it up with IDs.

                var arraySize = Math.Min(numberRemaining, maxValuesForInQuery);
                var chunkIds = new TId[arraySize];

                for (var i = 0; i < arraySize; i++)
                {
                    chunkIds[i] = ids[inputIndex++];
                    numberRemaining--;
                }

                // Fetch the current chunk of data and add the resulting key/value pairs to the return value.

                var chunk = session.CreateCriteria(typeof(TObj))
                    .Add(Restrictions.In(propertyName, chunkIds));

                if (otherCriteria != null)
                    foreach (var criterion in otherCriteria)
                        chunk.Add(criterion);

                returnValue.AddRange(chunk.List<TObj>());
            }

            return returnValue;
        }
    }
}
