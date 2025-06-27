package com.mapper;

import com.pojo.BodyComposition;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

public interface BodyCompositionMapper {
@Select("select * from body_composition where id=#{memberId}")
@ResultMap("bodyCompositionMap")
BodyComposition selectBodyCompositionById(int memberId);
@Insert("insert into body_composition values (null,#{memberId},#{recordDate},#{weight},#{height},#{totalWater},#{protein},#{fat},#{muscle},#{basalMetabolicRate},#{visceralFatLevel},#{bodyFatRate},null,null)")
void insertBodyComposition(BodyComposition bodyComposition);

@Delete("delete from body_composition where member_id=#{MemberId}")
void deleteBodyCompositionByMemberId(int MemberId);
}
