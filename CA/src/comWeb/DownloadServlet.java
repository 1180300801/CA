package comWeb;

import comDao.certificate;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;

public class DownloadServlet extends HttpServlet {

    Logger logger = LogManager.getLogger("myLog");//记录日志

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        CertificateDao certificateDao = new CertificateDao();
        request.setCharacterEncoding("UTF-8");
        String username = (String)request.getSession().getAttribute("username");
        logger.info(username+"下载公钥文件");
        String download = request.getParameter("download");
        if(download.equals("root")){
            String file_path = this.getServletContext().getRealPath("/CA/CA.cer");
            if (file_path == null) {
                System.out.println("no such file!");
                request.setAttribute("download_msg", "下载失败！");
                request.getRequestDispatcher("home.jsp").forward(request, response);
                return;
            }
            response.setHeader("content-type", "application/octet-stream");
            response.setHeader("content-disposition", "attachment;filename=CA.cer");
            FileInputStream fileInputStream = new FileInputStream(file_path);
            ServletOutputStream servletOutputStream = response.getOutputStream();
            byte[] buff = new byte[1024 * 8];
            int len = 0;
            while ((len = fileInputStream.read(buff)) != -1) {
                servletOutputStream.write(buff, 0, len);
            }
            fileInputStream.close();
            return;
        }

        if(download.equals("genRSAkey")){
            String file_path = this.getServletContext().getRealPath("/genKey/genRSAkey.exe");
            if (file_path == null) {
                System.out.println("no such file!");
                request.setAttribute("download_msg", "下载失败！");
                request.getRequestDispatcher("home.jsp").forward(request, response);
                return;
            }
            response.setHeader("content-type", "application/octet-stream");
            response.setHeader("content-disposition", "attachment;filename=genRSAkey.exe");
            FileInputStream fileInputStream = new FileInputStream(file_path);
            ServletOutputStream servletOutputStream = response.getOutputStream();
            byte[] buff = new byte[1024 * 8];
            int len = 0;
            while ((len = fileInputStream.read(buff)) != -1) {
                servletOutputStream.write(buff, 0, len);
            }
            fileInputStream.close();
            return;
        }

        certificate cer = (certificate)request.getSession().getAttribute("certificate");
        String filePath = cer.getFile_path();
        System.out.println("download file!");
        if (filePath == null) {
            System.out.println("no such file!");
            request.setAttribute("msg", "此证书不存在！");
            request.getRequestDispatcher("certificate_info.jsp").forward(request, response);
            return;
        }
        response.setHeader("content-type", "application/octet-stream");
        response.setHeader("content-disposition", "attachment;filename=" +java.net.URLEncoder.encode(cer.getSerial_Number()+".cer", "UTF-8"));
        FileInputStream fileInputStream = new FileInputStream(filePath);
        ServletOutputStream servletOutputStream = response.getOutputStream();
        byte[] buff = new byte[1024 * 8];
        int len = 0;
        while ((len = fileInputStream.read(buff)) != -1) {
            servletOutputStream.write(buff, 0, len);
        }
        fileInputStream.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
