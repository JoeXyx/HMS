package com.service;

import com.mapper.ExerciseLogMapper;
import com.pojo.ExerciseLog;
import com.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class ExerciseLogService {
    static SqlSessionFactory sqlSessionFactory = SqlSessionFactoryUtils.getSqlSessionFactory();
    public List<ExerciseLog> selectAll(int memberId){
        SqlSession sqlSession = sqlSessionFactory.openSession();
        ExerciseLogMapper exerciseLogMapper = sqlSession.getMapper(ExerciseLogMapper.class);
        List<ExerciseLog> logs = exerciseLogMapper.selectAll(memberId);
        sqlSession.close();
        return logs;
    }
    public void insert(ExerciseLog exerciseLog){
        SqlSession sqlSession = sqlSessionFactory.openSession();
        ExerciseLogMapper exerciseLogMapper = sqlSession.getMapper(ExerciseLogMapper.class);
        exerciseLogMapper.insert(exerciseLog);
        sqlSession.commit();
        sqlSession.close();
    }
}
