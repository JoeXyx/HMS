package com.service;

import com.mapper.DietLogMapper;
import com.pojo.DietLog;
import com.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class DietLogService {
    static SqlSessionFactory sqlSessionFactory = SqlSessionFactoryUtils.getSqlSessionFactory();
    public List<DietLog> selectByMemberId(int memberId) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        DietLogMapper dietLogMapper = sqlSession.getMapper(DietLogMapper.class);
        List<DietLog> dietLogs = dietLogMapper.selectByMemberId(memberId);
        sqlSession.close();
        return dietLogs;
    }
}
