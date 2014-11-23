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

            bst.Delete(4);

            bst.PreorderTraverse(Console.WriteLine);
            bst.InorderTraverse(Console.WriteLine);
            bst.PostorderTraverse(Console.WriteLine);

            Console.WriteLine("Min: {0}, max: {1}, size: {2}", bst.Min(), bst.Max(), bst.Size());
        }
    }
}