package comWeb;

import comDao.certificate;
import comUtil.SqlOperate;
import comUtil.Verify;
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
import java.io.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class VerifyServlet extends HttpServlet {
    String content = null;
    private static final long serialVersionUID=1L;
    Logger logger = LogManager.getLogger("myLog");//记录日志

    //public void destroy(){
    // super.destroy();
    //}
    public VerifyServlet(){
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

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                List<FileItem> fileItemList = servletFileUpload.parseRequest(request);
                for (FileItem fileItem : fileItemList) {
                    if (!fileItem.isFormField()) {
                        String file_name = fileItem.getName();
                        logger.info(request.getSession().getAttribute("username")+"验证证书："+file_name);
                        if (file_name.isEmpty()) {
                            return;
                        }
                        InputStream inputStream = fileItem.getInputStream();
                        request.setAttribute("verify_msg",Verify.verify(inputStream));
                        fileItem.delete();
                    }
                }
            } catch (FileUploadException | SQLException e) {
                e.printStackTrace();
            }
        } // END parsing form
        request.setAttribute("select","3");
        request.getRequestDispatcher("SelectServlet?select=3").forward(request,response);
    }
}
