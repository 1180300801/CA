package comFilter;


import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.swing.*;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 过滤器，只有登录后才可以访问后续资源
 */
@WebFilter("/*")
public class LoginFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        String uri = request.getRequestURI();
        // 用户访问除了资源文件、主页、验证码servlet、登录servlet、注册servlet之外，都要进行登录状态检查
        if (uri.contains("index.jsp") || uri.contains("register.jsp") || uri.contains("/CheckNumServlet") || uri.contains("/LoginServlet") || uri.contains("/RegisterServlet") ) {
            chain.doFilter(req, resp);
        } else {
            Object username = request.getSession().getAttribute("username");
            if (username != null) {
                chain.doFilter(req, resp);
            } else {
                //如果不放行,则跳转到登录页面
                request.setAttribute("login_msg", "亲，请先登录");
                request.getRequestDispatcher("/index.jsp").forward(request, resp);
            }
            //            chain.doFilter(req, resp);
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
