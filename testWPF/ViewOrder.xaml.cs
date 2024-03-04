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
using System.Data.SqlTypes;

namespace testWPF
{

    public partial class ViewOrder : Window
    {

        /// Данные пользователя
        private List<string> userData = new List<string>();

        /// Список продуктов для передачи их в корзину
        private List<Product> cart_products = new List<Product>();

        public ViewOrder(List<string> userData, List<Product> productsData)
        {
            InitializeComponent();

            NameTB.Text = $"{userData[1]} {userData[2]} {userData[3]}";

            this.userData = userData;

            if (productsData != null)
            {
                this.cart_products = productsData;
            }
        }

        private void dgOrder_Loaded(object sender, RoutedEventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.ConnectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM [OrderView]", conn);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    
                    dgOrder.ItemsSource = dt.DefaultView;
                    foreach( var column in dgOrder.Columns)
                    {
                        column.IsReadOnly = true;
                        if (column.Header.ToString() == "Дата доставки" || column.Header.ToString() == "Статус")
                            column.IsReadOnly = false;
                    }
                }
            }
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            ProductWindow productWindow = new ProductWindow(userData, cart_products);
            this.Close();
            productWindow.Show();
        }

        private void btnApplyChange_Click(object sender, RoutedEventArgs e)
        {   
            try
            {
                var deliveryDate = dgOrder.SelectedCells[2];
                string cellValueDeliveryDate = (deliveryDate.Column.GetCellContent(deliveryDate.Item) as TextBlock).Text;
                
                var status = dgOrder.SelectedCells[4];
                string cellValueStatus = (status.Column.GetCellContent(status.Item) as TextBlock).Text;

                if (deliveryDate.IsValid && status.IsValid)
                {
                    using(SqlConnection connection = new SqlConnection(Properties.Settings.Default.ConnectionString))
                    {
                        connection.Open();
                        SqlCommand command = new SqlCommand("UpdateOrder", connection);
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@ID", (dgOrder.SelectedCells[0].Column.GetCellContent(dgOrder.SelectedCells[0].Item) as TextBlock).Text);
                        command.Parameters.AddWithValue("@DeliveryDate", SqlDateTime.Parse(cellValueDeliveryDate));
                        command.Parameters.AddWithValue("@Status", cellValueStatus);
                        command.ExecuteNonQuery();
                    }
                    MessageBox.Show("Данные обновленны.");
                }
            }
            catch
            {
                MessageBox.Show("Неверно введены данные");
            }


        }
    }
}
