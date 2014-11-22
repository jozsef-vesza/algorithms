using System;

namespace Algorithms
{
    public class Person : IComparable
    {
        public string Name
        {
            get;
            set;
        }

        public int Age
        {
            get;
            set;
        }

        public Person()
        {
        }

        public Person(string name, int age)
        {
            Name = name;
            Age = age;
        }

        #region IComparable implementation

        public int CompareTo(object obj)
        {
            return Name.CompareTo((obj as Person).Name);
        }

        #endregion
    }
}

