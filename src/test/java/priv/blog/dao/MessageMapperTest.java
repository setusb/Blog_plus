package priv.blog.dao;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.BeforeClass;
import org.junit.Test;
import priv.blog.pojo.Message;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.Date;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/6/1 15:43
 */
public class MessageMapperTest {
    private static MessageMapper mapper;

    @BeforeClass
    public static void setUpMybatisDatabase() {
        SqlSessionFactory builder = new SqlSessionFactoryBuilder().build(MessageMapperTest.class.getClassLoader().getResourceAsStream("mybatisTestConfiguration/MessageMapperTestConfiguration.xml"));
        //you can use builder.openSession(false) to not commit to database
        mapper = builder.getConfiguration().getMapper(MessageMapper.class, builder.openSession(true));
    }

    @Test
    public void testInsertSelective() {
        Message message = new Message();
        message.setUuidUser(1);
        message.setMessageContent("我是最牛逼的！");
        message.setMessageDate((String) new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        if (mapper.insertSelective(message) == 1) {
            System.out.println("成功！");
        } else {
            System.out.println("失败！");
        }

    }
}
