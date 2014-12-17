using System;
using System.Collections.Generic;
using System.IO.MemoryMappedFiles;

namespace StringArrayMatrix
{
    public static class WordBreak
    {
        public static bool WordBreakPossble(string input, ICollection<string> dictionary)
        {
            return WordBreakHelper(input, dictionary, 0);
        }

        private static bool WordBreakHelper(string input, ICollection<string> dictionary, int start)
        {
            var memo = new HashSet<int>();

            if (dictionary.Contains(input.Substring(start)))
            {
                return true;
            }

            if (memo.Contains(start))
            {
                return false;
            }

            for (int i = 0; i < input.Length; i++)
            {
                if (dictionary.Contains(input.Substring(start, i + 1)))
                {
                    if (WordBreakHelper(input, dictionary, start + i + 1))
                    {
                        return true;
                    }
                }
            }

            memo.Add(start);
            return false;
        }
    }
}