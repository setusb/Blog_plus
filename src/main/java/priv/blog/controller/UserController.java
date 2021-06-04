package priv.blog.controller;

import com.alibaba.fastjson.JSON;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import priv.blog.pojo.User;
import priv.blog.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/4/17 16:56
 */
@Controller
public class UserController {

    final UserService userService;

    @Autowired
    public UserController(@Qualifier("userServiceImpl") UserService userService) {
        this.userService = userService;
    }

    /**
     * 表单提交验证是否登录成功
     */
    @RequestMapping(path = "/login")
    public String login(@Param("username") String username, @Param("password") String password, Model model) {
        List<User> list = userService.selectUser(username);
        HashMap<String, Object> hashMap = new HashMap<>(10);
        for (User user : list) {
            if (user.getPassword().equals(password)) {
                hashMap.put("user", list);
                model.addAttribute("msg", JSON.toJSONString(hashMap));
                return "redirect:/index.jsp";
            }
        }
        return "redirect:/index.jsp";
    }

    /**
     * 验证用户登录是否成功，返回json字符串用于判断
     */
    @RequestMapping(path = "/userjson", method = RequestMethod.POST)
    @ResponseBody
    public String userJson(HttpServletRequest request, HttpSession session) {
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        HashMap<String, Object> hashMap = new HashMap<>(10);

        List<User> list = userService.selectUser(name);

        for (User user : list) {
            if (user.getPassword().equals(password)) {
                hashMap.put("flag", true);
                hashMap.put("user", list);
                session.setAttribute("loginSuccessful", user.getUuid());
/*                设置session过期时间，单位 '秒'
                session.setMaxInactiveInterval(30 * 60);*/
                return JSON.toJSONString(hashMap);
            }
        }
        hashMap.put("flag", false);
        return JSON.toJSONString(hashMap);
    }

    /**
     * 获取登录用户的json字符串信息
     */
    @RequestMapping(path = "/userInfoJson")
    @ResponseBody
    public String userInfoJson(@Param("uuid") int uuid) {
        HashMap<String, Object> hashMap = new HashMap<>(10);
        hashMap.put("user", userService.selectIdUser(uuid));
        return JSON.toJSONString(hashMap);
    }

    /**
     * 用于跳转注册页面
     */
    @RequestMapping(path = "/requestRegister")
    public String requestRegister() {
        return "home/register";
    }

    /**
     * 注册用户
     */
    @RequestMapping(path = "/registerUser", method = RequestMethod.POST)
    @ResponseBody
    public String registerUser(@Param("username") String username, @Param("nickname") String nickname, @Param("password") String password, @Param("sex") String sex, @Param("userinfo") String userinfo) {
        HashMap<Object, Object> hashMap = new HashMap<>(10);
        User user = new User();

        user.setUsername(username);
        user.setNickname(nickname);
        user.setPassword(password);
        user.setSex(sex);
        user.setUserinfo(userinfo);
        user.setDate(new Date());
        user.setAuthority(0);
        user.setVerification(0);

        int s = userService.insertUser(user);
        if (s == 1) {
            hashMap.put("flag", true);
        } else {
            hashMap.put("flag", false);
        }
        return JSON.toJSONString(hashMap);
    }

    /**
     * 通过获取session请求用户信息
     */
    @RequestMapping(path = "/basicInformation", method = RequestMethod.POST)
    @ResponseBody
    public String basicInformation(HttpSession session) {
        int uuid = (int) session.getAttribute("loginSuccessful");
        HashMap<String, Object> hashMap = new HashMap<>(10);
        hashMap.put("flag", 1);
        hashMap.put("user", userService.selectIdUser(uuid));
        return JSON.toJSONString(hashMap);
    }

    /**
     * 通过获取session的uuid更新用户信息
     */
    @RequestMapping(path = "/updateUuid", method = RequestMethod.POST)
    @ResponseBody
    public String updateUuid(@Param("nickname") String nickname, @Param("sex") String sex, @Param("userinfo") String userinfo, HttpSession session) {
        int uuid = (int) session.getAttribute("loginSuccessful");
        HashMap<String, Object> hashMap = new HashMap<>(10);

        User user = new User();

        user.setUuid(uuid);
        user.setNickname(nickname);
        user.setSex(sex);
        user.setUserinfo(userinfo);

        int s = userService.updateByPrimaryKeySelective(user);

        if (s == 1) {
            hashMap.put("flag", true);
        } else {
            hashMap.put("flag", false);
        }

        return JSON.toJSONString(hashMap);
    }

    /**
     * 发帖信息
     */
    @RequestMapping(path = "/postInformation", method = RequestMethod.POST)
    @ResponseBody
    public String postInformation() {
        HashMap<String, Object> hashMap = new HashMap<>(10);
        hashMap.put("flag", 2);
        return JSON.toJSONString(hashMap);
    }

}
