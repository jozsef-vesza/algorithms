using System;

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

            #region Binary Search Tree
            var bst = new BinarySearchTree<int>();
            bst.Add(4);
            bst.Add(2);
            bst.Add(3);
            bst.Remove(2);

            var strTree = new BinarySearchTree<string>();
            strTree.Add("R");
            strTree.Add("A");
            strTree.Add("W");
            #endregion

            bst.InorderTraverseFromRoot(p => Console.WriteLine(p.Value));
            bst.Contains(3, n =>
                bst.Remove(n));
            bst.InorderTraverseFromRoot(p => Console.WriteLine(p.Value));
        }
    }
}
