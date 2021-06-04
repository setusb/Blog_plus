package priv.blog.service;

import org.apache.ibatis.annotations.Param;
import priv.blog.pojo.Message;

import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/6/1 9:00
 */
public interface MessageService {

    /**
     * 抽取留言
     *
     * @param num 数量
     * @return list数组
     */
    List<Message> extractMessage(int num);

    /**
     * 插入（可选择）的文章
     *
     * @param uuid    id
     * @param content 内容
     * @param date    日期
     * @return 是否插入成功
     */
    boolean insertSelective(int uuid, String content, String date);

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
    Integer countByUuidUser(Integer uuidUser);

    /**
     * 通过uuid删除用户对应下的留言
     *
     * @return 是否删除成功
     */
    int deleteByUuidUser(Integer uuidUser);
}
