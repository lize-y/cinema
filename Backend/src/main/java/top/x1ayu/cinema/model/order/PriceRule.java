package top.x1ayu.cinema.model.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import top.x1ayu.cinema.model.movie.Movie;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PriceRule {
    private Long id;
    private String name;
    private BigDecimal discount;
    private LocalDateTime startTime;
    private LocalDateTime endTime;

    private List<Movie> movies;
}
