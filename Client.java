import java.net.*;
import java.io.*; 
import java.util.*;
public class Client
{
    public static void main(String[] args)
    {
    	Scanner sc =new Scanner(System.in);
    try 
    {
        System.out.println("client started\n"); 
        Socket soc=new Socket("localhost",8000);
        System.out.println("enter number 1:");
        int num1=sc.nextInt();
        PrintWriter out = new PrintWriter(soc.getOutputStream(),true);
        out.println(num1);
        System.out.println("enter number 2:");
        int num2=sc.nextInt();
        PrintWriter out2=new PrintWriter(soc.getOutputStream(),true);
        out2.println(num2); 
        BufferedReader op=new BufferedReader(new InputStreamReader(soc.getInputStream())); 
        System.out.println(op.readLine());
    } 
    catch (Exception e) 
    {
        e.printStackTrace();
    }
}
}