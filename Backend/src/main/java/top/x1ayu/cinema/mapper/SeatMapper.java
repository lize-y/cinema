package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.*;
import top.x1ayu.cinema.model.hall.Seat;

import java.util.List;

@Mapper
public interface SeatMapper {
    @Select("SELECT * FROM seat WHERE hall_id = #{id}")
    List<Seat> getSeatByHid(long id);

    @Insert("INSERT INTO seat (hall_id, `row`, start_column, end_column) VALUES "+
            "(#{hallId}, #{row}, #{startColumn}, #{endColumn})")
    int insert(Seat seat);

    @Update("UPDATE seat SET hall_id = #{hallId}, `row` = #{row}, " +
            "start_column = #{startColumn}, end_column = #{endColumn} WHERE id = #{id}")
    int update(Seat seat);
}
