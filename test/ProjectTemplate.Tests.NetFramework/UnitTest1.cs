using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ProjectTemplate.NetFramework;

namespace ProjectTemplate.Tests.NetFramework
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void Method1_CallWith16AndA_Returns4()
        {
            var instance = new Class1();
            var actual = instance.Method1(16, "A");
            Assert.AreEqual(4, actual);
        }

        [TestMethod]
        public void Method1_CallWithMinus1AndNull_Returns1()
        {
            var instance = new Class1();
            var actual = instance.Method1(-1, null);
            Assert.AreEqual(1, actual);
        }

        [TestMethod]
        public void Method1_CallWith1AndNull_ReturnsMinus1()
        {
            var instance = new Class1();
            var actual = instance.Method1(1, null);
            Assert.AreEqual(-1, actual);
        }

        [TestMethod]
        public void Method2_CallWith25082020_Returns2028()
        {
            var instance = new Class1();
            var actual = instance.Method2(new DateTime(2020, 08, 25));
            Assert.AreEqual(2028, actual);
        }

        [TestMethod]
        public void Method2_CallWithMinValue_ThrowsInvalidOperationException()
        {
            var instance = new Class1();
            Assert.ThrowsException<InvalidOperationException>(() => instance.Method2(DateTime.MinValue));
        }
    }
}
