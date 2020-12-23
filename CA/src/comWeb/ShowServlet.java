package comWeb;

import comDao.certificate;
import comUtil.SqlOperate;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ShowServlet extends HttpServlet {
    String content = null;
    private static final long serialVersionUID=1L;
    Logger logger = (Logger) LogManager.getLogger("myLog");//记录日志

    //public void destroy(){
    // super.destroy();
    //}
    public ShowServlet(){

        super();
    }

    public void doGet(HttpServletRequest request , HttpServletResponse response)
            throws ServletException, IOException {

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String username=(String)request.getSession().getAttribute("username");
        SqlOperate sqlOperate=new SqlOperate();
        try {
            certificate cer = sqlOperate.checkCertificate(username);
            request.getSession().setAttribute("file_path",cer.getFile_path());
            request.setAttribute("certificate",cer);
            request.getRequestDispatcher("certificate_info.jsp").forward(request,response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
