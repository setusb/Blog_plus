package priv.blog.pojo;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author  setusb
 * @date  2021/5/25 15:40
 * @version 1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Critique {
    /**
    * 评论id
    */
    private Integer uuidCritique;

    /**
    * 用户id
    */
    private Integer uuidUser;

    /**
    * 文章id
    */
    private Integer uuidArticle;

    /**
    * 评论内容
    */
    private String contentCritique;

    /**
    * 评论时间
    */
    private Date dateCritique;

    /**
    * 评论是否隐藏
    */
    private Integer hideCritique;
}