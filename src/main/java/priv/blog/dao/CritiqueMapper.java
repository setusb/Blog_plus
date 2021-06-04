package priv.blog.dao;

import org.apache.ibatis.annotations.Param;
import priv.blog.pojo.Critique;

import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/5/25 15:40
 */
public interface CritiqueMapper {
    /**
     * 通过文章ID查询评论数据
     *
     * @param uuidArticle 文章id
     * @return 评论数据集合
     */
    List<Critique> queryCommentDataByArticleId(@Param("uuid_article") int uuidArticle);

    /**
     * 选择性插入评论数据
     *
     * @param critique 评论实体
     * @return 是否插入成功
     */
    int insertSelective(Critique critique);

    /**
     * 通过uuid删除评论
     *
     * @param uuidCritique 评论唯一id
     * @return 是否删除成功
     */
    int deleteByUuidCritique(@Param("uuidCritique") Integer uuidCritique);

    /**
     * 通过文章id删除评论
     *
     * @param uuidArticle 文章唯一id
     * @return 是否删除成功
     */
    int deleteByUuidArticle(@Param("uuidArticle") Integer uuidArticle);

    /**
     * 全部评论数量
     *
     * @return 数量
     */
    Integer totalNumberOfComments();

    /**
     * 通过uuid查询用户评论数量
     *
     * @return 数量
     */
    Integer uuiduserComments(@Param("uuid") int uuid);

    /**
     * 通过文章uuid查询文章下的评论数量
     *
     * @return 数量
     */
    Integer countByUuidArticle(@Param("uuidArticle")Integer uuidArticle);



    /**
     * 通过uuid删除用户的所有评论
     *
     * @return 是否删除成功
     */
    int deleteByUuidUser(@Param("uuidUser") Integer uuidUser);

}