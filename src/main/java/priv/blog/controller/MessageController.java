package priv.blog.controller;

import com.alibaba.fastjson.JSON;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import priv.blog.pojo.Message;
import priv.blog.pojo.MessageDisplay;
import priv.blog.service.MessageService;
import priv.blog.service.UserService;

import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/6/1 8:59
 */
@Controller
public class MessageController {
    final
    MessageService messageService;
    UserService userService;

    public MessageController(MessageService messageService, UserService userService) {
        this.messageService = messageService;
        this.userService = userService;
    }

    @RequestMapping("/message")
    public String messageJump(HttpSession session, Model model) {
        List<Message> list = messageService.extractMessage(7);
        List<MessageDisplay> list1 = new ArrayList<>(7);

        for (Message message : list) {
            /*hashMap.put(userService.returnUserData(message.getUuidUser()).getUsername(), userService.returnUserData(message.getUuidUser()).getNickname());*/
            MessageDisplay messageDisplay = new MessageDisplay();
            messageDisplay.setName(userService.returnUserData(message.getUuidUser()).getNickname());
            messageDisplay.setContent(message.getMessageContent());
            messageDisplay.setDate(message.getMessageDate());
            list1.add(messageDisplay);
        }

        model.addAttribute("msl", list1);
        return "default/message";
    }

    @PostMapping("/messageInsert")
    @ResponseBody
    public String messageInsert(HttpSession session, @Param("textContent") String textContent) {
        HashMap<String, Object> hashMap = new HashMap<>(10);
        int i = (int) session.getAttribute("loginSuccessful");

        if (messageService.insertSelective(i, textContent, new SimpleDateFormat("yyyy-MM-dd").format(new Date()))) {
            hashMap.put("a", true);
        } else {
            hashMap.put("a", false);
        }

        return JSON.toJSONString(hashMap);
    }
}
