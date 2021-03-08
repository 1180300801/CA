package comWeb;

import comUtil.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.PrivateKey;
import java.security.interfaces.RSAPrivateKey;
import java.util.Base64;
import java.util.UUID;

public class RegisterServlet extends HttpServlet {
    String content = null;
    private static final long serialVersionUID=1L;
    Logger logger = (Logger) LogManager.getLogger("myLog");//记录日志

    //public void destroy(){
    // super.destroy();
    //}
    public RegisterServlet(){

        super();
    }

    public void doGet(HttpServletRequest request , HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String idCard = request.getParameter("idCard");
        String password = request.getParameter("password");
        System.out.println(username);
        String sign_username = request.getParameter("sign_username");
        System.out.println(sign_username);
        String sign_idCard = request.getParameter("sign_idCard");
        String sign_password = request.getParameter("sign_password");
        PrivateKey privateKey = null;
        try {
            String sk = KeyUtil.loadPrivateKeyByFile(this.getServletContext().getRealPath("/key/sk.key"));
            privateKey = Ende.loadPrivateKeyByStr(sk);
            username =
                    new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getDecoder().decode(username)), "utf-8");
            idCard =
                    new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getDecoder().decode(idCard)), "utf-8");

            password =
                    new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getDecoder().decode(password)), "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (!SHADigest.getDigest(username).equalsIgnoreCase(sign_username) || !SHADigest.getDigest(idCard).equalsIgnoreCase(sign_idCard)
                || !SHADigest.getDigest(password).equalsIgnoreCase(sign_password)) {
            request.setAttribute("register_msg", "注册失败！报文可能被损坏！");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        String salt = UUID.randomUUID().toString();
        PasswordEncryptor passwordEncryptor = new PasswordEncryptor(salt, "sha-256"); // 生成加密器
        // 加盐加密
        String enc_password = passwordEncryptor.encode(password);
        SqlOperate sqlOperate=new SqlOperate();
        System.out.print(username);
        System.out.print(enc_password);
        boolean x = sqlOperate.insert_to_user(username,idCard,enc_password,salt);
        if(!x){
            content="用户注册失败";
            logger.info(content);
            System.out.println("用户注册失败");

            request.setAttribute("register_msg", "注册失败！用户已存在！");
            request.getRequestDispatcher("register.jsp").forward(request,response);
        }
        else{
            content="用户 "+username+"注册成功";
            logger.info(content);
            System.out.println("用户 "+username+"注册成功");
            request.setAttribute("register_msg", "注册成功！");
            request.getRequestDispatcher("register.jsp").forward(request,response);
        }
    }
}
