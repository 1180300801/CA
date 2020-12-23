package comWeb;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import comUtil.RSA;
import comUtil.Key;

public class testServlet extends HttpServlet {
    private static final long serialVersionUID=1L;

    //public void destroy(){
    // super.destroy();
    //}
    public testServlet(){

        super();
    }

    public void doGet(HttpServletRequest request , HttpServletResponse response)
            throws ServletException, IOException {

        this.doPost(request,response);

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        InputStream input=request.getInputStream();
        System.out.println(1);
        byte[] pp=new byte[1024];
        int len=input.read(pp);
        String cipher=new String(pp,"utf-8");
        System.out.println(cipher);


        try {

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}