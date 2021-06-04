package priv.blog.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import priv.blog.pojo.User;
import priv.blog.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/6/1 20:03
 */
public class BackStageLogin implements HandlerInterceptor {
    @Autowired
    HttpSession session;
    @Autowired
    UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (session.getAttribute("loginSuccessful") != null) {
            int i = (int) session.getAttribute("loginSuccessful");
            List<User> list = userService.selectIdUser(i);
            int auth = 0;
            for (User user : list) {
                auth = user.getAuthority();
            }
            if (auth == 2) {
                if (session.getAttribute("admin") == null) {
                    return true;
                } else {
                    response.sendRedirect("/backstageindex");
                    return false;
                }
            } else {
                response.sendRedirect("/insufficientpermissions");
                return false;
            }
        } else {
            response.sendRedirect("/insufficientpermissions");
            return false;
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
    }
}
