package priv.blog.dao;

import com.baomidou.mybatisplus.core.injector.methods.SelectList;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.BeforeClass;
import org.junit.Test;
import priv.blog.pojo.Article;
import priv.blog.service.impl.ArticleServiceImpl;

import java.util.Date;
import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/4/20 22:58
 */
public class ArticleMapperTest {

    private static ArticleMapper mapper;

    @BeforeClass
    public static void setUpMybatisDatabase() {
        SqlSessionFactory builder = new SqlSessionFactoryBuilder().build(ArticleMapperTest.class.getClassLoader().getResourceAsStream("mybatisTestConfiguration/ArticleMapperTestConfiguration.xml"));
        //you can use builder.openSession(false) to not commit to database
        mapper = builder.getConfiguration().getMapper(ArticleMapper.class, builder.openSession(true));
    }

    @Test
    public void testInsert() {

        int uuid = 1;
        Article article = new Article();
        article.setUuid(uuid);
        article.setArticleTitle("123");
        article.setArticleTarget("123");
        article.setArticleContent("123");
        article.setArticleBan(0);
        article.setArticleDate(new Date());
        article.setArticlePoints(0);
        mapper.insert(article);
    }

    @Test
    public void testListByAll() {
        List<Article> list = mapper.listByAll();
        for (Article article : list) {
            System.out.println(article.getArticleTitle());
        }
    }

    @Test
    public void testUpdateByPrimaryKeySelective() {

        Article article = new Article();
        article.setArticleUuid(1);
        article.setArticleTitle("123");
        article.setArticleTarget("123");
        article.setArticleContent("123");
        System.out.println(mapper.updateByPrimaryKeySelective(article));
    }

    @Test
    public void testNumberOfArticles() {
        System.out.println(mapper.numberOfArticles(0));
    }

    @Test
    public void testListByAll1() {
        List<Article> list = mapper.listByAll();
        Runnable runnable = () -> {
            for (int i = 0; i < 100; i++) {
                System.out.println("线程运行");
            }
        };

        new Thread(runnable).start();
         list.forEach(article -> System.out.println(article.getArticleTitle()));
    }
}
