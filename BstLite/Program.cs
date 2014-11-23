using System;

namespace BstLite
{
    public class MainClass
    {
        public static void Main(string[] args)
        {
            var bst = new BinarySearchTree<int>();
            bst.Add(4);
            bst.Add(2);
            bst.Add(3);
            bst.Add(12);
            bst.Add(8);
            bst.Add(5);
        }
    }
}