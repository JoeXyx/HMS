package com.service;

import com.mapper.UserMapper;
import com.pojo.User;
import com.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class UserService {
    static SqlSessionFactory sqlSessionFactory = SqlSessionFactoryUtils.getSqlSessionFactory();
    public User select(String username, String password) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        User user = userMapper.select(username, password);
        sqlSession.close();
        return user;
    }
    public int selectByUsername(String username) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        User user = userMapper.selectByUsername(username);
        sqlSession.close();
        return user.getId();
    }
    public void update(User user) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        userMapper.update(user);
        sqlSession.commit();
        sqlSession.close();
    }

}
