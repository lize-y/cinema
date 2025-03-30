package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import top.x1ayu.cinema.model.movie.Schedule;

import java.util.List;

@Mapper
public interface ScheduleMapper {

    List<Schedule> getSchedules(
            Schedule params
    );

    void insert(Schedule schedule);

    int update(Schedule schedule);

    int updateStatus(
            @Param("id") Long id,
            @Param("status") Schedule.ScheduleStatus status
    );

    @Delete("DELETE FROM schedule WHERE id = #{id}")
    int deleteScheduleById(@Param("id") Long id);

}
