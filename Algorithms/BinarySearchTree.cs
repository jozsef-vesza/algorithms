using System;
using System.Collections.Generic;

namespace Algorithms
{
    public class BinarySearchTree<T> : BinaryTree<T>
    {
        private IComparer<T> _comparer;

        private BinaryTreeNode<T> _root { get; set; }

        public BinarySearchTree()
            : base()
        {
            _comparer = Comparer<T>.Default;
        }

        public bool Contains(T data)
        {
            var current = _root;
            int result;

            while (current != null)
            {

                result = _comparer.Compare(current.Value, data);
                if (result == 0)
                {
                    // we have found data
                    return true;
                }
                else if (result > 0)
                {
                    // current.Value > data, search current's left subtree
                    current = current.Left;
                }
                else if (result < 0)
                {
                    // current.Value < data, search current's right subtree
                    current = current.Right;
                }
            }

            return false;
        }

        public virtual void Add(T data)
        {
            // create a new Node
            var n = new BinaryTreeNode<T>(data);
            int result;

            // insert n into the tree
            // trace down the tree until we hit null
            var current = _root;
            BinaryTreeNode<T> parent = null;
            while (current != null)
            {
                result = _comparer.Compare(current.Value, data);
                if (result == 0)
                {
                    // they are equal => attempting to add duplicate => do nothing
                    return;
                }
                else if (result > 0)
                {
                    // current.Value > data, must add n to current's left subtree
                    parent = current;
                    current = current.Left;
                }
                else if (result < 0)
                {
                    // current.Value < data, must add n to current's right subtree
                    parent = current;
                    current = current.Right;
                }
            }

            // ready to add the node
            if (parent == null)
            {
                // the tree was empty => make n the root
                _root = n;
            }
            else
            {
                result = _comparer.Compare(parent.Value, data);
                if (result > 0)
                {
                    // parent.Value > data, n must be added to the left subtree
                    parent.Left = n;
                }
                else
                {
                    // parent.Value < data, n must be added to the right subtree
                    parent.Right = n;
                }
            }
        }

        public bool Remove(T data)
        {

            return true;
        }
    }
}

