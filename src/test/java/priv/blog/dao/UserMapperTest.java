package priv.blog.dao;

import com.alibaba.fastjson.JSON;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.BeforeClass;
import org.junit.Test;
import priv.blog.pojo.User;

import java.util.HashMap;
import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/4/20 23:35
 */
public class UserMapperTest {
    private static UserMapper mapper;

    @BeforeClass
    public static void setUpMybatisDatabase() {
        SqlSessionFactory builder = new SqlSessionFactoryBuilder().build(UserMapperTest.class.getClassLoader().getResourceAsStream("mybatisTestConfiguration/UserMapperTestConfiguration.xml"));
        //you can use builder.openSession(false) to not commit to database
        mapper = builder.getConfiguration().getMapper(UserMapper.class, builder.openSession(true));
    }

    @Test
    public void testAutoIncrement() {
        mapper.autoIncrement("user");
    }

    @Test
    public void testSelectByAll() {
        List<User> list = mapper.selectByAll();

        HashMap<String, Object> hashMap = new HashMap<>();

        hashMap.put("code", 0);
        hashMap.put("msg", "");
        hashMap.put("count", 1000);
        hashMap.put("data", list);

        System.out.println(JSON.toJSON(hashMap));
    }
}
