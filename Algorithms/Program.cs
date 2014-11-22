using System;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

namespace Algorithms
{
    public class MainClass
    {
        public static void Main(string[] args)
        {
            #region Binary Tree
            var btree = new BinaryTree<int>();
            btree.Root = new BinaryTreeNode<int>(1);
            btree.Root.Left = new BinaryTreeNode<int>(2);
            btree.Root.Right = new BinaryTreeNode<int>(3);

            btree.Root.Left.Left = new BinaryTreeNode<int>(4);
            btree.Root.Right.Right = new BinaryTreeNode<int>(5);

            btree.Root.Left.Left.Right = new BinaryTreeNode<int>(6);
            btree.Root.Right.Right.Right = new BinaryTreeNode<int>(7);

            btree.Root.Right.Right.Right.Right = new BinaryTreeNode<int>(8);
            #endregion

            #region Binary Search Tree Setup

            var bst = new BinarySearchTree<int>();
            bst.Add(4);
            bst.Add(2);
            bst.Add(3);
            bst.Add(12);
            bst.Add(8);
            bst.Add(5);
            bst.Remove(2);

            var strTree = new BinarySearchTree<string>();
            strTree.Add("R");
            strTree.Add("A");
            strTree.Add("W");

            var pst = new BinarySearchTree<Person>();
            pst.Add(new Person("Firestorm", 30));
            pst.Add(new Person("Plastique", 23));
            pst.Add(new Person("Grundy", 99));
            pst.Add(new Person("Big Barda", 43));

            #endregion

            #region BST Operations

            bst.InorderTraverse(p => Console.WriteLine(p.Value));
            bst.Contains(3, n =>
                bst.Remove(n));
            bst.InorderTraverse(p => Console.WriteLine(p.Value));

            Console.WriteLine("Min: {0}, max: {1}, size: {2}", bst.Min(), bst.Max(), bst.Size());

            Console.WriteLine("Saving tree...");

            var outFileStream = File.Create("nodes");
            var serializer = new BinaryFormatter();
            serializer.Serialize(outFileStream, bst);
            outFileStream.Close();

            Console.WriteLine("Tree saved!");

            Console.WriteLine("Loading tree...");

            if (File.Exists("nodes"))
            {
                var inFileStream = File.OpenRead("nodes");
                var deserializer = new BinaryFormatter();
                bst = (BinarySearchTree<int>)deserializer.Deserialize(inFileStream);
                inFileStream.Close();
                Console.WriteLine("Tree loaded!");
            }

            bst.InorderTraverse(p => Console.WriteLine(p.Value));
            Console.WriteLine("Min: {0}, max: {1}, size: {2}", bst.Min(), bst.Max(), bst.Size());

            pst.InorderTraverse(p => Console.WriteLine(p.Value.Name));
            Console.WriteLine("Min: {0}, max: {1}, size: {2}", pst.Min().Name, pst.Max().Name, pst.Size());

            #endregion
        }
    }
}
