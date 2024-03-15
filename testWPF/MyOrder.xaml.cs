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
using System.Reflection.Metadata;

namespace testWPF
{
    /// <summary>
    /// Логика взаимодействия для MyOrder.xaml
    /// </summary>
    public partial class MyOrder : Window
    {
        List<string> userData = new List<string>();
        private List<Product> products = new List<Product>();
        private List<Product> cart_products = new List<Product>();
        int current_page = 1;
        int all_pages = 0;
        int x = 0;
        public MyOrder(List<Product> productsData, List<string>? userData = null)
        {
            InitializeComponent();
            PickupPointCmbBx.SelectedIndex = 0;
            products.Clear();

            if (userData != null)
            {
                NameTB.Text = $"{userData[1]} {userData[2]} {userData[3]}";
                
            }
            else
                NameTB.Text = "Гость";
            this.userData = userData;
            this.cart_products = productsData;
            this.products = productsData;
            LoadDataProduct();


            /// Заполнение панелей товарами, в зависимости от их количества
            if (products.Count() >= 3)
                FillProductPanels(1, products[0], products[1], products[2]);
            else if (products.Count() == 2)
                FillProductPanels(1, products[0], products[1]);
            else
                FillProductPanels(1, products[0]);


            SetPageCountTB();
            SetProductsCountTB();
            LoadPickupPointsData();
        }


        private void LoadPickupPointsData()
        {
            using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.ConnectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand("SelectPickupPointData", connection);
                cmd.CommandType = CommandType.StoredProcedure;
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    // Заполнение ComboBox данными из БД
                    while (reader.Read())
                    {
                        string pickupPointInfo = $"{reader["Index"]}, {reader["City"]}, {reader["Street"]}, {reader["Home"]}";
                        TextBlock textBlock = new TextBlock();
                        textBlock.Text = pickupPointInfo;
                        PickupPointCmbBx.Items.Add(textBlock);
                    }
                }
            }
        }
        private void SetProductsCountTB()
        {
            tbProductCount.Text = $"Товаров для заказа: {products.Count()}";
        }

        private void LoadDataProduct(string procedure = "AllProductSelect")
        {
            
            AllPagesCount();
        }

        private void AllPagesCount()
        {
            if (products.Count() % 3 == 0)
            {
                all_pages = products.Count() / 3;
            }
            else
            {
                all_pages = products.Count() / 3;
                all_pages++;
            }
        }

        private void FillProductPanels(int current_page, Product? prd1 = null, Product? prd2 = null, Product? prd3 = null)
        {
            //
            try
            {
                if (prd1 == null)
                {
                    ClearPanel();
                    return;
                }
                else
                {
                    FillPanel1(prd1.Image, prd1.Name, prd1.Description,
                        prd1.Manufacturer, prd1.Cost, prd1.DiscountAmount, prd1.Quantity);
                }
                if (prd2 == null)
                {
                    ClearPanel2();
                    ClearPanel3();
                    return;
                }
                else
                {
                    FillPanel2(prd2.Image, prd2.Name, prd2.Description,
                        prd2.Manufacturer, prd2.Cost, prd2.DiscountAmount, prd2.Quantity);
                }
                if (prd3 == null)
                {
                    ClearPanel3();
                }
                else
                {
                    FillPanel3(prd3.Image, prd3.Name, prd3.Description,
                        prd3.Manufacturer, prd3.Cost, prd3.DiscountAmount, prd3.Quantity);
                }
                /*
                if (current_page <= all_pages)
                {}
                */
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }
        private void ClearPanel()
        {
            ClearPanel1();
            ClearPanel2();
            ClearPanel3();
        }
        private void ClearPanel1()
        {
            Img1.Source = null;
            ProductNameTB1.Text = "";
            ProductDescriptionTB1.Text = "";
            ProductManufacterTB1.Text = "";
            ProductCostTB1.Text = "";
            DiscountTB1.Text = "";
            tbQuantity1.Text = "";
        }

        private void ClearPanel2()
        {
            Img2.Source = null;
            ProductNameTB2.Text = "";
            ProductDescriptionTB2.Text = "";
            ProductManufacterTB2.Text = "";
            ProductCostTB2.Text = "";
            DiscountTB2.Text = "";
            tbQuantity2.Text = "";
        }
        private void ClearPanel3()
        {
            Img3.Source = null;
            ProductNameTB3.Text = "";
            ProductDescriptionTB3.Text = "";
            ProductManufacterTB3.Text = "";
            ProductCostTB3.Text = "";
            DiscountTB3.Text = "";
            tbQuantity3.Text = "";
        }
        private void FillPanel1(string image, string name, string description, string manufacter, int cost, int discount, int qnty)
        {
            Img1.Source = new BitmapImage(new Uri($"/images/{image}", UriKind.Relative));
            ProductNameTB1.Text = name;
            ProductDescriptionTB1.Text = description;
            ProductManufacterTB1.Text = manufacter;
            ProductCostTB1.Text = $"Цена : {cost}";
            DiscountTB1.Text = $"Скидка: {discount}%";
            tbQuantity1.Text = qnty.ToString();
        }
        private void FillPanel2(string image, string name, string description, string manufacter, int cost, int discount, int qnty)
        {
            Img2.Source = new BitmapImage(new Uri($"/images/{image}", UriKind.Relative));
            ProductNameTB2.Text = name;
            ProductDescriptionTB2.Text = description;
            ProductManufacterTB2.Text = manufacter;
            ProductCostTB2.Text = $"Цена : {cost}";
            DiscountTB2.Text = $"Скидка: {discount}%";
            tbQuantity2.Text = qnty.ToString();
        }
        private void FillPanel3(string image, string name, string description, string manufacter, int cost, int discount, int qnty)
        {
            Img3.Source = new BitmapImage(new Uri($"/images/{image}", UriKind.Relative));
            ProductNameTB3.Text = name;
            ProductDescriptionTB3.Text = description;
            ProductManufacterTB3.Text = manufacter;
            ProductCostTB3.Text = $"Цена : {cost}";
            DiscountTB3.Text = $"Скидка: {discount}%";
            tbQuantity3.Text = qnty.ToString();
        }

        private void SetPageCountTB()
        {
            CurrentPageTB.Text = $"Страница {current_page} из {all_pages}";
        }


        private void btnPred_Click(object sender, RoutedEventArgs e)
        {
            if (current_page - 1 > 0)
            {
                current_page--;
                CurrentPageTB.Text = $"Страница {current_page} из {all_pages}";
                x -= 3;
                FillProductPanels(current_page, products[x], products[x + 1], products[x + 2]);
            }

        }

        private void btnNext_Click(object sender, RoutedEventArgs e)
        {
            if (current_page + 1 <= all_pages)
            {
                current_page++;
                CurrentPageTB.Text = $"Страница {current_page} из {all_pages}";
                x += 3;


                /// Проверка на кратность трём нужна для того, чтобы поместить оставшиеся товары на последнюю страницу правильно
                if (current_page == all_pages)
                {

                    /// Один товар на странице
                    if (products.Count() % 3 == 1)
                    {
                        FillProductPanels(current_page, products[x]);
                    }

                    /// Два товара на странице
                    else if (products.Count() % 3 == 2)
                    {
                        FillProductPanels(current_page, products[x], products[x + 1]);
                    }
                    else
                    {
                        FillProductPanels(current_page, products[x], products[x + 1], products[x + 2]);
                    }
                    return;
                }
                else ///Если страница не последняя, то в любом случае в ней будет 3 товара
                    FillProductPanels(current_page, products[x], products[x + 1], products[x + 2]);

            }

        }

        private void btnMakeOrder_Click(object sender, RoutedEventArgs e)
        { 
            if (cart_products.Count <= 0)
            {
                MessageBox.Show("Ваша корзина пуста");
                return;
            }
            if (PickupPointCmbBx.SelectedIndex == 0)
            {
                MessageBox.Show("Выберите пункт выдачи");
                return;
            }

            
            int id_order = 0;
            int order_code = 0;


            /// Получаем максимальный ID заказа, чтобы сделать следующий на 1 больше
            using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT MAX([OrderID]), MAX([OrderCode]) from [Order] as zxc", connection);
                using(SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        id_order = reader.GetInt32(0) + 1;
                        order_code = reader.GetInt32(1) + 1;
                    }
                }
            }

            /// Добавляем данные самого заказа в БД
            using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("MakeOrder", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@OrderDate", DateTime.Today.ToString());
                command.Parameters.AddWithValue("@DeliveryDate", DateTime.Today.AddDays(7).ToString());
                command.Parameters.AddWithValue("@PickupPoint", PickupPointCmbBx.SelectedIndex);
                command.Parameters.AddWithValue("@Code", order_code);
                command.Parameters.AddWithValue("@Status", "Новый");
                if (userData is null)
                    command.Parameters.AddWithValue("@UserID", DBNull.Value);
                else
                    command.Parameters.AddWithValue("@UserID", Convert.ToInt32(userData[0]));

                SqlDataReader reader = command.ExecuteReader();
            }


            foreach ( Product prod in cart_products)
            {
                
                /// Добавляем данные о продуктах заказа в БД
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.ConnectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("MakeOrderProduct", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@ID", id_order);
                    command.Parameters.AddWithValue("@Article", prod.ArticleNumber);
                    command.Parameters.AddWithValue("@Quantity", prod.Quantity);

                    SqlDataReader reader = command.ExecuteReader();

                }
            }

            string prd = "";
            foreach (Product pr in cart_products)
            {
                prd += $"{pr.Name} {pr.Quantity} шт.\n";
            }
            MessageBox.Show($"Заказ товара прошёл успешно!\n" +
                $"Код выдачи: '{order_code}' \n" +
                $"Состав заказа: {prd}");

        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            ProductWindow productWindow = new ProductWindow(userData,cart_products);
            this.Close();
            productWindow.Show();

        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void ProductPanel1_MouseRightButtonUp(object sender, MouseButtonEventArgs e)
        {
            
        }


        private void btnDeleteProduct_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                cart_products.Remove(cart_products[x]);
                ClearPanel();
                SetPageCountTB();
                AllPagesCount();
                SetPanelsByProductCount();
                SetProductsCountTB();
            }
            catch { }

        }
        private void SetPanelsByProductCount()
        {
            if (current_page == all_pages)
            {
                /// Один товар на странице
                if (products.Count() % 3 == 1)
                {
                    FillProductPanels(current_page, products[x]);
                }

                /// Два товара на странице
                else if (products.Count() % 3 == 2)
                {
                    FillProductPanels(current_page, products[x], products[x + 1]);
                }
                else
                {
                    FillProductPanels(current_page, products[x], products[x + 1], products[x + 2]);
                }
                return;
            }
            else
                FillProductPanels(current_page, products[x], products[x + 1], products[x + 2]);
        }

        private void btnDeleteProduct2_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                cart_products.Remove(cart_products[x + 1]);
                ClearPanel();
                SetPageCountTB();
                AllPagesCount();
                SetPanelsByProductCount();
                SetProductsCountTB();
            }
            catch { }
        }

        private void btnDeleteProduct3_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                cart_products.Remove(cart_products[x + 2]);
                ClearPanel();
                SetPageCountTB();
                AllPagesCount();
                SetPanelsByProductCount();
                SetProductsCountTB();
            }
            catch { }
            
        }

        private void tbQuantity3_MouseLeave(object sender, MouseEventArgs e)
        {
            if (Int32.TryParse(tbQuantity3.Text, out var number))
            {
                cart_products[x + 2].Quantity = Convert.ToInt32(tbQuantity3.Text);
            }

        }

        private void tbQuantity2_MouseLeave(object sender, MouseEventArgs e)
        {
            if (Int32.TryParse(tbQuantity2.Text, out var number))
            {
                cart_products[x + 1].Quantity = Convert.ToInt32(tbQuantity2.Text);
            }
        }

        private void tbQuantity1_MouseLeave(object sender, MouseEventArgs e)
        {
            if (Int32.TryParse(tbQuantity1.Text, out var number))
            {   
                cart_products[x].Quantity = Convert.ToInt32(tbQuantity1.Text);
            }
        }
    }
}
