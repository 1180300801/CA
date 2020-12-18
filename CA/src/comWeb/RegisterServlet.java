package comWeb;

import comUtil.SqlOperate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class RegisterServlet extends HttpServlet {
    String content = null;
    private static final long serialVersionUID=1L;

    //public void destroy(){
    // super.destroy();
    //}
    public RegisterServlet(){

        super();
    }

    public void doGet(HttpServletRequest request , HttpServletResponse response)
            throws ServletException, IOException {

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String Username=request.getParameter("username");
        String Password=request.getParameter("password");
        SqlOperate sqlOperate=new SqlOperate();
        System.out.print(Username);
        System.out.print(Password);

        boolean x= false;
        x = sqlOperate.insert(Username,Password);
        String error;
        if(!x){
            content="用户注册失败";
            System.out.println("用户注册失败");

            error="用户注册失败";
            request.setAttribute("error",error);
            request.getRequestDispatcher("register.jsp").forward(request,response);
        }
        else{
            content="用户 "+Username+"注册成功";
            System.out.println("用户 "+Username+"注册成功");
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }
    }
}
