package com.mapper;

import com.pojo.DietLog;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface DietLogMapper {
    @Select("select * from diet_logs where id=#{id};")
    DietLog getDietLog(int id);
    @Select("select * from diet_logs where member_id=#{memberId}")
    List<DietLog> selectByMemberId(int memberId);
}
