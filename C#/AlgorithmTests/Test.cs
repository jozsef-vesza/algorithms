using NUnit.Framework;
using System;
using StringArrayMatrix;
using System.Collections.Generic;
using System.IO;

namespace AlgorithmTests
{
    [TestFixture]
    public class Test
    {
        List<List<string>> reversePolishInputs;
        List<int> reversePolishOutputs;
        List<string> palindromicInputs;
        List<string> palindromicOutputs;

        [SetUp]
        public void SetUpReversePolish()
        {
            reversePolishInputs = new List<List<string>>();
            reversePolishOutputs = new List<int>();

            var path = Path.Combine(Environment.CurrentDirectory, "TestData/StringArrayMatrix");
            foreach (var file in Directory.GetFiles(path))
            {
                if (file.Contains("reversePolishInput"))
                {
                    reversePolishInputs.Add(new List<string>(File.ReadAllLines(file)));    
                }
                else if (file.Contains("reversePolishOutput"))
                {
                    reversePolishOutputs.Add(int.Parse((File.ReadAllText(file))));
                }
            }

            var palindromicPath = Path.Combine(Environment.CurrentDirectory, "TestData/PalindromicSubstring");
            foreach (var file in Directory.GetFiles(palindromicPath))
            {
                if (file.Contains("Input"))
                {
                    palindromicInputs = new List<string>(File.ReadAllLines(file));
                }
                else
                {
                    palindromicOutputs = new List<string>(File.ReadAllLines(file));
                }
            }

        }

        [Test]
        public void TestReversePolish()
        {
            for (int i = 0; i < reversePolishInputs.Count; i++)
            {
                var input = reversePolishInputs[i];
                var output = reversePolishOutputs[i];
                Assert.AreEqual(output, ReversePolish.Calculate(input.ToArray()));
            }
        }

        [Test]
        public void TestPalindromicSubstring()
        {
            for (int i = 0; i < palindromicInputs.Count; i++)
            {
                StringAssert.AreEqualIgnoringCase(palindromicOutputs[i], PalindromicSubstring.LongestPalindrome(palindromicInputs[i]));
            }
        }
    }
}

