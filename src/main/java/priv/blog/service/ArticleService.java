package priv.blog.service;

import org.apache.ibatis.annotations.Param;
import priv.blog.pojo.Article;
import priv.blog.pojo.Critique;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/4/20 21:01
 */
public interface ArticleService {

    /**
     * 插入文章内容
     *
     * @param record 文章实体
     * @return 是否插入成功
     */
    int insertContent(Article record);

    /**
     * 返回所有文章信息
     *
     * @return list数组
     */
    List<Article> listByAll();

    /**
     * 通过主键查询文章内容
     *
     * @param articleUuid 文章id
     * @return 文章实体
     */
    Article selectByPrimaryKey(Integer articleUuid);

    /**
     * 通过匹配uuid来获取文章信息
     *
     * @param uuid 唯一id
     * @return list数组
     */
    List<Article> selectAllByUuid(Integer uuid);

    /**
     * 通过文章id删除
     *
     * @param articleUuid 文章id
     * @return 返回是否删除成功
     */
    int deleteByPrimaryKey(Integer articleUuid);

    /**
     * 通过主键选择性更新文章内容
     *
     * @param record 文章实体
     * @return 是否更新成功
     */
    int updateByPrimaryKeySelective(Article record);

    /**
     * 通过匹配文章标题获取文章信息
     *
     * @param articleTitle 标题信息
     * @return list数组
     */
    List<Article> articleSelectAllByArticleTitle(String articleTitle);

    /**
     * 分页显示文章
     *
     * @param pageMin 最小
     * @param pageMax 最大
     * @param ban     是否封禁
     * @return 文章信息
     */
    List<Article> paginationOfArticles(int pageMin, int pageMax, int ban);

    /**
     * 文章条数
     *
     * @param ban 文章是否被封禁
     * @return 大小
     */
    Integer numberOfArticles(int ban);

    /**
     * 查询随机文章
     *
     * @return 文章数据
     */
    List<Article> selectmanArticle();

    /**
     * 通过文章ID查询评论数据
     *
     * @param uuidArticle 文章id
     * @return 评论数据集合
     */
    List<Critique> queryCommentDataByArticleId(int uuidArticle);

    /**
     * 选择性插入评论数据
     *
     * @param critique 评论实体
     * @return 是否插入成功
     */
    int insertSelective(Critique critique);

    /**
     * 分页显示自己的文章
     *
     * @param uuid    用户id
     * @param pageMin 最小
     * @param pageMax 最大
     * @param ban     是否封禁
     * @return 文章信息
     */
    List<Article> paginationOfArticless(int uuid, int pageMin, int pageMax, int ban);

    /**
     * 分页显示自己的文章（无ban）
     *
     * @param uuid    用户id
     * @param pageMin 最小
     * @param pageMax 最大
     * @return 文章信息
     */
    List<Article> paginationOfArticlesss(int uuid, int pageMin, int pageMax);

    /**
     * 自己的文章条数
     *
     * @param ban  文章是否被封禁
     * @param uuid 用户id
     * @return 大小
     */
    Integer numberOfArticless(int ban, int uuid);

    /**
     * 通过uuid删除评论
     *
     * @param uuidCritique 评论唯一id
     * @return 是否删除成功
     */
    int deleteByUuidCritique(Integer uuidCritique);

    /**
     * 通过文章id删除评论
     *
     * @param uuidArticle 文章唯一id
     * @return 是否删除成功
     */
    int deleteByUuidArticle(Integer uuidArticle);

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
    Integer countByArticleBan(Integer articleBan);

    /**
     * 全部评论数量
     *
     * @return 数量
     */
    Integer totalNumberOfComments();

    /**
     * 自己的文章条数(全显示)
     *
     * @param uuid 用户id
     * @return 大小
     */
    Integer numberArtickle(@Param("uuid") int uuid);

    /**
     * 通过uuid查询用户评论数量
     *
     * @return 数量
     */
    Integer uuiduserComments(int uuid);

    /**
     * 通过uuid删除对应下的所有文章
     *
     * @return 是否删除成功
     */
    int deleteByUuid(Integer uuid);

    /**
     * 通过uuid删除用户的所有评论
     *
     * @return 是否删除成功
     */
    int deleteByUuidUser(Integer uuidUser);

    /**
     * 通过文章uuid查询文章下的评论数量
     *
     * @return 数量
     */
    Integer countByUuidArticle(Integer uuidArticle);

    /**
     * 查询全部文章（无ban)
     *
     * @return list数组
     */
    List<Article> searchAllArticles();

    /**
     * 文章修改功能
     *
     * @param uuid    文章uuid
     * @param title   文章标题
     * @param target  文章简介
     * @param content 文章内容
     * @return 0，1，2数字判断
     */
    Integer articleRevision(int uuid, String title, String target, String content);

    /**
     * 文章删除功能（单个）
     *
     * @param uuid 文章uuid
     * @return 是否删除成功
     */
    boolean deleteArticle(int uuid);

    /**
     * 文章添加功能（单个）
     *
     * @param title   标题
     * @param target  简介
     * @param content 内容
     * @param session session
     * @return 是否添加成功
     */
    boolean adminAddArticle(String title, String target, String content, HttpSession session);

    /**
     * 文章审核功能
     *
     * @param uuid 文章uuid
     * @param is   0 通过 1 未批
     * @return 是否审核成功
     */
    boolean articleReviewAndRevision(int uuid, int is);


    /**
     * 评论转换json在后台表格输出
     *
     * @return hashmap
     */
    HashMap<String, Object> critiqueList();

    /**
     * 修改评论功能
     *
     * @param uuid 评论uuid
     * @param nr   评论内容
     * @return hashmap
     */
    HashMap<String, Object> critiqueModification(int uuid, String nr);

    /**
     * 删除评论功能(全部)
     *
     * @param uuid 评论uuid
     * @return Object 对象 (可以使用instanceof检验是不是想要的对象）
     */
    Object critiqueDeleteAll(int uuid);
}
