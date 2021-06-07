package priv.blog.service.impl;

import priv.blog.dao.UserMapper;
import priv.blog.pojo.User;
import priv.blog.service.UserService;

import java.util.HashMap;
import java.util.List;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/4/17 16:40
 */
public class UserServiceImpl implements UserService {

    private UserMapper userMapper;

    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public int insert(User record) {
        return userMapper.insert(record);
    }

    @Override
    public List<User> selectUser(String name) {
        return userMapper.selectByUsername(name);
    }

    @Override
    public List<User> selectIdUser(int uuid) {
        return userMapper.selectByPrimaryKey(uuid);
    }

    @Override
    public int insertUser(User record) {
        int s;
        try {
            userMapper.autoIncrement("user");
            s = userMapper.insert(record);
        } catch (Exception e) {
            return 0;
        }
        return s;
    }

    @Override
    public int updateByPrimaryKeySelective(User record) {
        int s;
        try {
            s = userMapper.updateByPrimaryKeySelective(record);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
        return s;
    }

    @Override
    public User returnUserData(int uuid) {
        return userMapper.returnUserData(uuid);
    }

    @Override
    public boolean administratorLogin(String username, String password, int competence) {

        List<User> list = userMapper.selectAllByUsernameAndPasswordAndAuthority(username, password, competence);

        return !list.isEmpty();
    }

    @Override
    public Integer countAll() {
        return userMapper.countAll();
    }

    @Override
    public int deleteByPrimaryKey(Integer uuid) {
        int s;
        try {
            s = userMapper.deleteByPrimaryKey(uuid);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
        return s;
    }

    @Override
    public HashMap<String, Object> updateUserPassword(int uuid, String pwd) {
        HashMap<String, Object> hashMap = new HashMap<>(1);
        List<User> list = userMapper.selectByPrimaryKey(uuid);
        for (User user : list) {
            user.setPassword(pwd);
            if (userMapper.updateByPrimaryKey(user) > 0) {
                hashMap.put("a", true);
            } else {
                hashMap.put("a", false);
            }
        }
        return hashMap;
    }

    @Override
    public List<User> selectByAll() {
        return userMapper.selectByAll();
    }

    @Override
    public Integer countByAuthority(Integer authority) {
        return userMapper.countByAuthority(authority);
    }
}
