using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Threading;
using Brush = System.Drawing.Brush;
using Brushes = System.Drawing.Brushes;
using Color = System.Drawing.Color;
using Image = System.Drawing.Image;
using Point = System.Drawing.Point;


namespace testWPF
{
    public partial class MainWindow : Window
    {
        private bool captcha = false;

        private string text = "";

        DispatcherTimer timer = new DispatcherTimer();

        private int seconds;

        // Список со всеми данными пользователя
        List<string> userData = new List<string>();
        public MainWindow()
        {
            InitializeComponent();

            timer.Tick += new EventHandler(timer_Tick);
            timer.Interval = new TimeSpan(0, 0, 1);
        }

        private void timer_Tick(object? sender, EventArgs e)
        {
            if (seconds != 10)
            {
                tbTimer.Visibility = Visibility.Visible;
                tbTimer.Text = $"Подождите {10 - seconds} секунд";
                seconds++;
            }
            else
            {
                timer.Stop();
                butonLogin.IsEnabled = true;
                tbTimer.Visibility = Visibility.Collapsed;
            }
        }

        private void butonLogin_Click(object sender, RoutedEventArgs e)
        {
            /// Проверка на незаполненные поля
            if (tbLogin.Text == "" || tbPassword.Text == "")
            {
                MessageBox.Show("Заполните поля для ввода данных");
                return;
            }

            /// Проверка на правильность введённой капчи
            if (captcha)
            {
                if (tbCaptchaCheck.Text != this.text)
                {
                    MessageBox.Show("Неверно введена CAPTCHA.");
                    FillCaptcha();
                    return;
                }
            }

            using (SqlConnection conn = new SqlConnection(Properties.Settings.Default.ConnectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("UserCheck", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@login", tbLogin.Text);
                cmd.Parameters.AddWithValue("@password", tbPassword.Text);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    /// Если нашлись данные по такому пользователю
                    if (reader.HasRows)
                    {
                       
                        /// Заполнение списка данными, чтобы передать их на следующую форму
                        while (reader.Read())
                        {
                            userData.Add(reader.GetInt32(0).ToString()); /// ID
                            userData.Add(reader.GetString(1));           /// Surname
                            userData.Add(reader.GetString(2));           /// Name
                            userData.Add(reader.GetString(3));           /// Patronymic
                            userData.Add(reader.GetString(4));           /// Login
                            userData.Add(reader.GetString(5));           /// Password
                            userData.Add(reader.GetInt32(6).ToString()); /// Role
                        }
                        UserNextForm();
                    }
                    else
                    {
                        MessageBox.Show("Неверно введены данные");
                        ShowCapthca();
                        FillCaptcha();
                        seconds = 0;
                        timer.Start();
                        butonLogin.IsEnabled = false;
                    }
                }
            }
        }

        private void FillCaptcha()
        {
            tbCaptchaCheck.Text = "";
            captchaImage.Source = ConvertBitmapToImageSource(CreateImage(150, 50));
        }

        private void ShowCapthca()
        {
            captcha = true;
            captchaPanel.Visibility = Visibility.Visible;
            mainPanel.Margin = new Thickness(70, 20, 70, 20);
        }
        private void UserNextForm()
        {
            ProductWindow productWindow = new ProductWindow(userData);
            this.Close();
            productWindow.Show();
        }
        private ImageSource ConvertBitmapToImageSource(Bitmap bitmap)
        {
            using (MemoryStream memory = new MemoryStream())
            {
                bitmap.Save(memory, ImageFormat.Png);
                memory.Position = 0;

                BitmapImage bitmapImage = new BitmapImage();
                bitmapImage.BeginInit();
                bitmapImage.StreamSource = memory;
                bitmapImage.CacheOption = BitmapCacheOption.OnLoad;
                bitmapImage.EndInit();

                return bitmapImage;
            }
        }


        private Bitmap CreateImage(int Width, int Height)
        {
            Random rnd = new Random();

            Bitmap result = new Bitmap(Width, Height);

            /// Вычисляем позицию текста
            int Xpos = rnd.Next(10, Width - 100);
            int Ypos = rnd.Next(0, Height - 30);

            Brush[] colors = { Brushes.Black,
                     Brushes.Red,
                     Brushes.RoyalBlue,
                     Brushes.Green };

            Graphics g = Graphics.FromImage((Image)result);

            g.Clear(Color.LightGray);
            
            text = "";
            string ALF = "1234567890QWERTYUIOPASDFGHJKLZXCVBNM";
            for (int i = 0; i < 4; ++i) ///отрисовка 4 случайных символов из списка выше
                text += ALF[rnd.Next(ALF.Length)];


            /// Функция вывода букв в капче в рандомные места
            int x = 0;
            for (int i = 0; i<4; i++)
            {
                x = (rnd.Next(0, 5));
                if (x % 2 == 0)
                    x = i;
                else
                    x -= (x*2);
                g.DrawString(text[i].ToString(),
                        new Font("Arial", 20),
                        colors[rnd.Next(colors.Length)],
                        new PointF(Xpos + (i * 15), Ypos + (x * 3)));
            }
            /// Две полоски из углов
            g.DrawLine(Pens.Black,
                       new Point(0, 0),
                       new Point(Width - 1, Height - 1));
            g.DrawLine(Pens.Black,
                       new Point(0, Height - 1),
                       new Point(Width - 1, 0));

            /// Создание белых точек
            for (int i = 0; i < Width; ++i)
                for (int j = 0; j < Height; ++j)
                    if (rnd.Next() % 10 == 0)
                        result.SetPixel(i, j, Color.White);

            return result;
        }

        private void butonGuestClick_Click(object sender, RoutedEventArgs e)
        {
            ProductWindow productWindow = new ProductWindow();
            this.Close();
            productWindow.Show();
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void StPanMain_MouseDown(object sender, MouseButtonEventArgs e)
        {
            try
            {

                DragMove();
            }
            catch { }
        }

        private void btnRefresh_Click(object sender, RoutedEventArgs e)
        {
            FillCaptcha();
        }
    }
}
