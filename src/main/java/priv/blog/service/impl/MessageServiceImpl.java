package priv.blog.service.impl;

import priv.blog.dao.MessageMapper;
import priv.blog.dao.UserMapper;
import priv.blog.pojo.Message;
import priv.blog.service.MessageService;

import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/6/1 9:00
 */
public class MessageServiceImpl implements MessageService {
    private MessageMapper messageMapper;
    private UserMapper userMapper;

    public void setMessageMapper(MessageMapper messageMapper) {
        this.messageMapper = messageMapper;
    }

    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public List<Message> extractMessage(int num) {
        return messageMapper.randomlyDrawMessages(num);
    }

    @Override
    public boolean insertSelective(int uuid, String content, String date) {
        userMapper.autoIncrement("message");
        Message message = new Message();
        message.setUuidUser(uuid);
        message.setMessageContent(content);
        message.setMessageDate(date);
        return messageMapper.insertSelective(message) == 1;
    }

    @Override
    public Integer countByUuidUser(Integer uuidUser) {
        return messageMapper.countByUuidUser(uuidUser);
    }

    @Override
    public int deleteByUuidUser(Integer uuidUser) {
        int s;
        try {
            s = messageMapper.deleteByUuidUser(uuidUser);
        } catch (Exception e) {
            return 0;
        }
        return s;
    }

    @Override
    public Integer queryTheNumberOfAllMessages() {
        return messageMapper.queryTheNumberOfAllMessages();
    }
}
