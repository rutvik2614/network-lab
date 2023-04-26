// Java program to illustrate Client side
// Implementation using DatagramSocket
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.Scanner;
  
public class UDPClient
{
    public static void main(String args[]) throws IOException
    {
        Scanner sc = new Scanner(System.in);
  
        // Step 1:Create the socket object for
        // carrying the data.
        DatagramSocket ds = new DatagramSocket();
        DatagramSocket ds2 = new DatagramSocket();
  
        InetAddress ip = InetAddress.getLocalHost();
        byte buf[] = null;
        byte buf2[] = null;
  
        // loop while user not enters "bye"
        
            System.out.println("Number 1= ");

            String inp = sc.nextLine();
            System.out.println("Number 2= ");

            String inp2 = sc.nextLine();
            
  
            // convert the String input into the byte array.
            buf = inp.getBytes();
            buf2 = inp2.getBytes();
  
            // Step 2 : Create the datagramPacket for sending
            // the data.
            DatagramPacket DpSend = new DatagramPacket(buf, buf.length, ip, 1234);
            DatagramPacket DpSend2 = new DatagramPacket(buf2, buf2.length, ip, 1235);
  
            // Step 3 : invoke the send call to actually send
            // the data.
            ds.send(DpSend);
            ds2.send(DpSend2);
  
            // break the loop if user enters "bye"
            byte[] receiveDataBytes = new byte[1024];
            DatagramPacket receivePacket = new DatagramPacket(receiveDataBytes, receiveDataBytes.length);
            ds.receive(receivePacket);
            String result = new String(receivePacket.getData(), 0, receivePacket.getLength());
            System.out.println("Result: " + result);
            ds.close();
            ds2.close();
        
    }
}