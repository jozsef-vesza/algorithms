using System;

namespace Algorithms
{
    public class Node<T>
    {
        private T _data;
        private NodeList<T> _neighbors = null;

        public Node()
        {
        }

        public Node(T data)
            : this(data, null)
        {
        }

        public Node(T data, NodeList<T> neighbors)
        {
            _data = data;
            _neighbors = neighbors;
        }

        public T Value
        {
            get { return _data; }
            set { _data = value; }
        }

        protected NodeList<T> Neighbors
        {
            get { return _neighbors; }
            set { _neighbors = value; }
        }

    }
}