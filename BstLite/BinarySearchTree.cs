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

        public void Insert(T newValue)
        {
            var newNode = new BinaryNode<T>(newValue);

            var current = _root;
            BinaryNode<T> parent = null;
            int comparisonResult;

            while (current != null)
            {
                comparisonResult = _comparer.Compare(current.Value, newValue);
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

                comparisonResult = _comparer.Compare(parent.Value, newValue);
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

        public bool Contains(T soughtValue)
        {
            return Contains(soughtValue, null);
        }

        public bool Contains(T soughtValue, Action<T> action)
        {
            if (_root == null)
            {
                // tree is empty
                return false;
            }

            var current = _root;
            int comparisonResult;

            while (current != null)
            {
                comparisonResult = _comparer.Compare(current.Value, soughtValue);
                if (comparisonResult == 0)
                {
                    // we have found the value
                    if (action != null)
                    {
                        action(soughtValue);
                    }
                    return true;
                }
                else if (comparisonResult > 0)
                {
                    // the sought value is in the left subtree
                    current = current.Left;
                }
                else if (comparisonResult < 0)
                {
                    // the sought value is in the right subtree
                    current = current.Right;
                }
            }

            return false;
        }
    }
}