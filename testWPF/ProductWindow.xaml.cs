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
using static System.Net.Mime.MediaTypeNames;
using System.Xml.Linq;
using System.Reflection;

namespace testWPF
{
    /// <summary>
    /// Логика взаимодействия для ProductWindow.xaml
    /// </summary>
    public partial class ProductWindow : Window
    {

        /// Данные пользователя
        private List<string> userData = new List<string>();

        /// Список всех продуктов
        private List<Product> allProducts = new List<Product>();

        /// Список продуктов по запросу и текущим фильтрам
        private List<Product> products = new List<Product>();

        /// Список продуктов для передачи их в корзину
        private List<Product> cart_products = new List<Product>();

        int current_page = 1;
        int all_pages = 0;


        /// Индекс продуктов на странице, нужен для работы с продуктами (поместить в корзину, отредактировать, удалить)
        int x = 0;

        /// Переменные для параметров процедуры по выборке продуктов в зависимости от выбора DiscountCmbBx и CategoryCmbBx.
        double[] discount = new double [2] {0, 100};
        string category = "";



        public ProductWindow(List<string>? userData = null, List<Product>? productsData = null)
        {
            InitializeComponent();

            //DiscountCmbBx.SelectedIndex = 0;
            //CategoryCmbBx.SelectedIndex = 0;
            products.Clear();

            if (userData != null)
            {
                //Добавление имени пользователя в TextBlock
                NameTB.Text = $"{userData[1]} {userData[2]} {userData[3]}";

                //кнопки, доступная только админам
                if (Convert.ToInt32(userData[6]) == 3) {
                    AddProductBtn.Visibility = Visibility.Visible;
                    ViewOrder.Visibility = Visibility.Visible;
                    btnEditProduct.Visibility = Visibility.Visible;
                    btnDeleteProduct.Visibility = Visibility.Visible;
                    btnEditProduct2.Visibility = Visibility.Visible;
                    btnDeleteProduct2.Visibility = Visibility.Visible;
                    btnEditProduct3.Visibility = Visibility.Visible;
                    btnDeleteProduct3.Visibility = Visibility.Visible;
                }
                    
            }
            else
                NameTB.Text = "Гость";
            this.userData = userData;

            if (productsData != null)
            {
                this.cart_products = productsData;
                BtnCart.Visibility = Visibility.Visible;
            }

            ///Выборка всех товаров
            LoadDataProduct(discount, category);

            ///Заполнение интерфейса
            FillProductPanels(1, products[0], products[1], products[2]);
            SetPageCountTB();
            SetProductsCountTB();

            LoadCategoryData();
        }

        private void ReloadProductsList()
        {
            products = allProducts;
            AllPagesCount();
        }
        private void SetProductsCountTB()
        {
            tbProductCount.Text = $"Товаров найнено: {products.Count()}";
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.Application.Current.Shutdown();
        }



        /// <summary>
        /// Функция загрузки продуктов, использующая параметры 2х ComboBox: Диапазон скидки и категория товара.
        /// </summary>
        /// <param name="discountFrom"></param>
        /// <param name="discountTo"></param>
        /// <param name="category"></param>
        private void LoadDataProduct(double[] discount, string category)
        {

            double discountFrom = discount[0];
            double discountTo = discount[1];
            using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.ConnectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SelectProducts", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@discountFrom", discountFrom);
                cmd.Parameters.AddWithValue("@discountTo", discountTo);
                cmd.Parameters.AddWithValue("@category", category);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            string Article = (reader.GetString(0));
                            string Name = (reader.GetString(1));          
                            ///string Unit = (reader.GetString(2));          ///шт
                            int Cost = (reader.GetInt32(3));  
                            byte DiscountAmount = (reader.GetByte(4));
                            string Manufacter = (reader.GetString(5));
                            string Provider = (reader.GetString(6));
                            string Category = (reader.GetString(7));
                            int QuantityInStock = (reader.GetInt32(9));
                            string Description = (reader.GetString(10));
                            string Photo;
                            try
                            {
                                Photo = (reader.GetString(11));
                            }
                            catch
                            {
                                Photo = ("picture.png"); /// фото-заглушка
                            }
                            Product product = new Product(Article, Name, Cost, DiscountAmount, Manufacter, Provider,
                                Category, QuantityInStock, Description, Photo);
                            allProducts.Add(product);
                        }
                        ReloadProductsList();
                    }
                }
            }
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

        private void SetPageCountTB()
        {
            if (all_pages == 0)
            {
                current_page = 0;
                ClearPanel();
            }
            CurrentPageTB.Text = $"Страница {current_page} из {all_pages}";
        }


        private void LoadCategoryData()
        {
            using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.ConnectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand("SelectCategory", connection);
                cmd.CommandType = CommandType.StoredProcedure;
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    // Заполнение ComboBox данными из БД
                    while (reader.Read())
                    {
                        string category = $"{reader["ProductCategory"]}";
                        TextBlock textBlock = new TextBlock();
                        textBlock.Text = category;
                        CategoryCmbBx.Items.Add(textBlock);
                    }
                }
            }
        }

        /// Заполняет три панели товаров (если они есть)
        private void FillProductPanels(int current_page, Product? prd1 = null, Product? prd2 = null, Product? prd3 = null)
        {
            if (prd1 == null)
            {
                ClearPanel();
                return;
            }
            else
            {
                FillPanel1(prd1.Image, prd1.Name, prd1.Description,
                    prd1.Manufacturer, prd1.Cost, prd1.DiscountAmount);
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
                    prd2.Manufacturer, prd2.Cost, prd2.DiscountAmount);
            }
            if (prd3 == null)
            {
                ClearPanel3();
            }
            else
            {
                FillPanel3(prd3.Image, prd3.Name, prd3.Description,
                    prd3.Manufacturer, prd3.Cost, prd3.DiscountAmount);
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
        }

        private void ClearPanel2()
        {
            Img2.Source = null;
            ProductNameTB2.Text = "";
            ProductDescriptionTB2.Text = "";
            ProductManufacterTB2.Text = "";
            ProductCostTB2.Text = "";
            DiscountTB2.Text = "";
        }

        private void ClearPanel3()
        {
            Img3.Source = null;
            ProductNameTB3.Text = "";
            ProductDescriptionTB3.Text = "";
            ProductManufacterTB3.Text = "";
            ProductCostTB3.Text = "";
            DiscountTB3.Text = "";
        }

        /// Такой код для заполнения и удаления для каждого из трёх элементов 
        /// нужен для правильного отображения всех элементов на странице, к примеру:
        /// Пользователь перелистывает на последнюю страницу, и нужно почистить последние 1-2 панели, 
        /// или также заполнить всего несколько (1-2) панелей при узконаправленном поиске продукта по параметрам и т.д.

                
        private void FillPanel1(string image, string name, string description, string manufacter, int cost, int discount)
        {
            Img1.Source = new BitmapImage(new Uri($"/images/{image}", UriKind.Relative));
            ProductNameTB1.Text = name;
            ProductDescriptionTB1.Text = description;
            ProductManufacterTB1.Text = manufacter;
            ProductCostTB1.Text = $"Цена : {cost}";
            DiscountTB1.Text = $"Скидка: {discount}%";
        }

        private void FillPanel2(string image, string name, string description, string manufacter, int cost, int discount)
        {
            Img2.Source = new BitmapImage(new Uri($"/images/{image}", UriKind.Relative));
            ProductNameTB2.Text = name;
            ProductDescriptionTB2.Text = description;
            ProductManufacterTB2.Text = manufacter;
            ProductCostTB2.Text = $"Цена : {cost}";
            DiscountTB2.Text = $"Скидка: {discount}%";
        }

        private void FillPanel3(string image, string name, string description, string manufacter, int cost, int discount)
        {
            Img3.Source = new BitmapImage(new Uri($"/images/{image}", UriKind.Relative));
            ProductNameTB3.Text = name;
            ProductDescriptionTB3.Text = description;
            ProductManufacterTB3.Text = manufacter;
            ProductCostTB3.Text = $"Цена : {cost}";
            DiscountTB3.Text = $"Скидка: {discount}%";
        }

        private void AddProductBtn_Click(object sender, RoutedEventArgs e)
        {
            AddProduct addProduct = new AddProduct(userData, cart_products);
            this.Close();
            addProduct.Show();
        }

        private void ExitBtn_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainWindow = new MainWindow();
            this.Close();
            mainWindow.Show();
        }

        private void btnPred_Click(object sender, RoutedEventArgs e)
        {
            if (current_page-1 > 0) 
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

                SetPanelsByProductCount();

            }
            
        }

        /// Заполнение страницы в зависимости от количества товаров
        private void SetPanelsByProductCount()
        {
            try
            {
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
            catch
            {
                MessageBox.Show("Невозможно выполнить данное действие");
            }
           
        }


     
        private void DiscountCmbBx_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            products.Clear();
            allProducts.Clear();
            
            ClearPanel();

            /// Все продукты
            if (DiscountCmbBx.SelectedIndex == 0)
            {
                discount = new double[2] { 0, 100 };
            }

            /// Продукты со скидкой 0% - 9,99%
            if (DiscountCmbBx.SelectedIndex == 1)
            {
                discount = new double[2] { 0, 9.99 };
            }

            /// Продукты со скидкой 10% - 14,99%
            if (DiscountCmbBx.SelectedIndex == 2)
            {
                discount = new double [2] { 10, 14.99 };
            }

            /// Продукты со скидкой 15%+
            if (DiscountCmbBx.SelectedIndex == 3)
            {
                discount = new double [2] {15, 100};
            }


            LoadDataProduct(discount, category);
            current_page = 1;
            this.x = 0;
            

            if (SearchTB.Text != "")
            {
                SearchByQuery();
            }

            SetPanelsByProductCount();
            AllPagesCount();
            SetPageCountTB();
            SetProductsCountTB();
        }

        private void BtnCart_Click(object sender, RoutedEventArgs e)
        {
            MyOrder cart = new MyOrder(cart_products, userData);
            this.Close();
            cart.Show();
        }

        // Поисковой TextBox
        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            current_page = 1;
            ClearPanel();


            // BackSpace был нажат
            if (e.Changes.Any(c => c.RemovedLength > 0))
            {
                SearchByQuery(true);
                return;
            }
            if (SearchTB.Text != "")
            {   
                SearchByQuery();
            }
            else
            {   /// Установка дефолтных значений (запрос пустой)
                ReloadProductsList();
                FillProductPanels(1, products[0], products[1], products[2]);
                SetPageCountTB();
                SetProductsCountTB();
            }
        }

        private void SearchByQuery(bool backspace = false)
        {   
            if (backspace)
            {
                ReloadProductsList();
            }
            /// Запрос через LINQ, который ищет совпадения в именах товаров из списка объектов класса Product
            var filteredProducts = products.Where(p => p.Name.ToLower().Contains(SearchTB.Text.ToLower())).ToList();
            products = filteredProducts;

            if (products.Count() >= 3)
                FillProductPanels(1, products[0], products[1], products[2]);
            else if (products.Count() == 2)
                FillProductPanels(1, products[0], products[1]);
            else if (products.Count() == 1)
                FillProductPanels(1, products[0]);
            else
                ClearPanel();
            x = 0;
            AllPagesCount();
            SetPageCountTB();
            SetProductsCountTB();
        }

        private void btnAddProductInCart_Click(object sender, RoutedEventArgs e)
        {
            Product? current_product = IdentifyCurrentProduct(sender);

            if (current_product is null)
                return;
            var existing_product = cart_products.FirstOrDefault(p => p.ArticleNumber == current_product.ArticleNumber);
            if (existing_product != null)
                existing_product.Quantity++;
            else
                AddItemToCart(current_product);
        }

        private void AddItemToCart(Product item)
        {
            BtnCart.Visibility = Visibility.Visible;
            cart_products.Add(item);
        }
    
        private void btnEditProduct_Click(object sender, RoutedEventArgs e)
        {
            Product? current_product = IdentifyCurrentProduct(sender);

            if (current_product is null)
                return;
            EditProduct editform = new EditProduct(userData, cart_products, current_product);
            this.Hide();
            editform.Show();
        }


        private void btnDeleteProduct_Click(object sender, RoutedEventArgs e)
        {
            
            Product? current_product = IdentifyCurrentProduct(sender);

            if (current_product is null)
                return;

            
            /// Удаление выбранного объекта при подтверждении в MessageBox
            var dialogResult = MessageBox.Show($"Вы действительно хотите удалить товар \"{current_product.Name}\"?","Внимание!", MessageBoxButton.YesNo);
            if (dialogResult == MessageBoxResult.Yes)
            {
                using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("DeleteProduct", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Article", current_product.ArticleNumber);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            MessageBox.Show($"Удаление товара \"{current_product.Name}\" прошло успешно.");

                            DiscountCmbBx.SelectedIndex = 0;
                            CategoryCmbBx.SelectedIndex = 0;
                        }
                    }
                }
            }

        }   


        private Product? IdentifyCurrentProduct(object sender)
        {
            Product? current_product;

            /// Получаем имя того, продукта, на котором вызвали contextmenu
            MenuItem editButton = (MenuItem)sender;
            ContextMenu contextMenu = (ContextMenu)editButton.Parent;
            StackPanel childStackPanel = (StackPanel)contextMenu.PlacementTarget;

            string panel_name = childStackPanel.Name;

            /// Определение вызова функции и указание конкретного продукта
            try
            {
                if (panel_name == "ProductPanel2")
                    current_product = products[x + 1];

                else if (panel_name == "ProductPanel3")
                    current_product = products[x + 2];

                else
                    current_product = products[x];
            }
            catch
            {
                    MessageBox.Show("Продукт не выбран");
                    return null;
            }



            return current_product;
        }



        private void Border_MouseDown(object sender, MouseButtonEventArgs e)
        {
            DragMove();
        }

        private void CategoryCmbBx_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            products.Clear();
            allProducts.Clear();

            TextBlock? textBlock = CategoryCmbBx.SelectedItem as TextBlock;
            if (textBlock != null)
                category = textBlock.Text;


            LoadDataProduct(discount, category);
            current_page = 1;
            this.x = 0;


            if (SearchTB.Text != "")
            {
                SearchByQuery();
            }

            SetPanelsByProductCount();
            AllPagesCount();
            SetPageCountTB();
            SetProductsCountTB();
        }

        private void ViewOrder_Click(object sender, RoutedEventArgs e)
        {
            ViewOrder viewOrder = new ViewOrder(userData, cart_products);
            this.Close();
            viewOrder.Show();
        }
    }   
}
