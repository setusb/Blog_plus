package priv.blog.pojo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/4/17 16:30
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    /**
     * 唯一id
     */
    private Integer uuid;

    /**
     * 用户名
     */
    private String username;

    /**
     * 昵称
     */
    private String nickname;

    /**
     * 密码
     */
    private String password;

    /**
     * 注册日期
     */
    private Date date;

    /**
     * 性别
     */
    private String sex;

    /**
     * 用户信息
     */
    private String userinfo;

    /**
     * 权限
     */
    private Integer authority;

    /**
     * 贡献点
     */
    private Integer verification;

    /**
     * 日期字符型
     * */
    private String datestring;

    /**
     * 权限字符串
     * */
    private String authoritystring;

    /**
     * 文章数量
     * */
    private int articlecount;

    /**
     * 评论数量
     * */
    private int critiquecount;

    /**
     * 留言数量
     * */
    private int messagecount;

}