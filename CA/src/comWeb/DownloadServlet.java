package comWeb;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        CertificateDao certificateDao = new CertificateDao();
        String filePath = (String)request.getSession().getAttribute("file_path");
        System.out.println("download file!");
        if (filePath == null) {
            System.out.println("no such file!");
            request.setAttribute("msg", "此证书不存在！");
            request.getRequestDispatcher("certificate_info.jsp").forward(request, response);
            return;
        }
        ServletContext servletContext = this.getServletContext();
        response.setHeader("content-type", "application/octet-stream");
        response.setHeader("content-disposition", "attachment;filename=" + "certificate.cer");
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
