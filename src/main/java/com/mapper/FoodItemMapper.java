package com.mapper;

import com.pojo.FoodItem;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface FoodItemMapper {
    @Select("select * from food_items where id=#{id}")
    FoodItem getFoodItem(int id);

    @Select("select * from food_items ")
    @ResultMap("foodItemMap")
    List<FoodItem> selectAll();

    @Insert("insert into food_items values (null,#{name},#{imageUrl},#{unit},#{calories},#{protein},#{carbs},#{fat},#{fiber},#{sugar},#{sodium})")
    void insertFoodItem(FoodItem foodItem);
}
