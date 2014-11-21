﻿using System;
using System.Collections.Generic;

namespace Algorithms
{
    public class BinaryTree<T>
    {
        public BinaryTree()
        {
            Root = null;
        }

        public virtual void Clear()
        {
            Root = null;
        }

        public BinaryTreeNode<T> Root { get; set; }
    }
}

