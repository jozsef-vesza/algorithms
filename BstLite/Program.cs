using System;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

namespace BstLite
{
    public class MainClass
    {
        public static void Main(string[] args)
        {
            var bst = new BinarySearchTree<int>();
            bst.Insert(4);
            bst.Insert(2);
            bst.Insert(3);
            bst.Insert(12);
            bst.Insert(8);
            bst.Insert(5);

            bst.Delete(4);

            bst.PreorderTraverse(Console.WriteLine);
            bst.InorderTraverse(Console.WriteLine);
            bst.PostorderTraverse(Console.WriteLine);

            Console.WriteLine("Min: {0}, max: {1}, size: {2}", bst.Min(), bst.Max(), bst.Size());

            Console.WriteLine("Saving tree...");

            var outFileStream = File.Create("nodes");
            var serializer = new BinaryFormatter();
            serializer.Serialize(outFileStream, bst);
            outFileStream.Close();

            Console.WriteLine("Tree saved!");

            Console.WriteLine("Loading tree...");

            if (File.Exists("nodes"))
            {
                var inFileStream = File.OpenRead("nodes");
                var deserializer = new BinaryFormatter();
                bst = (BinarySearchTree<int>)deserializer.Deserialize(inFileStream);
                inFileStream.Close();
                Console.WriteLine("Tree loaded!");
            }

            Console.WriteLine("Min: {0}, max: {1}, size: {2}", bst.Min(), bst.Max(), bst.Size());
        }
    }
}