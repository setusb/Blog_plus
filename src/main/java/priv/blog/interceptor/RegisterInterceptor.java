package priv.blog.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/4/18 16:27
 */
public class RegisterInterceptor implements HandlerInterceptor {
    @Autowired
    HttpSession session;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (session.getAttribute("loginSuccessful") != null) {
            response.sendRedirect("/index");
            return false;
        } else {
            return true;
        }
    }
}
