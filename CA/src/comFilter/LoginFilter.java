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
        // 用户未登陆时，只能访问以下内容：登陆和注册页面，以及登陆和注册对应的servlet，
        // 还有前端页面设计相关的内容，此外还包括CheckServlet
        if (uri.contains("index.jsp") || uri.contains("register.jsp") || uri.contains("/CheckNumServlet")
                || uri.contains("/LoginServlet") || uri.contains("/RegisterServlet") || uri.contains("/images")
                || uri.contains("/js")|| uri.contains("/css") || uri.contains("/CheckServlet")) {
            chain.doFilter(req, resp);
        }
        else {
            Object username = request.getSession().getAttribute("username");
            if (username != null) {
                chain.doFilter(req, resp);
            } else {
                //如果不放行,则跳转到登录页面
                if(!uri.endsWith("/CA/")){
                    request.setAttribute("login_msg", "亲，请先登录");
                }
                request.getRequestDispatcher("/index.jsp").forward(request, resp);
            }
            //            chain.doFilter(req, resp);
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
