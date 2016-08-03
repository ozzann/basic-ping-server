using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Timers;

namespace SimplePingServer
{
	class MainClass
	{
		const int PORT_NO = 8080;
		const string SERVER_IP = "127.0.0.1";
		const int LIMIT = 5;

		static Timer aTimer;

		static void Main(string[] args)
		{
			aTimer = new Timer(1000);
			aTimer.Elapsed += PingIt;
			aTimer.AutoReset = true;
			Console.WriteLine("The timer should fire every {0} milliseconds.",
			    aTimer.Interval);
			aTimer.Enabled = true;

			Console.ReadLine();
		}

		static void PingIt(Object source, ElapsedEventArgs e)
		{
			// listen at the specified IP
			IPAddress localIP = IPAddress.Parse(SERVER_IP);
			TcpListener listener = new TcpListener(localIP, PORT_NO);
			Console.WriteLine("Listening...");
			listener.Start();

			// incoming client connected
			TcpClient client = listener.AcceptTcpClient();

			string dataToSendBack = "Hello, world!";
			// write back the text to the client
			Console.WriteLine("Sending back : " + dataToSendBack);
			client.Close();
			listener.Stop();

			Console.ReadLine();
		}
	}
}
