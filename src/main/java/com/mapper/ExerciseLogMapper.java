package com.mapper;

import com.pojo.ExerciseLog;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ExerciseLogMapper {
    @Select("select * from exercise_logs where member_id=#{memberId}")
    @ResultMap("exerciseLogMap")
    List<ExerciseLog> selectAll(int memberId);

    @Insert("insert into exercise_logs values(null,#{memberId},#{date},#{stepCount},#{activityType},#{duration},#{caloriesBurned})")
    void insert(ExerciseLog exerciseLog);
}
