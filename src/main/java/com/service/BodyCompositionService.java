package com.service;

import com.mapper.BodyCompositionMapper;
import com.mapper.FamilyMemberMapper;
import com.pojo.BodyComposition;
import com.pojo.FamilyMember;
import com.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.ArrayList;
import java.util.List;

public class BodyCompositionService {
    static SqlSessionFactory sqlSessionFactory = SqlSessionFactoryUtils.getSqlSessionFactory();
    public List<BodyComposition> getBodyCompositionByFamily(int familyId) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        FamilyMemberMapper familyMemberMapper = sqlSession.getMapper(FamilyMemberMapper.class);
        BodyCompositionMapper bodyCompositionMapper = sqlSession.getMapper(BodyCompositionMapper.class);
        List<FamilyMember> familyMembers = familyMemberMapper.selectFamilyMemberById(familyId);
        List<BodyComposition>membersComposition = new ArrayList<BodyComposition>();
        for (FamilyMember familyMember : familyMembers) {
            membersComposition.add(bodyCompositionMapper.selectBodyCompositionById(familyMember.getId()));
        }
        return membersComposition;
    }
    public void insertBodyComposition(BodyComposition bodyComposition) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        BodyCompositionMapper bodyCompositionMapper = sqlSession.getMapper(BodyCompositionMapper.class);
        bodyCompositionMapper.insertBodyComposition(bodyComposition);
        sqlSession.commit();
        sqlSession.close();
    }
    public void deleteBodyComposition(int memberId) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        BodyCompositionMapper bodyCompositionMapper = sqlSession.getMapper(BodyCompositionMapper.class);
        bodyCompositionMapper.deleteBodyCompositionByMemberId(memberId);
        sqlSession.commit();
        sqlSession.close();
    }
}
