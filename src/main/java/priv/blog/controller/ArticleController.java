package priv.blog.controller;

import com.alibaba.fastjson.JSON;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import priv.blog.pojo.*;
import priv.blog.service.ArticleService;
import priv.blog.service.UserService;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/4/20 22:21
 */
@Controller
public class ArticleController {
    final
    ArticleService articleService;
    UserService userService;

    public ArticleController(@Qualifier("articleServiceImpl") ArticleService articleService, @Qualifier("userServiceImpl") UserService userService) {
        this.articleService = articleService;
        this.userService = userService;
    }

    /**
     * 主页加载方法，主页返回数据
     */
    private String homePageLoading(Model model, HttpSession session) {
        /*model.addAttribute("article", articleService.paginationOfArticles(0, 5, 0));*/
        List<Article> article = articleService.selectmanArticle();
        judgeCharacterLengthCycleProcessing(model, article);
        model.addAttribute("numberOfPages", articleService.numberOfArticles(0));
        return judgingTheAdministrator(model, session);
    }

    private String getTheLength(Model model) {
        float num = articleService.numberOfArticles(0);
        float b = 5;
        getDecimalRoundedFloatingPoint(model, num, b);
        return "index";
    }

    private void getDecimalRoundedFloatingPoint(Model model, float num, float b) {
        float a = num / b;

        List<Page> list = new ArrayList<>();

        for (int i = 0; i < Math.ceil(a); i++) {
            Page p = new Page();
            p.setPage(i);
            list.add(p);
        }

        model.addAttribute("articleNum", num);
        model.addAttribute("pageNum", list);
    }

    private void judgeCharacterLengthCycleProcessing(Model model, List<Article> article) {
        for (Article article1 : article) {

            if (article1.getArticleTitle().length() > 20) {
                String as = article1.getArticleTitle().substring(0, 20);
                article1.setArticleTitle(as + "...");
            }

            if (article1.getArticleTarget().length() > 30) {
                String as = article1.getArticleTarget().substring(0, 30);
                article1.setArticleTarget(as + "...");
            }

        }

        model.addAttribute("article", article);
    }

    /**
     * 文章上传
     */
    @RequestMapping(path = "/articlePost", method = RequestMethod.POST)
    @ResponseBody
    public String articlePost(HttpSession session, @Param("articleTitle") String articleTitle, @Param("articleTarget") String articleTarget, @Param("content") String content) {
        HashMap<String, Object> hashMap = new HashMap<>(10);

        int uuid = (int) session.getAttribute("loginSuccessful");

        Article article = new Article();
        article.setUuid(uuid);
        article.setArticleTitle(articleTitle);
        article.setArticleTarget(articleTarget);
        article.setArticleContent(content);
        article.setArticleBan(1);
        article.setArticleDate(new Date());
        article.setArticlePoints(0);

        int s = articleService.insertContent(article);
        if (s == 1) {
            hashMap.put("flag", true);
        } else {
            hashMap.put("flag", false);
        }

        return JSON.toJSONString(hashMap);
    }

    /**
     * 用于跳转主页
     */
    @RequestMapping(path = "/index")
    public String index(Model model, HttpSession session) {
        return homePageLoading(model, session);
    }

    /**
     * 退出登录
     */
    @RequestMapping(path = "/signOut")
    public String signOut(HttpSession session, Model model) {
        /*model.addAttribute("article", articleService.listByAll());*/
        session.removeAttribute("loginSuccessful");
        session.removeAttribute("admin");
        return homePageLoading(model, session);
    }

    /**
     * 默认主页
     */
    @RequestMapping(path = "")
    public String returnIndex(Model model, HttpSession session) {
        /*model.addAttribute("article", articleService.listByAll());*/
        System.out.println("访问了主页");
        return homePageLoading(model, session);
    }

    /**
     * 通过文章id索引文章
     */
    @RequestMapping(path = "/article/{id}")
    public String articleIndex(@PathVariable int id, Model model, HttpSession session) {
        try {
            Article article = articleService.selectByPrimaryKey(id);

            Date date = article.getArticleDate();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
            /*        String dateTime = date.getYear()+"年"+date.getMonth()+"月"+date.getDay()+"日"+date.getHours()+"时"+date.getMinutes()+"分"+date.getSeconds()+"秒";*/
            String dateTime = sdf.format(date);

            int uuid = article.getUuid();

            List<User> list = userService.selectIdUser(uuid);
            String s = null;
            String m = null;
            for (User user : list) {
                s = user.getNickname();
                m = user.getUsername();
            }

            Article article1 = articleService.selectByPrimaryKey(id);

            if (article1.getArticleTitle().length() > 20) {
                String aas = article1.getArticleTitle().substring(0, 20);
                article1.setArticleTitle(aas + "...");
            }


            model.addAttribute("article", article1);
            model.addAttribute("dateTime", dateTime);
            model.addAttribute("user_s", s);
            model.addAttribute("user_m", m);

            List<Critique> listCritique = articleService.queryCommentDataByArticleId(id);
            List<CritiqueDisplay> lists = new ArrayList<>();

            for (Critique critique : listCritique) {

                CritiqueDisplay critiqueDisplay = new CritiqueDisplay();
                critiqueDisplay.setUuidUser(critique.getUuidUser());
                /*                System.out.println(critique.getUuidUser());*/
                critiqueDisplay.setUserName(userService.returnUserData(critique.getUuidUser()).getUsername());
                critiqueDisplay.setNickName(userService.returnUserData(critique.getUuidUser()).getNickname());
                critiqueDisplay.setCritiqueContent(critique.getContentCritique());
                critiqueDisplay.setCritiqueDate(critique.getDateCritique());
                critiqueDisplay.setCommentId(critique.getUuidCritique());
                lists.add(critiqueDisplay);

            }

            /*model.addAttribute("critique",articleService.queryCommentDataByArticleId(id));*/
            model.addAttribute("critique", lists);
            model.addAttribute("currentUserId", session.getAttribute("loginSuccessful"));

            int usid = (int) session.getAttribute("loginSuccessful");

            model.addAttribute("userinfos", userService.returnUserData(usid));

            return "default/articleinfo";
        } catch (Exception e) {
            e.printStackTrace();
            return "warning/404";
        }
    }

    /**
     * 用于跳转用户信息修改
     * <p>
     * 废弃！
     * <p>
     * 重新启动！！！
     */
    @RequestMapping(path = "/default/userinfo")
    public String userInfo(HttpSession session, Model model) {
        int uuid = (int) session.getAttribute("loginSuccessful");


        List<Article> list = articleService.selectAllByUuid(uuid);
        /*        List<Article> list = articleService.paginationOfArticless(uuid, 0, 10, 0);*/

        return titleLengthLimit(model, uuid, list);
    }

    private String titleLengthLimit(Model model, int uuid, List<Article> list) {
        for (Article article : list) {
            if (article.getArticleTitle().length() > 20) {
                String aas = article.getArticleTitle().substring(0, 20);
                article.setArticleTitle(aas + "...");
            }
            article.setCritiqueCount(articleService.countByUuidArticle(article.getArticleUuid()));
        }

        model.addAttribute("article", list);
        List<User> user = userService.selectIdUser(uuid);
        int ast = 0;
        for (User user1 : user) {
            ast = user1.getAuthority();
        }
        model.addAttribute("qxdj", ast);

        model.addAttribute("numberOfPages", articleService.numberOfArticless(0, uuid));

        float num = articleService.numberOfArticless(0, uuid);
        float b = 10;
        getDecimalRoundedFloatingPoint(model, num, b);


        return "default/userinfo";
    }

    /**
     * 删除文章
     */
    @RequestMapping(path = "/default/articleDelete", method = RequestMethod.POST)
    @ResponseBody
    public String articleDelete(@Param("uuid") int uuid) {
        HashMap<String, Object> hashMap = new HashMap<>(10);

        articleService.deleteByUuidArticle(uuid);
        int s = articleService.deleteByPrimaryKey(uuid);

        if (s == 1) {
            articleService.deleteByUuidArticle(uuid);
            hashMap.put("flag", true);
        } else {
            hashMap.put("flag", false);
        }

        return JSON.toJSONString(hashMap);
    }

    /**
     * 编辑发帖资源
     */
    @RequestMapping(path = "/default/updateArticle/{id}")
    public String articleUpdate(@PathVariable int id, Model model) {
        Article article = articleService.selectByPrimaryKey(id);
        if (article == null) {
            return "warning/404";
        } else {
            model.addAttribute("article", article);
        }
        return "default/articleupdate";
    }

    /**
     * 更新发帖资源
     */
    @RequestMapping(path = "/default/updateArticles/{id}", method = RequestMethod.POST)
    @ResponseBody
    public String articleUpdate(@PathVariable int id, @Param("articleTitle") String articleTitle, @Param("articleTarget") String articleTarget, @Param("content") String content) {
        HashMap<String, Object> hashMap = new HashMap<>(10);

        Article article = new Article();

        /*System.out.println("文章id: "+id+"\n文章标题: "+articleTitle+"\n文章简介: "+articleTarget+"\n文章内容: "+content);*/

        article.setArticleUuid(id);
        article.setArticleTitle(articleTitle);
        article.setArticleTarget(articleTarget);
        article.setArticleContent(content);

        if (articleService.updateByPrimaryKeySelective(article) == 1) {
            hashMap.put("flag", true);
        } else {
            hashMap.put("flag", false);
        }

        return JSON.toJSONString(hashMap);
    }

    /**
     * 搜索文章
     */
    @RequestMapping(path = "/search/{title}")
    public String search(@PathVariable String title, Model model, HttpSession session) {

        List<Article> list = articleService.articleSelectAllByArticleTitle(title);

        for (Article article : list) {
            if (article.getArticleTitle().length() > 20) {
                String aas = article.getArticleTitle().substring(0, 20);
                article.setArticleTitle(aas + "...");
            }

            if (article.getArticleTarget().length() > 20) {
                String aas = article.getArticleTarget().substring(0, 20);
                article.setArticleTarget(aas + "...");
            }
        }

        if (session.getAttribute("loginSuccessful") != null) {
            int i = (int) session.getAttribute("loginSuccessful");
            List<User> lists = userService.selectIdUser(i);
            int s = 0;
            for (User user : lists) {
                s = user.getAuthority();
            }
            model.addAttribute("abc", s);
        }

        if (list.isEmpty()) {
            model.addAttribute("flag", "1");
            return "default/search";
        }

        model.addAttribute("article", list);

        return "default/search";
    }

    /**
     * 文章点赞
     */
    @RequestMapping(path = "/likePlusOne", method = RequestMethod.POST)
    @ResponseBody
    public String likePlusOne(@Param("uuid") int uuid) {
        HashMap<String, Object> hashMap = new HashMap<>(10);

        Article article = articleService.selectByPrimaryKey(uuid);
        Article ae = new Article();

        ae.setArticleUuid(uuid);
        ae.setArticlePoints(article.getArticlePoints() + 1);

        hashMap.put("flag", article.getArticlePoints() + 1);

        articleService.updateByPrimaryKeySelective(ae);

        return JSON.toJSONString(hashMap);
    }

    /**
     * 分页查询
     */
    @RequestMapping(path = "/pageArticle/{page}", method = RequestMethod.GET)
    public String pageArticle(@PathVariable("page") int pageMin, Model m, HttpSession session) {
        int as = pageMin * 5;

        List<Article> article = articleService.paginationOfArticles(as, 5, 0);
        judgeCharacterLengthCycleProcessing(m, article);

        return judgingTheAdministrator(m, session);
    }

    private String judgingTheAdministrator(Model m, HttpSession session) {
        if (session.getAttribute("loginSuccessful") != null) {
            int i = (int) session.getAttribute("loginSuccessful");
            List<User> list = userService.selectIdUser(i);
            int s = 0;
            for (User user : list) {
                s = user.getAuthority();
            }
            m.addAttribute("abc", s);
        }

        return getTheLength(m);
    }

    /**
     * 提交评论
     */
    @RequestMapping(path = "/submitComments", method = RequestMethod.POST)
    @ResponseBody
    public String submitComments(@Param("content") String content, @Param("uuidArticle") int uuidArticle, @Param("uuidUser") int uuidUser) {
        /*System.out.println(content+"\t"+uuidArticle+"\t"+uuidUser);*/

        Critique critique = new Critique();
        critique.setUuidUser(uuidUser);
        critique.setUuidArticle(uuidArticle);
        critique.setContentCritique(content);
        critique.setDateCritique(new Date());
        critique.setHideCritique(0);

        HashMap<Object, Object> hashMap = new HashMap<>(10);

        if (articleService.insertSelective(critique) != 0) {
            hashMap.put("a", true);
        } else {
            hashMap.put("a", false);
        }

        return JSON.toJSONString(hashMap);
    }


    /**
     * 修改信息分页查询
     * <p>
     * 废弃
     */
    @RequestMapping(path = "/pageArticles/{page}", method = RequestMethod.GET)
    public String pageArticles(@PathVariable("page") int pageMin, Model model, HttpSession session) {
/*        int uuid = (int) session.getAttribute("loginSuccessful");

        int as = pageMin * 10;

        List<Article> list = articleService.paginationOfArticlesss(uuid, as, 10);

        return titleLengthLimit(model, uuid, list);*/
        return "warning/101";
    }

    /**
     * 删除评论
     */
    @RequestMapping(path = "/pageDelete", method = RequestMethod.POST)
    @ResponseBody
    public String pageArticles(@Param("page") int page) {
        HashMap<Object, Object> hashMap = new HashMap<>(10);

        if (articleService.deleteByUuidCritique(page) != 0) {
            hashMap.put("as", true);
        } else {
            hashMap.put("as", false);
        }

        return JSON.toJSONString(hashMap);
    }
}
