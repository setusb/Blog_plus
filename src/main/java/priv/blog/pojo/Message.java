package priv.blog.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Transient;

/**
 * @author  setusb
 * @date  2021/6/1 9:01
 * @version 1.0
 */
/**
    * 留言
    */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {
    /**
    * 留言id
    */
    private Integer uuidMessage;

    /**
    * 用户id
    */
    private Integer uuidUser;

    /**
    * 留言内容
    */
    private String messageContent;

    /**
    * 留言时间
    */
    private String messageDate;

    /**
     * 留言用户名
     */
    @Transient
    private String messageUserName;
}