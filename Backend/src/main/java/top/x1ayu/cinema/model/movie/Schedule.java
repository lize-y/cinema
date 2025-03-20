package top.x1ayu.cinema.model.movie;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Schedule {
    private Long id;
    private Long movie_id;
    private Long hall_id;
    private LocalDateTime start_time;
    private LocalDateTime end_time;
    private BigDecimal price;
    //能否使用折扣，默认为否
    private Boolean discount = false;
    private String detail;
    private ScheduleStatus status;

    public enum ScheduleStatus {
        DISABLED,
        ENABLED
    }
}


