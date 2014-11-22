using System;
using System.Collections.Generic;

namespace Algorithms
{
    public class BinarySearchTree<T>
    {
        #region Properties and Setup

        private IComparer<T> _comparer { get; set; }

        private BinaryTreeNode<T> _root { get; set; }

        private int _count { get; set; }

        public BinarySearchTree()
        {
            _comparer = Comparer<T>.Default;
        }

        #endregion

        #region Traversal

        public void PreorderTraverse(Action<BinaryTreeNode<T>> execute)
        {
            if (_root != null)
            {
                PreorderTraverse(_root, execute);
            }
        }

        public void PreorderTraverse(BinaryTreeNode<T> current, Action<BinaryTreeNode<T>> execute)
        {
            if (current != null)
            {
                // execute command on the current node
                execute(current);

                // recursively print the left and right children
                PreorderTraverse(current.Left, execute);
                PreorderTraverse(current.Right, execute);
            }
        }

        public void InorderTraverse(Action<BinaryTreeNode<T>> execute)
        {
            if (_root != null)
            {
                InorderTraverse(_root, execute);
            }
        }

        public void InorderTraverse(BinaryTreeNode<T> current, Action<BinaryTreeNode<T>> execute)
        {
            if (current != null)
            {
                InorderTraverse(current.Left, execute);
                execute(current);
                InorderTraverse(current.Right, execute);
            }
        }

        public void PostorderTraverse(Action<BinaryTreeNode<T>> execute)
        {
            if (_root != null)
            {
                PostorderTraverseFromNode(_root, execute);
            }
        }

        public void PostorderTraverseFromNode(BinaryTreeNode<T> current, Action<BinaryTreeNode<T>> execute)
        {
            if (current != null)
            {
                PostorderTraverseFromNode(current.Left, execute);
                PostorderTraverseFromNode(current.Right, execute);
                execute(current);
            }
        }

        #endregion

        #region Data Manipulation

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

        public void Contains(T data, Action<T> action)
        {
            var current = _root;
            int result;

            while (current != null)
            {
                result = _comparer.Compare(current.Value, data);
                if (result == 0)
                {
                    // we have found data
                    action(data);
                    return;
                }
                else if (result >
                         0)
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
            _count++;
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
            // first, make sure there are items in the tree
            if (_root == null)
            {
                // no items to remove
                return false;
            }

            // now try to find data in the tree
            var current = _root;
            BinaryTreeNode<T> parent = null;
            var result = _comparer.Compare(current.Value, data);
            while (result != 0)
            {
                if (result > 0)
                {
                    // current.Value > data, if data exists, it is in the left subtree
                    parent = current;
                    current = current.Left;
                }
                else if (result < 0)
                {
                    // current.Value < data, if data exists, it is in the right subtree
                    parent = current;
                    current = current.Right;
                }

                // if current == null, we didn't find the item to remove
                if (current == null)
                {
                    return false;
                }
                else
                {
                    result = _comparer.Compare(current.Value, data);
                }
            }

            // at this point, we have found the node to remove
            _count -= 1;

            // now we need to rethread the tree
            // CASE 1: if current has no right child, 
            // current's left child becomes the node pointed by the parent
            if (current.Right == null)
            {
                if (parent == null)
                {
                    _root = current.Left;
                }
                else
                {
                    result = _comparer.Compare(parent.Value, current.Value);
                    if (result > 0)
                    {
                        // parent.Value > current.Value, 
                        // so make current's left child a left child of the parent
                        parent.Left = current.Left;
                    }
                    else if (result < 0)
                    {
                        // parent.Value < current.Value,
                        // so make current's left child a right child of parent
                        parent.Right = current.Left;
                    }
                }
            }

            // CASE 2: if current's right child has no left child,
            // then current's right child replaces current in the tree
            else if (current.Right.Left == null)
            {
                current.Right.Left = current.Left;

                if (parent == null)
                {
                    _root = current.Right;
                }
                else
                {
                    result = _comparer.Compare(parent.Value, current.Value);
                    if (result > 0)
                    {
                        // parent.Value > current.Value
                        // current's right child will become parent's left child
                        parent.Left = current.Right;
                    }
                    else if (result < 0)
                    {
                        // parent.Value < current.Value
                        // current's right child will become parent's right child
                        parent.Right = current.Right;
                    }
                }
            }

            // CASE 3: if current's right child has a left child
            // replace current with current's right child's left-most descendant
            else
            {
                // we first need to find the right node's left-most child
                var leftmost = current.Right.Left;
                BinaryTreeNode<T> lmParent = current.Right;

                while (leftmost.Left != null)
                {
                    lmParent = leftmost;
                    leftmost = leftmost.Left;
                }

                // the parent's left subtree becomes the leftmost's right subtree
                lmParent.Left = leftmost.Right;

                // assign leftmost's left and right to the current's left and right children
                leftmost.Left = current.Left;
                leftmost.Right = current.Right;

                if (parent == null)
                {
                    _root = leftmost;
                }
                else
                {
                    result = _comparer.Compare(parent.Value, current.Value);
                    if (result > 0)
                    {
                        // parent.Value > current.Value
                        // so make leftmost a left child of parent
                        parent.Left = leftmost;
                    }
                    else if (result < 0)
                    {
                        // parent.value < current.Value
                        // so make leftmost a right child of parent
                        parent.Right = leftmost;
                    }
                }
            }

            return true;
        }

        #endregion
    }
}

