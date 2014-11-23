using System;

namespace BstLite
{
    public class MainClass
    {
        public static void Main(string[] args)
        {
            var bst = new BinarySearchTree<int>();
            bst.Insert(4);
            bst.Insert(2);
            bst.Insert(3);
            bst.Insert(12);
            bst.Insert(8);
            bst.Insert(5);

            var containsFive = bst.Contains(5, Console.WriteLine);
            bst.Delete(4);
        }
    }
}