package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.*;
import top.x1ayu.cinema.model.hall.Hall;

import java.util.List;

@Mapper
public interface HallMapper {

    @Select("SELECT * FROM hall")
    @ResultMap("hallRes")
    List<Hall> getAll();

    @Select("SELECT * FROM hall")
    @Results(id = "hallRes",value = {
        @Result(id = true,property = "id",column = "id"),
        @Result(property = "name",column = "name"),
        @Result(property = "seating",column = "seating"),
        @Result(property = "Seats",column = "id",
            javaType = List.class,
            many = @Many(select = "top.x1ayu.cinema.mapper.SeatMapper.getSeatByHid")),
        @Result(property = "Equipments",column = "id",
            javaType = List.class,
            many = @Many(select = "top.x1ayu.cinema.mapper.EquipmentMapper.getEuipmentByHid"))
    })
    Hall getDetailById(@Param("id")Long id);

    @Insert("INSERT INTO hall (name, seating) VALUES (#{name}, #{seating})")
    int insert(Hall hall);


    @Update("UPDATE hall SET name = #{name}, seating = #{seating} WHERE id = #{id}")
    int update(Hall hall);

    @Delete("DELETE FROM hall WHERE id = #{id}")
    int deleteById(Long id);
    //对设备和seat在service层再批处理
}
