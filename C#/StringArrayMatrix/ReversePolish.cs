using System;
using System.Collections.Generic;
using System.Linq;

namespace StringArrayMatrix
{
    public static class ReversePolish
    {
        private const string operations = "+-*/";

        public static int Calculate(string[] input)
        {
            var stack = new Stack<String>();
            int result = 0;
            foreach (var val in input)
            {
                if (!operations.Contains(val))
                {
                    stack.Push(val);
                }
                else
                {
                    var val2 = int.Parse(stack.Pop());
                    var val1 = int.Parse(stack.Pop());
                    switch (val)
                    {
                        case "+":
                            stack.Push((val1 + val2).ToString());
                            break;
                        case "-":
                            stack.Push((val1 - val2).ToString());
                            break;
                        case "*":
                            stack.Push((val1 * val2).ToString());
                            break;
                        case "/":
                            stack.Push((val1 / val2).ToString());
                            break;

                    }
                }
            }

            result = int.Parse(stack.Pop());
            return result;
        }
    }
}

