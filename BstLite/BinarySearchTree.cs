using System;
using System.Collections.Generic;

namespace BstLite
{
    public class BinarySearchTree<T>
    {
        private BinaryNode<T> _root;
        private IComparer<T> _comparer;

        public BinarySearchTree()
        {
            _root = null;
            _comparer = Comparer<T>.Default;
        }

        public void Add(T data)
        {
            var newNode = new BinaryNode<T>(data);

            var current = _root;
            BinaryNode<T> parent = null;
            int comparisonResult;

            while (current != null)
            {
                comparisonResult = _comparer.Compare(current.Value, data);
                if (comparisonResult == 0)
                {
                    // duplicate entry
                    return;
                }
                else if (comparisonResult > 0)
                {
                    // goes to the left subtree
                    parent = current;
                    current = current.Left;
                }
                else if (comparisonResult < 0)
                {
                    // goes to the right subtree
                    parent = current;
                    current = current.Right;
                }
            }

            if (parent == null)
            {
                _root = newNode;
            }
            else
            {

                comparisonResult = _comparer.Compare(parent.Value, data);
                if (comparisonResult > 0)
                {
                    // will be the left child of current
                    parent.Left = newNode;
                }
                else if (comparisonResult < 0)
                {
                    // will be the right child of current
                    parent.Right = newNode;
                }
            }
        }
    }
}