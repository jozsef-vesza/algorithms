using System;

namespace Algorithms
{
	public class BinaryTreeNode<T> : Node<T>
	{
		public BinaryTreeNode() : base() { }
		public BinaryTreeNode(T data) : base(data, null) { }

		public BinaryTreeNode(T data, BinaryTreeNode<T> left, BinaryTreeNode<T> right)
		{
			Value = data;
			var children = new NodeList<T>(2);
			children[0] = left;
			children[1] = right;

			Neighbors = children;
		}

		public BinaryTreeNode<T> Left
		{
			get
			{
				if (Neighbors == null)
				{
					return null;
				}
				return (BinaryTreeNode<T>)base.Neighbors[0];
			}
			set
			{
				if (Neighbors == null)
				{
					Neighbors = new NodeList<T>(2);
				}

				Neighbors[0] = value;
			}
		}

		public BinaryTreeNode<T> Right
		{
			get
			{
				if (Neighbors == null)
				{
					return null;
				}
				return (BinaryTreeNode<T>)base.Neighbors[1];
			}
			set
			{
				if (Neighbors == null)
				{
					Neighbors = new NodeList<T>(1);
				}

				Neighbors[1] = value;
			}
		}
	}
}

