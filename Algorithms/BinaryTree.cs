using System;
using System.Collections.Generic;

namespace Algorithms
{
    public class BinaryTree<T>
    {
        public BinaryTree()
        {
            _root = null;
        }

        public virtual void Clear()
        {
            _root = null;
        }

        public BinaryTreeNode<T> _root { get; set; }
    }
}

