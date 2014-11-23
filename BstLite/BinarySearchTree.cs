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

        public bool Delete(T valueToDelete)
        {
            if (_root == null)
            {
                // empty tree: the value is not in there
                return false;
            }

            var current = _root;
            BinaryNode<T> parent = null;
            int comparisonResult = _comparer.Compare(current.Value, valueToDelete);

            // 1.: search for the value
            while (comparisonResult != 0)
            {
                if (comparisonResult > 0)
                {
                    // continue the search in the left subtree
                    parent = current;
                    current = current.Left;
                }
                else if (comparisonResult < 0)
                {
                    // continue the search in the right subtree
                    parent = current;
                    current = current.Right;
                }

                comparisonResult = _comparer.Compare(current.Value, valueToDelete);
            }

            if (current == null)
            {
                // we didn't find the item to delete
                return false;
            }

            // 2.: delete the item
            // 2.1.: the item has no right child 
            // => left child can replace it
            if (current.Right == null)
            {
                // if there is no parent, we are about to delete the root
                if (parent == null)
                {
                    _root = current.Left;
                }
                else
                {
                    comparisonResult = _comparer.Compare(parent.Value, current.Value);
                    if (comparisonResult > 0)
                    {
                        // the left child should go in parent's left subtree
                        parent.Left = current.Left;
                    }
                    else if (comparisonResult < 0)
                    {
                        // the left child should go in the parent's right subtree
                        parent.Right = current.Left;
                    }
                }
            }

            // 2.2.: the item's right child has no left child 
            // => right child can replace it
            else if (current.Right.Left == null)
            {
                // if there is no parent, we are about to delete the root
                if (parent == null)
                {
                    _root = current.Right;
                }
                else
                {
                    comparisonResult = _comparer.Compare(parent.Value, current.Value);
                    if (comparisonResult > 0)
                    {
                        // the right child should go in the parent's left subtree
                        parent.Left = current.Right;
                    }
                    else if (comparisonResult < 0)
                    {
                        // the right child should go in the parent's right subtree
                        parent.Right = current.Right;
                    }
                }
            }

            // 2.3.: the item's right child has a left child 
            // => we search for its leftmost child to replace the item
            else
            {
                var leftmost = current.Right.Left;
                BinaryNode<T> lmParent = current.Right;

                while (leftmost.Left != null)
                {
                    lmParent = leftmost;
                    leftmost = leftmost.Left;
                }

                // right subtree of leftmost will go in its parent's left subtree
                lmParent.Left = leftmost.Right;

                // replace current with leftmost
                leftmost.Left = current.Left;
                leftmost.Right = current.Right;

                if (parent == null)
                {
                    _root = leftmost;
                }
                else
                {
                    comparisonResult = _comparer.Compare(parent.Value, leftmost.Value);
                    if (comparisonResult > 0)
                    {
                        // leftmost will go in parent's left subtree
                        parent.Left = leftmost;
                    }
                    else if (comparisonResult < 0)
                    {
                        // leftmost will go in parent's right subtree
                        parent.Right = leftmost;
                    }
                }
            }

            return true;
        }
    }
}