package priv.blog.dao;

import org.apache.ibatis.annotations.Param;
import priv.blog.pojo.Article;

import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/4/20 20:55
 */
public interface ArticleMapper {
    /**
     * 通过文章id删除
     *
     * @param articleUuid 文章id
     * @return 返回是否删除成功
     */
    int deleteByPrimaryKey(Integer articleUuid);

    /**
     * 插入文章内容
     *
     * @param record 文章实体
     * @return 是否插入成功
     */
    int insert(Article record);

    /**
     * 选择性插入文章内容
     *
     * @param record 文章实体
     * @return 是否插入成功
     */
    int insertSelective(Article record);

    /**
     * 通过主键查询文章内容
     *
     * @param articleUuid 文章id
     * @return 文章实体
     */
    Article selectByPrimaryKey(Integer articleUuid);

    /**
     * 通过主键选择性更新文章内容
     *
     * @param record 文章实体
     * @return 是否更新成功
     */
    int updateByPrimaryKeySelective(Article record);

    /**
     * 通过主键更新文章内容
     *
     * @param record 文章实体
     * @return 是否更新成功
     */
    int updateByPrimaryKey(Article record);

    /**
     * 返回所有文章信息
     *
     * @return list数组
     */
    List<Article> listByAll();


    /**
     * 通过匹配uuid来获取文章信息
     *
     * @param uuid 唯一id
     * @return list数组
     */
    List<Article> selectAllByUuid(@Param("uuid") Integer uuid);

    /**
     * 通过匹配文章标题获取文章信息
     *
     * @param articleTitle 标题信息
     * @return list数组
     */
    List<Article> selectAllByArticleTitle(@Param("articleTitle") String articleTitle);

    /**
     * 分页显示文章
     *
     * @param pageMin 最小
     * @param pageMax 最大
     * @param ban     是否封禁
     * @return 文章信息
     */
    List<Article> paginationOfArticles(@Param("pageMin") int pageMin, @Param("pageMax") int pageMax, @Param("ban") int ban);

    /**
     * 文章条数
     *
     * @param ban 文章是否被封禁
     * @return 大小
     */
    Integer numberOfArticles(@Param("ban") int ban);

    /**
     * 查询随机文章
     *
     * @return 文章数据
     */
    List<Article> selectmanArticle();

    /**
     * 分页显示自己的文章
     *
     * @param uuid    用户id
     * @param pageMin 最小
     * @param pageMax 最大
     * @param ban     是否封禁
     * @return 文章信息
     */
    List<Article> paginationOfArticless(@Param("uuid") int uuid, @Param("pageMin") int pageMin, @Param("pageMax") int pageMax, @Param("ban") int ban);

    /**
     * 分页显示自己的文章（无ban)
     *
     * @param uuid    用户id
     * @param pageMin 最小
     * @param pageMax 最大
     * @return 文章信息
     */
    List<Article> paginationOfArticlesss(@Param("uuid") int uuid, @Param("pageMin") int pageMin, @Param("pageMax") int pageMax);

    /**
     * 自己的文章条数
     *
     * @param ban  文章是否被封禁
     * @param uuid 用户id
     * @return 大小
     */
    Integer numberOfArticless(@Param("ban") int ban, @Param("uuid") int uuid);

    /**
     * 自己的文章条数(全显示)
     *
     * @param uuid 用户id
     * @return 大小
     */
    Integer numberArtickle(@Param("uuid") int uuid);

    /**
     * 统计全部文章
     *
     * @return 数量
     */
    Integer countAllArticles();

    /**
     * 统计正常文章
     *
     * @param articleBan 0未封禁，1封禁
     * @return 数量
     */
    Integer countByArticleBan(@Param("articleBan") Integer articleBan);

    /**
     * 通过uuid删除对应下的所有文章
     *
     * @return 是否删除成功
     */
    int deleteByUuid(@Param("uuid") Integer uuid);


}