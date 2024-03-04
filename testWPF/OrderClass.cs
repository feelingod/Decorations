using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace testWPF
{
    class OrderClass
    {
        public int _orderID;
        public string _orderStatus;
        public DateTime _orderDate;
        public DateTime _orderDeliveryDate;
        public int _index;
        public string _city;
        public string _street;
        public string _home;
        public int _orderCode;
        public string _productName;
        public decimal _productCost;
        public int _productQuantity;

        public OrderClass(int orderID, string orderStatus, DateTime orderDate, DateTime orderDeliveryDate,
                      int index, string city, string street, string home, int orderCode,
                      string productName, decimal productCost, int productQuantity)
        {
            _orderID = orderID;
            _orderStatus = orderStatus;
            _orderDate = orderDate;
            _orderDeliveryDate = orderDeliveryDate;
            _index = index;
            _city = city;
            _street = street;
            _home = home;
            _orderCode = orderCode;
            _productName = productName;
            _productCost = productCost;
            _productQuantity = productQuantity;
        }
    }
}
