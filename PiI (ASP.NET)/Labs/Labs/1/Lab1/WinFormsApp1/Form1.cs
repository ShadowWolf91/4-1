namespace WinFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            var numbers = new FormUrlEncodedContent(new[]
            {
            new KeyValuePair<string, string>("a", textBox1.Text),
            new KeyValuePair<string, string>("b", textBox2.Text)
            });

            HttpClient client = new HttpClient();

            var response = await client.PostAsync("https://localhost:44390/SDS/task4", numbers);
            textBox3.Text = await response.Content.ReadAsStringAsync();
        }

        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            char number = e.KeyChar;

            if (!Char.IsDigit(number) && number != 8)
            {
                e.Handled = true;
            }
        }

        private void textBox2_KeyPress(object sender, KeyPressEventArgs e)
        {
            char number = e.KeyChar;

            if (!Char.IsDigit(number) && number != 8)
            {
                e.Handled = true;
            }
        }
    }
}