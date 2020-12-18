package comWeb;

import comUtil.DbUtil;
import comUtil.SqlOperate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    DbUtil dbUtil=new DbUtil();
    String content = null;
    private static final long serialVersionUID=1L;

    //public void destroy(){
       // super.destroy();
    //}
    public LoginServlet(){

        super();
    }

    public void doGet(HttpServletRequest request , HttpServletResponse response)
            throws ServletException, IOException {

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String vali_user = request.getParameter("ValiImage");
        String vali_sys =  request.getSession().getAttribute("Valicode").toString();
        System.out.println(vali_user);
        System.out.println(vali_sys);
        if(!vali_user.equals(vali_sys)){
            content="用户登录失败";
            System.out.println("用户登录失败");

            String error="验证码错误";
            request.setAttribute("error",error);
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }

        String Username=request.getParameter("username");
        String Password=request.getParameter("password");
        SqlOperate sqlOperate=new SqlOperate();
        System.out.print(Username);
        System.out.print(Password);

        boolean x= sqlOperate.verify(Username,Password);
        String error;
        if(!x){
            content="用户登录失败";
            System.out.println("用户登录失败");

            error="用户名或密码错误";
            request.setAttribute("error",error);
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }
        else{
            content="用户 "+Username+"登录成功";
            System.out.println("用户 "+Username+"登录成功");
            //new log1();
            request.getRequestDispatcher("home.jsp").forward(request,response);
        }
    }
}
