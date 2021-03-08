package comWeb;

import comUtil.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.security.PrivateKey;
import java.security.interfaces.RSAPrivateKey;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;

/**
 * 判断证书是否有效
 */
public class CheckServlet extends HttpServlet {
    String content = null;
    private static final long serialVersionUID=1L;
    Logger logger = LogManager.getLogger("myLog");//记录日志

    //public void destroy(){
    // super.destroy();
    //}
    public CheckServlet(){
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

        System.out.println(this.getServletContext().getRealPath("/CheckServlet"));
        String serial_Number = request.getParameter("serial_Number");
        PrivateKey privateKey = null;
        try {
            String sk = KeyUtil.loadPrivateKeyByFile(this.getServletContext().getRealPath("/key/sk.key"));
            privateKey = Ende.loadPrivateKeyByStr(sk);
            serial_Number =
                    new String(Ende.decrypt((RSAPrivateKey) privateKey, Base64.getDecoder().decode(serial_Number)), "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("text/plain; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        String publicKey = KeyUtil.loadPublicKeyByFile(this.getServletContext().getRealPath("/key/pk.key"));
        SqlOperate so = new SqlOperate();
        try {
            if(!so.queryCRL(serial_Number)){
                response.getWriter().write("true");
            }
            else{
                response.getWriter().write("false");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
