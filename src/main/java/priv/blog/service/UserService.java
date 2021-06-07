package priv.blog.service;

import org.apache.ibatis.annotations.Param;
import priv.blog.pojo.User;

import java.util.HashMap;
import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/4/17 16:39
 */
public interface UserService {

    /**
     * 插入用户数据
     *
     * @param record 用户实体
     * @return 是否插入成功
     */
    int insert(User record);

    /**
     * 通过用户名查询用户数据
     *
     * @param name 用户名
     * @return 用户实体
     */
    List<User> selectUser(String name);

    /**
     * 通过uuid查询用户数据
     *
     * @param uuid 唯一id
     * @return 用户实体
     */
    List<User> selectIdUser(int uuid);

    /**
     * 插入用户数据
     *
     * @param record 用户实体
     * @return 是否插入成功
     */
    int insertUser(User record);

    /**
     * 通过uuid更新用户数据
     *
     * @param record 用户实体
     * @return 是否更新成功
     */
    int updateByPrimaryKeySelective(User record);

    /**
     * 通过uuid返回用户实体类
     *
     * @param uuid 用户唯一id
     * @return 用户实体类
     */
    User returnUserData(int uuid);

    /**
     * 管理员登录
     *
     * @param username   用户名
     * @param password   密码
     * @param competence 权限
     * @return 是否登录成功
     */
    boolean administratorLogin(String username, String password, int competence);

    /**
     * 统计全部用户数量
     *
     * @return 数量
     */
    Integer countAll();

    /**
     * 统计权限用户数量
     *
     * @param authority 权限 0，1，2
     * @return 数量
     */
    Integer countByAuthority(Integer authority);

    /**
     * 查询全部用户数据
     *
     * @return 返回list用户数组
     * */
    List<User> selectByAll();

    /**
     * 通过uuid删除用户数据
     *
     * @param uuid uuid
     * @return 是否删除成功
     */
    int deleteByPrimaryKey(Integer uuid);

    /**
     * 通过uuid更新用户密码
     *
     * @param uuid uuid
     * @return hashmap
     */
    HashMap<String, Object> updateUserPassword(int uuid, String pwd);
}
