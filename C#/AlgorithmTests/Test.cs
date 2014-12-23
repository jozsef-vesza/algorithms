using NUnit.Framework;
using System;
using StringArrayMatrix;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;

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

        [Test]
        public void TestWordBreak()
        {
            const string inputString = "shortlongeronelonglonglonglonglong";
            var inputDict = new HashSet<string>(){ "short", "longerone", "longlonglonglonglong" };
            const bool expectedOutput = true;

            Assert.AreEqual(expectedOutput, WordBreak.WordBreakPossble(inputString, inputDict));
        }

        [Test]
        public void TestWordLadder()
        {
            const string startString = "hit";
            const string endString = "cog";
            var inputDict = new HashSet<string>(){ "hot", "dot", "dog", "lot", "log" };
            const int expectedOperations = 5;

            Assert.AreEqual(expectedOperations, WordLadder.LadderLength(startString, endString, inputDict));
        }
    }
}

