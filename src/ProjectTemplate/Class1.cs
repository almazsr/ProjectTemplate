using System;
using System.Threading;

namespace ProjectTemplate
{
    public class Class1
    {
        public double Method1(int parameter1, string parameter2)
        {
            if (parameter1 < 0)
            {
                return Math.Abs(parameter1);
            }
            if (parameter2 == "A")
            {
                return Math.Sqrt(parameter1);
            }
            return -1;
        }

        public int Method2(DateTime parameter1)
        {
            if (parameter1 == DateTime.MinValue)
            {
                throw new InvalidOperationException();
            }
            return parameter1.Year + parameter1.Month;
        }
    }
}
