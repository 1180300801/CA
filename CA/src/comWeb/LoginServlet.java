package comWeb;

import comUtil.DbUtil;
import comUtil.SqlOperate;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    DbUtil dbUtil=new DbUtil();
    String content = null;
    private static final long serialVersionUID=1L;
    Logger logger = LogManager.getLogger("myLog");//记录日志

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

        String username=request.getParameter("username");
        String password=request.getParameter("password");

        String vali_user = request.getParameter("ValiImage");
        String vali_sys =  request.getSession().getAttribute("Valicode").toString();
        System.out.println(vali_user);
        System.out.println(vali_sys);
        if(!vali_user.equals(vali_sys)){
            logger.info("用户"+username+"登录失败，原因：验证码输入错误");
            String error="验证码错误";
            request.setAttribute("error",error);
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }
        SqlOperate sqlOperate=new SqlOperate();
//        System.out.print(username);
//        System.out.print(password);

        boolean x= sqlOperate.verify(username,password);
        String error;
        if(!x){
            content="用户"+username+"登录失败，原因：用户名或密码输入错误";
            logger.info(content);
            System.out.println("用户登录失败");

            error="用户名或密码错误";
            request.setAttribute("error",error);
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }
        else{
            content="用户 "+username+"登录成功";
            logger.info(content);
            System.out.println("用户 "+username+"登录成功");
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect(request.getContextPath() + "/home.jsp");
            //request.getRequestDispatcher("home.jsp").forward(request,response);
        }
    }
}
