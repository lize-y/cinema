package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.*;
import top.x1ayu.cinema.model.hall.EquipType;

import java.util.List;

@Mapper
public interface EquipmentTypeMapper {

//    @Select("SELECT * FROM equip_type WHERE id = #{id}")
//    EquipType getByETid(long id);
    @Select("SELECT * FROM equip_type")
    List<EquipType> getAll();
    @Select("SELECT * FROM equip_type WHERE id = #{id}")
    EquipType getByEid(long id);

    @Insert("INSERT INTO equip_type (name) VALUES (#{name})")
    int insert(EquipType equipType);

    @Update("UPDATE equip_type SET name = #{name} WHERE id = #{id}")
    int update(EquipType equipType);

    @Delete("DELETE FROM equip_type WHERE id = #{id}")
    int deleteById(long id);
}
