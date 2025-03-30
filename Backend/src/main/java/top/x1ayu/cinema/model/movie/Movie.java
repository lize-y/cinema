package top.x1ayu.cinema.model.movie;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import top.x1ayu.cinema.model.order.PriceRule;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Movie {
    private Long id;
    private String name;
    private String akaName;
    private String intro;
    private String posterPath;
    private LocalDate date;
    private String area;
    private String language;
    private Integer duration;
    private String company;
    private LocalDateTime keyDisabledDate;

    // 非数据库字段
    private List<MovieType> movieTypes;
    private List<Artist> directors;
    private List<Artist> Artists;
    private List<PriceRule> priceRules;
}
