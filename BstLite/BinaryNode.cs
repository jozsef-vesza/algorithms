using BstLite;

namespace BstLite
{
    public class BinaryNode<T>
    {
        private BinaryNode<T> _left;

        public BinaryNode<T> Left
        {
            get
            {
                return _left;
            }
            set
            {
                if (_left == null)
                {
                    _left = new BinaryNode<T>();
                }

                _left = value;
            }
        }

        private BinaryNode<T> _right;

        public BinaryNode<T> Right
        {
            get
            {
                return _right;
            }
            set
            {
                if (_right == null)
                {
                    _right = new BinaryNode<T>();
                }

                _right = value;
            }
        }

        public T Value
        {
            get;
            set;
        }

        public BinaryNode()
        {
        }

        public BinaryNode(T data)
            : this()
        {
            Value = data;
        }
    }
}