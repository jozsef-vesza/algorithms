using System;
//using System.Collections;
using System.Collections.Generic;

namespace Algorithms
{
	public class BinaryTree<T>
	{
		private IComparer<T> _comparer;

		public BinaryTree()
		{
			Root = null;
            _comparer = Comparer<T>.Default;
		}

		public virtual void Clear()
		{
			Root = null;
		}

		public BinaryTreeNode<T> Root { get; set; }

		public bool Contains(T data)
		{
			var current = Root;
			int result;

			while (current != null)
			{

                result = _comparer.Compare(current.Value, data);
				if (result == 0)
				{
					// we have found data
					return true;
				} else if (result > 0)
				{
					// current.Value > data, search current's left subtree
					current = current.Left;
				} else if (result < 0)
				{
					// current.Value < data, search current's right subtree
					current = current.Right;
				}
			}

			return false;
		}
	}
}

