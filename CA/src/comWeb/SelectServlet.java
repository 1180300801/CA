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
import java.util.List;

public class SelectServlet extends HttpServlet {
    String content = null;
    private static final long serialVersionUID=1L;
    Logger logger = LogManager.getLogger("myLog");//记录日志

    //public void destroy(){
    // super.destroy();
    //}
    public SelectServlet(){

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
        String select = request.getParameter("select");
        SqlOperate sqlOperate=new SqlOperate();
        if(select.equals("1")||select.equals("3")){
            try {
                List<certificate> certificate_list = sqlOperate.selectCertificate();
                request.setAttribute("certificate_list",certificate_list);
                if(select.equals("3")){
                    request.setAttribute("verify_msg",request.getAttribute("verify_msg"));
                }
                request.getRequestDispatcher("test.jsp").forward(request,response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        else if(select.equals("2")){
            try {
                List<certificate> certificate_list = sqlOperate.selectCRL();
                request.setAttribute("CRL_list",certificate_list);
                request.getRequestDispatcher("CRL.jsp").forward(request,response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        else {
            request.setAttribute("download_msg","加载错误");
            request.getRequestDispatcher("home.jsp").forward(request,response);
        }
    }
}
