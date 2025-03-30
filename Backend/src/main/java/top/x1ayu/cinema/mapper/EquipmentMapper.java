package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.*;
import top.x1ayu.cinema.model.hall.EquipType;
import top.x1ayu.cinema.model.hall.Equipment;

import java.util.List;

@Mapper
public interface EquipmentMapper {
    @Select("SELECT * FROM equipment WHERE hall_id = #{hallId}")
    @ResultMap("EquipResMap")
    List<Equipment> getAllByHid(long hallId);

    @Select("SELECT * FROM equipment WHERE id = #{id}")
    @Results(id = "EquipResMap",value = {
            @Result(property = "type",column = "type_id",
                    javaType = EquipType.class,
                    one = @One(select = "top.x1ayu.cinema.mapper.EquipmentTypeMapper.getByEid"))
    })
    Equipment getByEid(long id);

    @Insert("INSERT INTO equipment (hall_id, type_id, name, start_time, last_check)"+
            "VALUES (#{hallId}, #{type.id}, #{name}, #{startTime}, #{lastCheck})")
    int insert(Equipment equipment);

    @Update("UPDATE equipment set hall_id = #{hallId}, type_id = #{type.id}, name = #{name},"+
            "status = #{status}, start_time = #{startTime}, last_check = #{lastCheck} WHERE id = #{id}")
    int update(Equipment equipment);

    @Delete("DELETE FROM equipment WHERE id = #{id}")
    int deleteByEid(long id);

    @Delete("DELETE FROM equipment WHERE hall_id = #{hallId}")
    int deleteByHid(long hallId);
}
