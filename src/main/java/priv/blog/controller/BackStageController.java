package priv.blog.controller;

import cn.hutool.core.convert.Convert;
import com.alibaba.fastjson.JSON;
import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import oshi.SystemInfo;
import priv.blog.pojo.Article;
import priv.blog.pojo.User;
import priv.blog.service.ArticleService;
import priv.blog.service.MessageService;
import priv.blog.service.UserService;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/6/1 18:11
 */
@Controller
public class BackStageController {
    final
    ArticleService articleService;
    UserService userService;
    MessageService messageService;

    public BackStageController(ArticleService articleService, UserService userService, MessageService messageService) {
        this.articleService = articleService;
        this.userService = userService;
        this.messageService = messageService;
    }

    public static String arrayToString(int[] arr) {
        StringBuffer sb = new StringBuffer();
        sb.append("[");
        for (int i = 0; i < arr.length; i++) {
            if (i == arr.length - 1) {
                sb.append(arr[i] + "]");
            } else {
                sb.append(arr[i]).append(",");
            }
        }
        return sb.toString();
    }

    @GetMapping("/backstagelogin")
    public String backstageLogin() {
        return "backstage/login";
    }

    @GetMapping("/backstageindex")
    public String backstageIndex(Model model, HttpSession session) {
        SystemInfo systemInfo = new SystemInfo();

        int s = Convert.toInt(FileUtils.byteCountToDisplaySize(systemInfo.getHardware().getMemory().getTotal()));
        int i = Convert.toInt(FileUtils.byteCountToDisplaySize(systemInfo.getHardware().getMemory().getAvailable()));
        int b = s - i;

        model.addAttribute("cpuName", systemInfo.getHardware().getProcessor().getName());
        model.addAttribute("memAva", b);
        model.addAttribute("memTao", s);

        int userContAll = userService.countAll();
        int userContAdmin = userService.countByAuthority(2);
        int userCont1 = userService.countByAuthority(1);
        int userCont0 = userService.countByAuthority(0);

        int articleContAll = articleService.countAllArticles();
        int articleContCommon = articleService.countByArticleBan(0);
        int articleContBan = articleService.countByArticleBan(1);

        model.addAttribute("userContAll", userContAll);
        model.addAttribute("userContAdmin", userContAdmin);
        model.addAttribute("userCont1", userCont1);
        model.addAttribute("userCont0", userCont0);

        model.addAttribute("articleContAll", articleContAll);
        model.addAttribute("articleContCommon", articleContCommon);
        model.addAttribute("articleContBan", articleContBan);

        int[] array = {userContAll, articleContAll, articleService.totalNumberOfComments(), messageService.queryTheNumberOfAllMessages()};
        model.addAttribute("tes", arrayToString(array));

        String username = (String) session.getAttribute("admin");
        model.addAttribute("username", username);

        return "backstage/index";
    }

    @PostMapping("/backstagepostlogin")
    @ResponseBody
    public String backstagePostLogin(@Param("username") String username, @Param("pwd") String pwd, HttpSession session) {
        HashMap<String, Object> hashMap = new HashMap<>(10);

        if (userService.administratorLogin(username, pwd, 2)) {
            session.setAttribute("admin", username);
            hashMap.put("a", true);
        } else {
            hashMap.put("a", false);
        }
        return JSON.toJSONString(hashMap);
    }

    @GetMapping("backstageexit")
    public String backstageExit(HttpSession session) {
        if (session.getAttribute("admin") != null) {
            session.removeAttribute("admin");
            return "/backstage/login";
        }
        return "warning/405";
    }

    @GetMapping("backstagelogout")
    public String backstageLogout(HttpSession session) {
        if (session.getAttribute("admin") != null && session.getAttribute("loginSuccessful") != null) {
            session.removeAttribute("admin");
            session.removeAttribute("loginSuccessful");
            return "/home/register";
        }
        return "warning/405";
    }

    @GetMapping("/backstageindex/usermanagement")
    public String userManagement(HttpSession session, Model model) {
        String username = (String) session.getAttribute("admin");
        model.addAttribute("username", username);
        return "backstage/userManagement";
    }

    @GetMapping("/backstageindex/userlist")
    @ResponseBody
    public String userList() {
        HashMap<String, Object> hashMap = new HashMap<>(10);

        List<User> list = userService.selectByAll();

        hashMap.put("code", 0);
        hashMap.put("msg", "");
        hashMap.put("count", userService.countAll());

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        for (User user : list) {
            user.setDatestring(sdf.format(new Date(String.valueOf(user.getDate()))));
            if (user.getAuthority() == 0) {
                user.setAuthoritystring("仅评论");
            } else if (user.getAuthority() == 1) {
                user.setAuthoritystring("可发帖");
            } else if (user.getAuthority() == 2) {
                user.setAuthoritystring("管理员");
            }
            //三表查询
            user.setArticlecount(articleService.numberArtickle(user.getUuid()));
            user.setCritiquecount(articleService.uuiduserComments(user.getUuid()));
            user.setMessagecount(messageService.countByUuidUser(user.getUuid()));
        }
        hashMap.put("data", list);

        return JSON.toJSONString(hashMap);
    }

    @PostMapping("/backstageindex/useradd")
    @ResponseBody
    public String userAdd(@Param("username") String username, @Param("usernick") String usernick, @Param("pwd") String pwd, @Param("gx") int gx, @Param("userinfo") String userinfo, @Param("usersex") String usersex) {
        HashMap<String, Object> hashMap = new HashMap<>(10);

        User u = new User();
        u.setUsername(username);
        u.setNickname(usernick);
        u.setUserinfo(userinfo);
        u.setSex(usersex);
        u.setAuthority(0);
        u.setVerification(gx);
        u.setDate(new Date());
        u.setPassword(pwd);

        int i = userService.insertUser(u);
        if (i > 0) {
            hashMap.put("a", true);
        } else {
            hashMap.put("a", false);
        }

        return JSON.toJSONString(hashMap);
    }

    @PostMapping("/backstageindex/userdelete")
    @ResponseBody
    public String userDelete(@Param("uuid") int uuid) {
        HashMap<String, Object> hashMap = new HashMap<>(10);

        List<User> l = userService.selectIdUser(uuid);

        for (User user : l) {
            if (user.getAuthority() == 2) {
                hashMap.put("b", true);
            } else {
                if (userService.deleteByPrimaryKey(uuid) > 0) {
                    articleService.deleteByUuidUser(user.getUuid());
                    articleService.deleteByUuid(user.getUuid());
                    messageService.deleteByUuidUser(user.getUuid());
                    hashMap.put("a", true);
                } else {
                    hashMap.put("a", false);
                }
                hashMap.put("b", false);
            }
        }

        return JSON.toJSONString(hashMap);
    }

    @PostMapping("/backstageindex/usermodification")
    @ResponseBody
    public String usermMdification(@Param("uuid") int uuid, @Param("username") String username, @Param("usernick") String usernick, @Param("pwd") String pwd, @Param("gx") int gx, @Param("userinfo") String userinfo, @Param("usersex") String usersex) {
        HashMap<String, Object> hashMap = new HashMap<>(10);

        List<User> l = userService.selectIdUser(uuid);
        User u = new User();

        u.setUuid(uuid);
        u.setNickname(usernick);
        u.setPassword(pwd);
        u.setUserinfo(userinfo);
        u.setSex(usersex);
        u.setVerification(gx);

        if (userService.updateByPrimaryKeySelective(u) > 0) {
            hashMap.put("a", true);
        } else {
            hashMap.put("b", true);
        }

        for (User user : l) {
            if (user.getNickname().equals(usernick)) {
                if (user.getPassword().equals(pwd)) {
                    if (user.getVerification().equals(gx)) {
                        if (user.getSex().equals(usersex)) {
                            if (user.getUserinfo().equals(userinfo)) {
                                hashMap.put("a", false);
                            }
                        }
                    }
                }
            }
        }
        return JSON.toJSONString(hashMap);
    }

    @PostMapping("/backstageuser/deletemulti")
    @ResponseBody
    public String userDeleteMulti(@Param("uuid") int uuid) {
        ConcurrentHashMap<String, Object> hashMap = new ConcurrentHashMap<>(10);

        List<User> l = userService.selectIdUser(uuid);

        for (User user : l) {
            if (user.getAuthority() == 2) {
                hashMap.put("c", true);
                return JSON.toJSONString(hashMap);
            } else {
                if (userService.deleteByPrimaryKey(uuid) > 0) {
                    hashMap.put("a", true);
                    articleService.deleteByUuidUser(user.getUuid());
                    articleService.deleteByUuid(user.getUuid());
                    messageService.deleteByUuidUser(user.getUuid());
                } else {
                    try {
                        hashMap.put("a", false);
                        hashMap.put("info", user.getUsername());
                    } catch (Exception e) {
                        e.printStackTrace();
                        hashMap.put("yc", true);
                    }
                }
            }
        }
        return JSON.toJSONString(hashMap);
    }

    @GetMapping("/backstageindex/articlemanagement")
    public String articleManagement(HttpSession session, Model model) {
        String username = (String) session.getAttribute("admin");
        model.addAttribute("username", username);
        return "backstage/articleManagement";
    }

    @GetMapping("/backstageindex/articlelist")
    @ResponseBody
    public String articleList() {
        HashMap<String, Object> hashMap = new HashMap<>(10);

        List<Article> list = articleService.searchAllArticles();

        hashMap.put("code", 0);
        hashMap.put("msg", "");
        hashMap.put("count", articleService.countAllArticles());

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        for (Article article : list) {
            article.setDateString(sdf.format(new Date(String.valueOf(article.getArticleDate()))));
            if (article.getArticleBan() == 0) {
                article.setCheck("通过");
            } else if (article.getArticleBan() == 1) {
                article.setCheck("未批");
            }
            article.setCritiqueCount(articleService.countByUuidArticle(article.getArticleUuid()));
            User user = userService.returnUserData(article.getUuid());
            article.setArticleusername(user.getUsername());
        }
        hashMap.put("data", list);

        return JSON.toJSONString(hashMap);
    }

    @PostMapping("/backstageindex/articlemodification")
    @ResponseBody
    public String artcleModification(@Param("uuid") int uuid, @Param("title") String title, @Param("target") String target, @Param("content") String content) {
        //Hashtable 是线程安全的，但是慢，我之所以使用Hashtable而不是使用ConcurrentHashMap
        //就是因为我想了解下Hashtable
        Hashtable<String, Object> hashtable = new Hashtable<>(5);

        int i = articleService.articleRevision(uuid, title, target, content);

        switch (i) {
            case 0:
                hashtable.put("a", true);
                break;
            case 1:
            default:
                hashtable.put("a", false);
                break;
        }
        return JSON.toJSONString(hashtable);
    }

    @PostMapping("/backstageindex/articledelete")
    @ResponseBody
    public String articleDelete(@Param("uuid") int uuid) {
        HashMap<String, Object> hashMap = new HashMap<>(1);

        if (articleService.deleteArticle(uuid)) {
            hashMap.put("a", true);
        } else {
            hashMap.put("a", false);
        }

        return JSON.toJSONString(hashMap);
    }

    @PostMapping("/backstageindex/articleadd")
    @ResponseBody
    public String articleAdd(HttpSession session, @Param("title") String title, @Param("target") String target, @Param("content") String content) {
        HashMap<String, Object> hashMap = new HashMap<>(1);

        if (articleService.adminAddArticle(title, target, content, session)) {
            hashMap.put("a", true);
        } else {
            hashMap.put("a", false);
        }

        return JSON.toJSONString(hashMap);
    }

    @PostMapping("/backstageindex/articlereview")
    @ResponseBody
    public String articleReview(@Param("uuid") int uuid, @Param("is") int is, @Param("length") int length) {
        HashMap<String, Object> hashMap = new HashMap<>(1);

        if (articleService.articleReviewAndRevision(uuid, is)) {
            hashMap.put("a", true);
        } else {
            hashMap.put("a", false);
        }

        return JSON.toJSONString(hashMap);
    }

    @GetMapping("/backstageindex/critiquemanagement")
    public String critiqueManagement(HttpSession session, Model model) {
        String username = (String) session.getAttribute("admin");
        model.addAttribute("username", username);
        return "backstage/critiqueManagement";
    }

    @GetMapping("/backstageindex/critiquelist")
    @ResponseBody
    public String critiqueList() {
        return JSON.toJSONString(articleService.critiqueList());
    }

    @PostMapping("/backstageindex/critiquemodification")
    @ResponseBody
    public String critiqueModification(@Param("uuid") int uuid, @Param("content") String content) {
        return JSON.toJSONString(articleService.critiqueModification(uuid, content));
    }

    @RequestMapping(path = "/backstageindex/critiqueDeleteAll", method = RequestMethod.POST)
    @ResponseBody
    public String critiqueDeleteAll(@Param("uuid") int uuid) {
        return JSON.toJSONString(articleService.critiqueDeleteAll(uuid));
    }

    @GetMapping("/backstageindex/messagemanagement")
    public String messageManagement(HttpSession session, Model model) {
        String username = (String) session.getAttribute("admin");
        model.addAttribute("username", username);
        return "backstage/messageManagement";
    }

    @GetMapping("/backstageindex/messagelist")
    @ResponseBody
    public String messageList() {
        return JSON.toJSONString(messageService.messageList());
    }

    @PostMapping("/backstageindex/messagemodification")
    @ResponseBody
    public String messageModifyCation(@Param("uuid") int uuid, @Param("nr") String nr) {
        return JSON.toJSONString(messageService.messageModify(uuid, nr));
    }

    @PostMapping("/backstageindex/messageDeleteAll")
    @ResponseBody
    public String messageDeleteAll(@Param("uuid")int uuid) {
        return JSON.toJSONString(messageService.critiqueDeleteAll(uuid));
    }
}
