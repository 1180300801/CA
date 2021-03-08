package comWeb;

import comUtil.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.PrivateKey;
import java.security.interfaces.RSAPrivateKey;
import java.util.Base64;

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

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String vali_user = request.getParameter("ValiImage");
        String vali_sys =  request.getSession().getAttribute("Valicode").toString();
        System.out.println(vali_user);
        System.out.println(vali_sys);
        if(!vali_user.equals(vali_sys)){
            logger.info("用户"+username+"登录失败，原因：验证码输入错误");
            String error="验证码错误";
            request.setAttribute("login_msg",error);
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }

        System.out.println(username);
        String sign_username = request.getParameter("sign_username");
        System.out.println(sign_username);
        String sign_password = request.getParameter("sign_password");
        PrivateKey privateKey = null;
        try {
            String sk = KeyUtil.loadPrivateKeyByFile(this.getServletContext().getRealPath("/key/sk.key"));
            privateKey = Ende.loadPrivateKeyByStr(sk);
            username =
                    new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getDecoder().decode(username)), "utf-8");
            password =
                    new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getDecoder().decode(password)), "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (!SHADigest.getDigest(username).equalsIgnoreCase(sign_username)
                || !SHADigest.getDigest(password).equalsIgnoreCase(sign_password)) {
            request.setAttribute("login_msg", "登录失败！报文可能被损坏！");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
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
            request.setAttribute("login_msg",error);
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }
        else{
            content="用户 "+username+"登录成功";
            logger.info(content);
            System.out.println("用户 "+username+"登录成功");
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect(request.getContextPath() + "/home.jsp");
        }
    }
}
