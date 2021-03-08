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
import java.sql.SQLException;

public class QueryServlet extends HttpServlet {
    String content = null;
    private static final long serialVersionUID=1L;
    Logger logger = LogManager.getLogger("myLog");//记录日志

    //public void destroy(){
    // super.destroy();
    //}
    public QueryServlet(){

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

        String organization = request.getParameter("organization");
        SqlOperate sqlOperate=new SqlOperate();
        if(organization==null){
            String serial_NUmber = request.getParameter("serial_NUmber");
            try {
                certificate cer = sqlOperate.queryCertificate(serial_NUmber);
                request.getSession().setAttribute("cer_Owner",false);
                request.getSession().setAttribute("certificate",cer);
                request.getRequestDispatcher("certificate_info.jsp").forward(request,response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        else{
            try {
                certificate cer = sqlOperate.queryCerByName(organization);
                request.getSession().setAttribute("cer_Owner",false);
                request.getSession().setAttribute("certificate",cer);
                request.getRequestDispatcher("certificate_info.jsp").forward(request,response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
