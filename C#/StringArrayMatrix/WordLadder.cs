using System;
using System.Collections.Generic;

namespace StringArrayMatrix
{
    public static class WordLadder
    {
        public static int LadderLength(string start, string end, HashSet<string> dictionary)
        {
            if (dictionary.Count == 0)
            {
                return 0;
            }

            var wordQueue = new Queue<string>();
            var distanceQueue = new Queue<int>();

            wordQueue.Enqueue(start);
            distanceQueue.Enqueue(1);

            while (wordQueue.Count > 0)
            {
                var currentWord = wordQueue.Dequeue();
                var currentDistance = distanceQueue.Dequeue();

                if (currentWord == end)
                {
                    return currentDistance;
                }

                for (int i = 0; i < currentWord.Length; i++)
                {
                    var characters = currentWord.ToCharArray();
                    for (var c = 'a'; c < 'z'; c++)
                    {
                        characters[i] = c;

                        var newWord = new string(characters);

                        if (newWord == end)
                        {
                            return currentDistance + 1;
                        }

                        if (dictionary.Contains(newWord))
                        {
                            wordQueue.Enqueue(newWord);
                            distanceQueue.Enqueue(currentDistance + 1);
                            dictionary.Remove(newWord);
                        }
                    }
                }
            }

            return 0;
        }
    }
}

