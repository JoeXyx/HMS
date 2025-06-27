package com.mapper;

import com.pojo.FamilyMember;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface FamilyMemberMapper {
    @Select("select * from family_members where user_id=#{userId}")
    @ResultMap("familyMemberMap")
    List<FamilyMember> selectFamilyMemberById( int userId);

    @Select("select * from family_members where name=#{name}")
    @ResultMap("familyMemberMap")
    FamilyMember selectByByname(String name);

    @Insert("insert into family_members values (null,#{userId},#{name},#{gender},#{birthday})")
    void insert(FamilyMember fm);

    @Delete("delete from family_members where id=#{id}")
    void deleteFamilyMemberById(int id);
}
