package com.handler;

import com.pojo.MealType;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.*;

public class MealTypeHandler extends BaseTypeHandler<MealType> {

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, MealType parameter, JdbcType jdbcType) throws SQLException {
        ps.setString(i, parameter.getLabel());  // 存入数据库的中文
    }

    @Override
    public MealType getNullableResult(ResultSet rs, String columnName) throws SQLException {
        return MealType.fromLabel(rs.getString(columnName));
    }

    @Override
    public MealType getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        return MealType.fromLabel(rs.getString(columnIndex));
    }

    @Override
    public MealType getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        return MealType.fromLabel(cs.getString(columnIndex));
    }
}
