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
using Microsoft.Win32;
using System.IO;

namespace testWPF
{
    /// <summary>
    /// Логика взаимодействия для AddProduct.xaml
    /// </summary>
    public partial class AddProduct : Window
    {
        string selectedFile = "";

        /// Данные пользователя
        private List<string> userData = new List<string>();

        /// Список продуктов для передачи их в корзину
        private List<Product> cart_products = new List<Product>();

        public AddProduct(List<string> userData, List<Product> productsData)
        {
            InitializeComponent();
            
            NameTB.Text = $"{userData[1]} {userData[2]} {userData[3]}";
          
            this.userData = userData;

            ///
            if (productsData != null)
            {
                this.cart_products = productsData;
            }
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.Application.Current.Shutdown();
        }

        private void btnAddProduct_Click(object sender, RoutedEventArgs e)
        {
            string Name = tbName.Text;
            string Article = tbArticle.Text;
            string Description = tbDescription.Text;
            string Manufacturer = tbManufacturer.Text;
            string Category = tbCategory.Text;
            decimal Cost;
            bool isCostValid = decimal.TryParse(tbCost.Text, out Cost);
            string Discount = tbDiscount.Text;
            string Provider = tbProvider.Text;
            int Quantity;
            bool isQuantityValid = int.TryParse(tbQuantity.Text, out Quantity);
            string Photo = tbPhoto.Text;

            /// Проверка на заполненность всех полей
            if (Name != "" && Article != "" && Description != "" && Manufacturer != "" && Category != ""
                 && isCostValid && Discount != "" && Provider != "" && isQuantityValid && Photo != "")
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.ConnectionString))
                    {
                        connection.Open();
                        SqlCommand cmd = new SqlCommand("InsertProduct", connection);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@ProductArticleNumber", Article);
                        cmd.Parameters.AddWithValue("@ProductName", Name);
                        cmd.Parameters.AddWithValue("@ProductUnit", "шт.");
                        cmd.Parameters.AddWithValue("@ProductCost", Cost);
                        cmd.Parameters.AddWithValue("@ProductDiscountAmount", byte.Parse(Discount));
                        cmd.Parameters.AddWithValue("@ProductManufacturer", Manufacturer);
                        cmd.Parameters.AddWithValue("@ProductProvider", Provider);
                        cmd.Parameters.AddWithValue("@ProductCategory", Category);
                        cmd.Parameters.AddWithValue("@ProductCurrentDiscount", 0);
                        cmd.Parameters.AddWithValue("@ProductQuantityInStock", Quantity);
                        cmd.Parameters.AddWithValue("@ProductDescription", Description);
                        cmd.Parameters.AddWithValue("@ProductPhoto", Photo);

                        cmd.ExecuteNonQuery();
                        MessageBox.Show("Продукт успешно добавлен");
                        CopyImageToProjectFolder();
                    }
                }
                catch
                {
                    MessageBox.Show("Неверно указаны данные.");
                }
            }
            else
            {
                MessageBox.Show("Заполните все поля");
            }
        }

        private void BtnPhotoAdd_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.DefaultExt = ".jpg";
            openFileDialog.Filter = "Images (*.jpg, *.png)|*.jpg;*.png";

            // Отображение диалогового окна и проверка результата
            bool? result = openFileDialog.ShowDialog();
            if (result == true)
            {
                selectedFile = openFileDialog.FileName;
                tbPhoto.Text = System.IO.Path.GetFileName(selectedFile);
            }
        }

                
        private void CopyImageToProjectFolder()
        {
            /// Копирование выбранного фото в папку проекта images, чтобы потом отображать его.
            /// P.S. Картинки в программе отображаются из папки проекта images, в БД только их название
            
            /*
            string directoryName = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
            string folderName = new System.IO.DirectoryInfo(directoryName).Name;
            */

            string fileName = System.IO.Path.GetFileName(selectedFile);
            string projectDirectory = Directory.GetParent(Directory.GetCurrentDirectory()).Parent.Parent.FullName;
            string imagesDirectory = System.IO.Path.Combine(projectDirectory, "images");
            string imageFilePath = System.IO.Path.Combine(imagesDirectory, fileName);

            //Directory.CreateDirectory(imagesDirectory);
            File.Copy(selectedFile, imageFilePath, true);
        }


        private void StackPanel_MouseDown(object sender, MouseButtonEventArgs e)
        {
            DragMove();
        }


        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            ProductWindow productWindow = new ProductWindow(userData, cart_products);
            this.Close();
            productWindow.Show();
        }
    }
}
