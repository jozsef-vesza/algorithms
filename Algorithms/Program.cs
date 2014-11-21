using System;

namespace Algorithms
{
    public class MainClass
    {
        public static void Main(string[] args)
        {
            var btree = new BinaryTree<int>();
            btree._root = new BinaryTreeNode<int>(1);
            btree._root.Left = new BinaryTreeNode<int>(2);
            btree._root.Right = new BinaryTreeNode<int>(3);

            btree._root.Left.Left = new BinaryTreeNode<int>(4);
            btree._root.Right.Right = new BinaryTreeNode<int>(5);

            btree._root.Left.Left.Right = new BinaryTreeNode<int>(6);
            btree._root.Right.Right.Right = new BinaryTreeNode<int>(7);

            btree._root.Right.Right.Right.Right = new BinaryTreeNode<int>(8);

            var bst = new BinarySearchTree<int>();
            bst.Add(4);
            bst.Add(2);
            bst.Add(3);

            bst.Remove(2);
        }
    }
}
