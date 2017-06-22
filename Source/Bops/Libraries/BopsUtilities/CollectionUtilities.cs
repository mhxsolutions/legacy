using System.Collections.Generic;

namespace BopsUtilities
{
    /// <summary>
    /// Provides utility functions for dealing with generic collections.
    /// </summary>
    public class CollectionUtilities
    {
        /// <summary>
        /// Returns an array of type T with the objects from the list.
        /// </summary>
        /// <typeparam name="T">The type of the objects contained by the list and to be contained by the array.</typeparam>
        /// <param name="Input">The list of items to be converted.</param>
        /// <returns>An array containing the objects from the list.</returns>
        public static T[] GetArray<T>(List<T> Input)
        {
            if (Input.Count < 1) return null;
            T[] ReturnValue = new T[Input.Count];
            int Index = 0;
            foreach (T Item in Input)
                ReturnValue[Index++] = Item;
            return ReturnValue;
        }

        /// <summary>
        /// Returns an array of the objects that serve as keys for the dictionary.
        /// </summary>
        /// <typeparam name="TKeyType">The key type of the dictionary.</typeparam>
        /// <typeparam name="TValueType">The value type of the dictionary.</typeparam>
        /// <param name="InputDictionary">The input dictionary whose keys should compose the array.</param>
        /// <returns>The array of keys if the dictionary has any entries or null otherwise.</returns>
        public static TKeyType[] GetArrayFromKeys<TKeyType, TValueType>(Dictionary<TKeyType, TValueType> InputDictionary)
        {
            // No items in the dictionary means a null return value.
            if (InputDictionary.Count < 1) return null;

            // Otherwise we simply run the dictionary and stuff all the keys we find into an array
            int Index = 0;
            TKeyType[] Keys = new TKeyType[InputDictionary.Count];
            foreach (KeyValuePair<TKeyType, TValueType> Pair in InputDictionary)
                Keys[Index++] = Pair.Key;
            return Keys;
        }
    }
}
