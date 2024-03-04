using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.ComponentModel;

namespace testWPF
{
    /// <summary>
    /// Логика взаимодействия для EditProduct.xaml
    /// </summary>
    public partial class EditProduct : Window
    {

        /// Данные пользователя
        private List<string> userData = new List<string>();

        /// Список продуктов для передачи их в корзину
        private List<Product> cart_products = new List<Product>();

        private Product current_product;

        public EditProduct(List<string> userData, List<Product> productsData, Product product)
        {
            InitializeComponent();


            NameTB.Text = $"{userData[1]} {userData[2]} {userData[3]}";

            this.userData = userData;
            this.current_product = product;
            ///
            if (productsData != null)
            {
                this.cart_products = productsData;
            }

            tbArticle.Text = current_product.ArticleNumber;
            tbCategory.Text = current_product.Category;
            tbCost.Text = current_product.Cost.ToString();
            tbDescription.Text = current_product.Description;
            tbDiscount.Text = current_product.DiscountAmount.ToString();
            tbName.Text = current_product.Name;
            tbProvider.Text = current_product.Provider;
            tbQuantity.Text = current_product.QuantityInStock.ToString();
            tbPhoto.Text = current_product.Image;
            tbManufacturer.Text = current_product.Manufacturer;

        }

        private void btnEditProduct_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("EditProduct", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ProductOldArticleNumber", current_product.ArticleNumber);
                    cmd.Parameters.AddWithValue("@ProductNewArticleNumber", tbArticle.Text);
                    cmd.Parameters.AddWithValue("@ProductName", tbName.Text);
                    cmd.Parameters.AddWithValue("@ProductUnit", "шт.");
                    cmd.Parameters.AddWithValue("@ProductCost", Convert.ToInt32(tbCost.Text));
                    cmd.Parameters.AddWithValue("@ProductDiscountAmount", Convert.ToInt32(tbDiscount.Text));
                    cmd.Parameters.AddWithValue("@ProductManufacturer", tbManufacturer.Text);
                    cmd.Parameters.AddWithValue("@ProductProvider", tbProvider.Text);
                    cmd.Parameters.AddWithValue("@ProductCategory", tbCategory.Text);
                    cmd.Parameters.AddWithValue("@ProductQuantityInStock", Convert.ToInt32(tbQuantity.Text));
                    cmd.Parameters.AddWithValue("@ProductDescription", tbDescription.Text);
                    cmd.Parameters.AddWithValue("@ProductPhoto", tbPhoto.Text);
                    cmd.Parameters.AddWithValue("@ProductCurrentDiscount", 0);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        MessageBox.Show($"Изменение товара \"{current_product.Name}\" прошло успешно.");
                    }
                }
            
            }
            catch
            {
                MessageBox.Show("Неверно введены данные");
            }

        }

        private void BtnPhotoAdd_Click(object sender, RoutedEventArgs e)
        {
            //System.IO.Path.GetFileName(selectedFile)
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();   
        }

        private void StackPanel_MouseDown(object sender, MouseButtonEventArgs e)
        {
            try
            {
            DragMove();
            }
            catch { }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            ProductWindow productWindow = new ProductWindow(userData, cart_products);
            this.Close();
            productWindow.Show();
        }
    }
}
