import java.net.*;
import java.io.*; 
public class Server
{
    public static void main(String args[])
    {
    try 
    {
            System.out.println("Waiting for connection...\n"); 
            //object for server socket is created
            ServerSocket ss=new ServerSocket(8000); 
            //block until request is received
            Socket soc=ss.accept(); 
            System.out.println("connection established\n");
            BufferedReader in = new BufferedReader(new InputStreamReader(soc.getInputStream())); 
            int num1=Integer.parseInt(in.readLine());
            PrintWriter out=new PrintWriter(soc.getOutputStream(),true); 
            BufferedReader in2=new BufferedReader(new InputStreamReader(soc.getInputStream()));
            int num2=Integer.parseInt(in2.readLine());
            float sum=num1+num2;
            System.out.println("sum = "+sum);
            out.println(sum); 
            out.flush(); 
    } 
    catch (Exception e) 
    {
       e.printStackTrace();
    }
}
/*static int fact_cal(int num1)
    {
        int fact=1; 
        for(int i=1;i<=num1;i++)
        {
            fact=fact*i; 
        }
        return fact; 
    }*/
}