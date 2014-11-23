using System;
using System.Collections.ObjectModel;

namespace Algorithms
{
    public class NodeList<T> : Collection<Node<T>>
    {
        public NodeList()
            : base()
        {
        }

        public NodeList(int initialSize)
        {
            // add the specified number of items
            for (var i = 0; i < initialSize; i++)
            {
                base.Items.Add(default(Node<T>));
            }
        }

        public Node<T> FindByValue(T value)
        {
            // search the list for the value
            foreach (var node in Items)
            {
                if (node.Value.Equals(value))
                {
                    return node;
                }
            }

            // we did not find a matching value
            return null;
        }
    }
}