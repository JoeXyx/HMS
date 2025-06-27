package com.service;

import com.mapper.FoodItemMapper;
import com.pojo.FoodItem;
import com.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class FoodItemService {
    static SqlSessionFactory sqlSessionFactory = SqlSessionFactoryUtils.getSqlSessionFactory();
    public FoodItem selectById(int id){
        SqlSession sqlSession = sqlSessionFactory.openSession();
        FoodItemMapper foodItemMapper = sqlSession.getMapper(FoodItemMapper.class);
        FoodItem item = foodItemMapper.getFoodItem(id);
        sqlSession.close();
        return item;
    }

    public List<FoodItem> selectAll(){
        SqlSession sqlSession = sqlSessionFactory.openSession();
        FoodItemMapper foodItemMapper = sqlSession.getMapper(FoodItemMapper.class);
        List<FoodItem> foodItems = foodItemMapper.selectAll();
        sqlSession.close();
        return foodItems;
    }

    public void insert(FoodItem foodItem){
        SqlSession sqlSession = sqlSessionFactory.openSession();
        FoodItemMapper foodItemMapper = sqlSession.getMapper(FoodItemMapper.class);
        foodItemMapper.insertFoodItem(foodItem);
        sqlSession.commit();
        sqlSession.close();
    }

}
