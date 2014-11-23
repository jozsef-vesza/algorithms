using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace BstLite
{
    [Serializable]
    public class BinarySearchTree<T> : ISerializable
    {
        #region Setup

        private BinaryNode<T> _root;
        private readonly IComparer<T> _comparer;

        public BinarySearchTree()
        {
            _root = null;
            _comparer = Comparer<T>.Default;
        }

        public BinarySearchTree(SerializationInfo info, StreamingContext context)
            : this()
        {
            var values = (List<T>)info.GetValue("values", typeof(List<T>));
            foreach (var value in values)
            {
                Insert(value);
            }
        }

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            var values = new List<T>();
            InorderTraverse(values.Add);
            info.AddValue("values", values);
        }

        #endregion

        #region Traversal

        public T Min()
        {
            var values = new List<T>();
            InorderTraverse(values.Add);
            return values[0];
        }

        public T Max()
        {
            var values = new List<T>();
            InorderTraverse(values.Add);
            return values[values.Count - 1];
        }

        public int Size()
        {
            return Size(_root);
        }

        public int Size(BinaryNode<T> node)
        {
            var size = 0;
            InorderTraverse(_ => size += 1);
            return size;
        }

        public void PreorderTraverse(Action<T> action)
        {
            if (_root == null)
            {
                return;
            }

            PreorderTraverse(_root, action);
        }

        public void PreorderTraverse(BinaryNode<T> node, Action<T> action)
        {
            if (node != null)
            {
                if (action != null)
                {
                    action(node.Value);
                }
                PreorderTraverse(node.Left, action);
                PreorderTraverse(node.Right, action);
            }
        }

        public void InorderTraverse(Action<T> action)
        {
            if (_root == null)
            {
                return;
            }

            InorderTraverse(_root, action);
        }

        public void InorderTraverse(BinaryNode<T> node, Action<T> action)
        {
            if (node != null)
            {
                InorderTraverse(node.Left, action);

                if (action != null)
                {
                    action(node.Value);
                }

                InorderTraverse(node.Right, action);
            }
        }

        public void PostorderTraverse(Action<T> action)
        {
            if (_root == null)
            {
                return;
            }

            PostorderTraverse(_root, action);
        }

        public void PostorderTraverse(BinaryNode<T> node, Action<T> action)
        {
            if (node != null)
            {
                PostorderTraverse(node.Left, action);
                PostorderTraverse(node.Right, action);

                if (action != null)
                {
                    action(node.Value);
                }
            }
        }

        #endregion

        #region Data Operations

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

            // first time insert, there is no parent
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

        #endregion
    }
}