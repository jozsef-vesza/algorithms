using System;
using System.Diagnostics;

namespace StringArrayMatrix
{
    public static class PalindromicSubstring
    {
        public static string LongestPalindrome(string input)
        {
            if (String.IsNullOrEmpty(input))
            {
                return null;
            }

            if (input.Length == 1)
            {
                return input;
            }

            var longest = input.Substring(0, 1);

            for (int i = 0; i < input.Length; i++)
            {
                var temp = PalindromeHelper(input, i, i);

                if (temp.Length > longest.Length)
                {
                    longest = temp;
                }

                temp = PalindromeHelper(input, i, i + 1);

                if (temp.Length > longest.Length)
                {
                    longest = temp;
                }
            }

            return longest;
        }

        public static string PalindromeHelper(string input, int toFront, int toEnd)
        {
            while (toFront >= 0 && toEnd <= input.Length - 1 && input[toFront] == input[toEnd])
            {
                toFront--;
                toEnd++;
            }

            var firstChar = toFront + 1;
            var lastChar = toEnd - 1;

            return input.Substring(firstChar, lastChar - firstChar + 1);
        }
    }
}

