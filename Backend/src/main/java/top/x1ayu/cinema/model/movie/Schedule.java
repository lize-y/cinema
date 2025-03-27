package top.x1ayu.cinema.model.movie;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Schedule {
    private Long id;
    private Long movieId;
    private Long hallId;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private BigDecimal price;
    //能否使用折扣，默认为否
    private Boolean discount = false;
    private String detail;
    private ScheduleStatus status;

    public enum ScheduleStatus {
        disabled,
        enabled
    }
}


