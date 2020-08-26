using System;
using Xunit;

namespace ProjectTemplate.Tests
{
    public class UnitTest1
    {
        [Fact]
        public void Method1_CallWith16AndA_Returns4()
        {
            var instance = new Class1();
            var actual = instance.Method1(16, "A");
            Assert.Equal(4, actual);
        }

        [Fact]
        public void Method1_CallWithMinus1AndNull_Returns1()
        {
            var instance = new Class1();
            var actual = instance.Method1(-1, null);
            Assert.Equal(1, actual);
        }

        [Fact]
        public void Method1_CallWith1AndNull_ReturnsMinus1()
        {
            var instance = new Class1();
            var actual = instance.Method1(1, null);
            Assert.Equal(-1, actual);
        }

        [Fact]
        public void Method2_CallWith25082020_Returns2028()
        {
            var instance = new Class1();
            var actual = instance.Method2(new DateTime(2020, 08, 25));
            Assert.Equal(2028, actual);
        }

        [Fact]
        public void Method2_CallWithMinValue_ThrowsInvalidOperationException()
        {
            var instance = new Class1();
            Assert.Throws<InvalidOperationException>(() => instance.Method2(DateTime.MinValue));
        }
    }
}
