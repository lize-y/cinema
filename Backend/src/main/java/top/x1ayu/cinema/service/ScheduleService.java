package top.x1ayu.cinema.service;

import top.x1ayu.cinema.model.movie.Schedule;

import java.util.List;

public interface ScheduleService {
    List<Schedule> getSchedules(Schedule params);

    void setSchedules(List<Schedule> schedules);
}
