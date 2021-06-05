package priv.blog.pojo;

import jdk.jfr.TransitionFrom;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Transient;
import java.util.Date;

/**
 * @author  setusb
 * @date  2021/4/20 20:55
 * @version 1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
    /**
    * 文章唯一id
    */
    private Integer articleUuid;

    /**
    * 唯一id
    */
    private Integer uuid;

    /**
    * 文章标题
    */
    private String articleTitle;

    /**
    * 文章内容
    */
    private String articleContent;

    /**
    * 文章简介
    */
    private String articleTarget;

    /**
    * 文章点赞
    */
    private Integer articlePoints;

    /**
    * 文章审核
    */
    private Integer articleBan;

    /**
    * 文章时间
    */
    private Date articleDate;

    /**
     * 评论数量
     */
    @Transient
    private Integer critiqueCount;

    /**
     * 字符日期
     */
    @Transient
    private String dateString;

    /**
     * 审核转换字符
     */
    @Transient
    private String check;

    /**
     * 文章发布者
     */
    @Transient
    private String articleusername;
}