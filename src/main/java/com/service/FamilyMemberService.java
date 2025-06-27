package com.service;

import com.mapper.FamilyMemberMapper;
import com.pojo.FamilyMember;
import com.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class FamilyMemberService {
    static SqlSessionFactory sqlSessionFactory = SqlSessionFactoryUtils.getSqlSessionFactory();
    public List<FamilyMember> getFamilyMembersByUserId(int userId){
        SqlSession sqlSession = sqlSessionFactory.openSession();
        FamilyMemberMapper familyMemberMapper = sqlSession.getMapper(FamilyMemberMapper.class);
        List<FamilyMember> familyMembers = familyMemberMapper.selectFamilyMemberById(userId);
        sqlSession.close();
        return familyMembers;
    };

    public FamilyMember selectByByname(String name){
        SqlSession sqlSession = sqlSessionFactory.openSession();
        FamilyMemberMapper familyMemberMapper = sqlSession.getMapper(FamilyMemberMapper.class);
        FamilyMember familyMember = familyMemberMapper.selectByByname(name);
        sqlSession.close();
        return familyMember;
    }

    public void addFamilyMember(FamilyMember familyMember){
        FamilyMember fm = new FamilyMember();
        fm.setUserId(familyMember.getUserId());
        SqlSession sqlSession = sqlSessionFactory.openSession();
        FamilyMemberMapper familyMemberMapper = sqlSession.getMapper(FamilyMemberMapper.class);
        familyMemberMapper.insert(familyMember);
        sqlSession.commit();
        sqlSession.close();
    };
    public void deleteFamilyMember(int id){
        SqlSession sqlSession = sqlSessionFactory.openSession();
        FamilyMemberMapper familyMemberMapper = sqlSession.getMapper(FamilyMemberMapper.class);
        familyMemberMapper.deleteFamilyMemberById(id);
        sqlSession.commit();
        sqlSession.close();
    };
}
