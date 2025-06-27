package com.mapper;

import com.pojo.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface UserMapper {
//    根据用户名和密码来查询登录用户
    @Select("select * from users where username=#{username} and password=#{password}")
    User select(@Param("username") String username, @Param("password") String password);

    @Select("select  * from users where username=#{username}")
    User selectByUsername(@Param("username") String username);

    @Select("select * from users where username=#{username}")
    User getIdByUsername(String username);

    @Insert("insert into users values(id,#{username},#{password},null)")
    void insert(User user);

    @Update("update users set password=#{password} where username=#{username}")
    void update(User user);
}
