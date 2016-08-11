using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Timers;

namespace SimplePingServer
{
	class MainClass
	{
		const int PORT_NO = 9000;

		// Thread signal
		public static ManualResetEvent thread = new ManualResetEvent(false);

		public static void Listen()
		{
			// Establish the local endpoint for the socket.
			//IPHostEntry ipHostInfo = Dns.GetHostEntry("localhost");
			//IPAddress ipAddress = ipHostInfo.AddressList[0];
			//IPEndPoint localEndPoint = new IPEndPoint(ipAddress, PORT_NO);

			IPEndPoint localEndPoint = new IPEndPoint(IPAddress.Any, PORT_NO);

			// Create a TCP/IP socket.
			Socket listener = new Socket(AddressFamily.InterNetwork,
				SocketType.Stream, ProtocolType.Tcp);

			try
			{
				// Bind the socket to the local endpoint
				listener.Bind(localEndPoint);
				//  and listen for incoming connections
				listener.Listen(100);

				while (true)
				{
					thread.Reset();

					// Start an asynchronous socket to listen for connections
					Console.WriteLine("Waiting for a connection!!........");
					listener.BeginAccept(
						new AsyncCallback(AcceptCallback),
						listener);

					// Wait until a connection is made before continuing
					thread.WaitOne();
				}
			}
			catch (Exception e)
			{
				Console.WriteLine("Can't connect to localhost: " + e.ToString());
			}

			thread.Dispose();
			thread.Close();

			Console.Read();
		}

		public static void AcceptCallback(IAsyncResult ar)
		{
			thread.Set();

			Socket listener = (Socket)ar.AsyncState;
			// socket which handles incoming connections
			Socket handler = listener.EndAccept(ar);

			byte[] buffer = new byte[1024];
			// handler is starting to recieve data from the listener
			handler.BeginReceive(buffer, 0, 0, SocketFlags.None,
			    new AsyncCallback(ReadCallback), handler);
		}

		public static void ReadCallback(IAsyncResult ar)
		{
			Socket handler = (Socket)ar.AsyncState; ;

			string dataToSend = "Hello, world!\n";
			Send(handler, dataToSend);
		}

		private static void Send(Socket handler, String data)
		{
			byte[] byteData = Encoding.ASCII.GetBytes(data);

			// Begin sending the data to the client
				handler.BeginSend(byteData, 0, byteData.Length, SocketFlags.None,
					new AsyncCallback(SendCallback), handler);
		}

		private static void SendCallback(IAsyncResult ar)
		{
			try
			{
				Socket handler = (Socket)ar.AsyncState;

				// When sending data to the client is finished:
				Console.WriteLine("Said hello to client.");

				handler.Shutdown(SocketShutdown.Both);
				handler.Close();

			}
			catch (Exception e)
			{
				Console.WriteLine("Couldn't connect to client: " + e.ToString());
			}
		}


		public static void Main(String[] args)
		{
			Listen();
		}
	}
}
