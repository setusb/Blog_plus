package priv.blog.service.impl;

import priv.blog.dao.ArticleMapper;
import priv.blog.dao.CritiqueMapper;
import priv.blog.dao.UserMapper;
import priv.blog.pojo.Article;
import priv.blog.pojo.Critique;
import priv.blog.service.ArticleService;

import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/4/20 21:01
 */
public class ArticleServiceImpl implements ArticleService {

    private UserMapper userMapper;
    private ArticleMapper articleMapper;
    private CritiqueMapper critiqueMapper;

    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    public void setArticleMapper(ArticleMapper articleMapper) {
        this.articleMapper = articleMapper;
    }

    public void setCritiqueMapper(CritiqueMapper critiqueMapper) {
        this.critiqueMapper = critiqueMapper;
    }

    @Override
    public int insertContent(Article record) {
        int s;
        userMapper.autoIncrement("article");
        try {
            s = articleMapper.insertSelective(record);
        } catch (Exception e) {
            return 0;
        }
        return s;
    }

    @Override
    public List<Article> listByAll() {
        return articleMapper.listByAll();
    }

    @Override
    public int deleteByUuidArticle(Integer uuidArticle) {
        int s;
        userMapper.autoIncrement("article");
        try {
            s = critiqueMapper.deleteByUuidArticle(uuidArticle);
        } catch (Exception e) {
            return 0;
        }
        return s;
    }

    @Override
    public Integer countAllArticles() {
        return articleMapper.countAllArticles();
    }

    @Override
    public Integer uuiduserComments(int uuid) {
        return critiqueMapper.uuiduserComments(uuid);
    }

    @Override
    public int deleteByUuid(Integer uuid) {
        int s;
        try {
            s = articleMapper.deleteByUuid(uuid);
        } catch (Exception e) {
            return 0;
        }
        return s;
    }

    @Override
    public Integer countByUuidArticle(Integer uuidArticle) {
        return critiqueMapper.countByUuidArticle(uuidArticle);
    }

    @Override
    public List<Article> paginationOfArticlesss(int uuid, int pageMin, int pageMax) {
        return articleMapper.paginationOfArticlesss(uuid, pageMin, pageMax);
    }

    @Override
    public int deleteByUuidUser(Integer uuidUser) {
        int s;
        try {
            s = critiqueMapper.deleteByUuidUser(uuidUser);
        } catch (Exception e) {
            return 0;
        }
        return s;
    }

    @Override
    public Integer numberArtickle(int uuid) {
        return articleMapper.numberArtickle(uuid);
    }

    @Override
    public Integer totalNumberOfComments() {
        return critiqueMapper.totalNumberOfComments();
    }

    @Override
    public Integer countByArticleBan(Integer articleBan) {
        return articleMapper.countByArticleBan(articleBan);
    }

    @Override
    public int deleteByUuidCritique(Integer uuidCritique) {
        int s;
        try {
            s = critiqueMapper.deleteByUuidCritique(uuidCritique);
        } catch (Exception e) {
            return 0;
        }
        return s;
    }

    @Override
    public Integer numberOfArticless(int ban, int uuid) {
        return articleMapper.numberOfArticless(ban,uuid);
    }

    @Override
    public List<Article> paginationOfArticless(int uuid, int pageMin, int pageMax, int ban) {
        return articleMapper.paginationOfArticless(uuid, pageMin, pageMax, ban);
    }

    @Override
    public int insertSelective(Critique critique) {
        int s;
        userMapper.autoIncrement("critique");
        try {
            s = critiqueMapper.insertSelective(critique);
        } catch (Exception e) {
            return 0;
        }
        return s;
    }

    @Override
    public List<Critique> queryCommentDataByArticleId(int uuidArticle) {
        return critiqueMapper.queryCommentDataByArticleId(uuidArticle);
    }

    @Override
    public Article selectByPrimaryKey(Integer articleUuid) {
        return articleMapper.selectByPrimaryKey(articleUuid);
    }

    @Override
    public List<Article> selectAllByUuid(Integer uuid) {
        return articleMapper.selectAllByUuid(uuid);
    }

    @Override
    public int deleteByPrimaryKey(Integer articleUuid) {
        return articleMapper.deleteByPrimaryKey(articleUuid);
    }

    @Override
    public int updateByPrimaryKeySelective(Article record) {
        return articleMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<Article> articleSelectAllByArticleTitle(String articleTitle) {
        return articleMapper.selectAllByArticleTitle(articleTitle);
    }

    @Override
    public List<Article> paginationOfArticles(int pageMin, int pageMax, int ban) {
        return articleMapper.paginationOfArticles(pageMin, pageMax, ban);
    }

    @Override
    public Integer numberOfArticles(int ban) {
        return articleMapper.numberOfArticles(ban);
    }

    @Override
    public List<Article> selectmanArticle() {
        return articleMapper.selectmanArticle();
    }
}
