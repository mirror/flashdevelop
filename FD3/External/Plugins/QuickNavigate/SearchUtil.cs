using System;
using System.Text;
using System.Collections.Generic;

namespace QuickNavigate
{
    class SearchUtil
    {
        public delegate Boolean Comparer(String value1, String value2, String value3);

        public static List<String> getMatchedItems(List<String> source, String searchText, String pathSeparator, Int32 limit)
        {
            Int32 i = 0;
            List<String> matchedItems = new List<String>();
            Comparer searchMatch = (searchText.ToUpper() == searchText) ? new Comparer(AdvancedSearchMatch) : new Comparer(SimpleSearchMatch);
            foreach (String item in source)
            {
                if (searchMatch(item, searchText, pathSeparator))
                {
                    matchedItems.Add(item);
                    if (limit > 0 && i++ > limit) break;
                }
            }
            return matchedItems;
        }

        private static Boolean AdvancedSearchMatch(String file, String searchText, String pathSeparator)
        {
            String fileName = "";
            for (Int32 i = file.LastIndexOf(pathSeparator) + 1; i < file.Length; i++)
            {
                if (Char.IsUpper(file, i)) fileName += file.Substring(i, 1).ToLower();
            }
            return fileName.IndexOf(searchText.ToLower()) == 0;
        }

        private static Boolean SimpleSearchMatch(String file, String searchText, String pathSeparator)
        {
            String fileName = file.Substring(file.LastIndexOf(pathSeparator) + 1).ToLower();
            return fileName.IndexOf(searchText.ToLower()) > -1;
        }

    }

}
