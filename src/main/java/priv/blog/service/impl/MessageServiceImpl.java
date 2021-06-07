package priv.blog.service.impl;

import priv.blog.dao.MessageMapper;
import priv.blog.dao.UserMapper;
import priv.blog.pojo.Message;
import priv.blog.service.MessageService;

import java.util.HashMap;
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
    public Object messageList() {
        HashMap<String, Object> hashMap = new HashMap<>(10);
        List<Message> list = messageMapper.selectByAll();

        hashMap.put("code", 0);
        hashMap.put("msg", "");
        hashMap.put("count", messageMapper.queryTheNumberOfAllMessages());

        for (Message message : list) {
            message.setMessageUserName(userMapper.returnUserData(message.getUuidUser()).getUsername());
        }

        hashMap.put("data", list);
        return hashMap;
    }

    @Override
    public Object critiqueDeleteAll(int uuid) {
        return messageMapper.deleteByUuidMessage(uuid) > 0 ? new HashMap<>(1).put("a", true) : new HashMap<>(1).put("a", false);
    }

    @Override
    public HashMap<String, Object> messageModify(int uuid, String nr) {
        HashMap<String, Object> hashMap = new HashMap<>(1);

        if (messageMapper.updateByUuidMessage(nr, uuid) > 0) {
            hashMap.put("a", true);
        } else {
            hashMap.put("a", false);
        }

        return hashMap;
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
