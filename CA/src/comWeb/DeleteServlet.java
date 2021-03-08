package comWeb;

import comDao.certificate;
import comUtil.Ende;
import comUtil.KeyUtil;
import comUtil.SqlOperate;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.PrivateKey;
import java.security.interfaces.RSAPrivateKey;
import java.sql.SQLException;
import java.util.Base64;

public class DeleteServlet extends HttpServlet {
    private static final long serialVersionUID=1L;
    Logger logger = LogManager.getLogger("myLog");//记录日志

    //public void destroy(){
    // super.destroy();
    //}
    public DeleteServlet(){

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

        String username=(String)request.getSession().getAttribute("username");
        String delete_password=request.getParameter("delete_password");
        PrivateKey privateKey = null;
        try {
            String sk = KeyUtil.loadPrivateKeyByFile(this.getServletContext().getRealPath("/key/sk.key"));
            privateKey = Ende.loadPrivateKeyByStr(sk);
            delete_password =
                    new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getDecoder().decode(delete_password)), "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        SqlOperate sqlOperate=new SqlOperate();
        if(sqlOperate.verify(username,delete_password)){
            int result = sqlOperate.delete_certificate(username);
            if(result>0){
                logger.info(username+"撤销证书");
                request.setAttribute("delete_msg","撤销证书成功");
                request.getSession().setAttribute("certificate",null);
            }
            else{
                request.setAttribute("delete_msg","撤销证书失败(证书可能不存在)");
            }
        }
        else{
            request.setAttribute("delete_msg","密码错误");
        }
        request.getRequestDispatcher("certificate_info.jsp").forward(request,response);
    }
}
