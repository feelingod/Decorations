using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;

namespace testWPF
{
    public class Product
    { 
        public string ArticleNumber { get; set; }
        public string Name { get; set; }
        public int QuantityInStock { get; set; }
        public int Cost { get; set; }
        public int DiscountAmount { get; set; }
        public string Manufacturer { get; set; }
        public string Provider { get; set; }
        public string Category { get; set; }

        public string Description { get; set; }
        public string Image { get; set; }
        public int Quantity { get; set; }

        public Product(string articleNumber, string name, int cost, int discountAmount, 
            string manufacturer, string provider, string category, int quantityInStock, string description, string image, int quantity = 1)
        {
            this.ArticleNumber = articleNumber;
            this.Name = name;
            this.QuantityInStock = quantityInStock;
            this.Cost = cost;
            this.DiscountAmount = discountAmount;
            this.Manufacturer = manufacturer;
            this.Provider = provider;
            this.Category = category;
            this.Description = description;
            this.Image = image;
            this.Quantity = quantity;
        }
    }
}
