package top.x1ayu.cinema.dto;

import lombok.Builder;
import lombok.Data;
import top.x1ayu.cinema.model.movie.Schedule;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
public class SessionDTO {
    private Long id;
    private String movieName;
    private String hallName;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private BigDecimal price;
}
