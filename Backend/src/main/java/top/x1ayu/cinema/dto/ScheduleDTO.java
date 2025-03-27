package top.x1ayu.cinema.dto;

import lombok.Builder;
import lombok.Data;
import top.x1ayu.cinema.model.movie.Schedule;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
public class ScheduleDTO {
    private Long id;
    private Long movieId;
    private Long hallId;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private BigDecimal price;
    private Boolean discount;
    private String detail;
    private Schedule.ScheduleStatus status;
}
