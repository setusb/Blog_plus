package priv.blog.dao;

import org.apache.ibatis.annotations.Param;
import priv.blog.pojo.Message;

import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/6/1 9:01
 */
public interface MessageMapper {

    /**
     * 随机查询留言
     *
     * @param num 数量
     * @return list数组
     */
    List<Message> randomlyDrawMessages(@Param("num") int num);


    /**
     * 插入（可选择）的留言
     *
     * @param message 文章
     * @return 是否插入成功
     */
    int insertSelective(Message message);

    /**
     * 查询全部留言数量
     *
     * @return 数量
     */
    Integer queryTheNumberOfAllMessages();

    /**
     * 通过uuid查询用户留言数量
     *
     * @param uuidUser 用户id
     * @return 数量
     */
    Integer countByUuidUser(@Param("uuidUser") Integer uuidUser);


    /**
     * 通过uuid删除用户对应下的留言
     *
     * @return 是否删除成功
     */
    int deleteByUuidUser(@Param("uuidUser") Integer uuidUser);


}