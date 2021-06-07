package priv.blog.service;

import priv.blog.pojo.Message;

import java.util.HashMap;
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


    /**
     * 返回json留言格式数据
     *
     * @return 任意对象
     */
    Object messageList();

    /**
     * 编辑留言内容
     *
     * @param uuid 留言id
     * @param nr   留言内容
     * @return 任意对象
     */
    HashMap<String, Object> messageModify(int uuid, String nr);

    /**
     * 删除留言功能(全部)
     *
     * @param uuid 留言uuid
     * @return Object 对象 (可以使用instanceof检验是不是想要的对象）
     */
    Object critiqueDeleteAll(int uuid);
}
