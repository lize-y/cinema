package top.x1ayu.cinema.model.movie;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Movie {
    private Long id;
    private String name;
    private String akaName;
    private String intro;
    private String poster_path;
    private LocalDate date;
    private String area;
    private String language;
    private Integer duration;
    private String company;
    private LocalDateTime keyDisabledDate;

    private List<MovieType> movieTypes;
    private List<Artist> directors;
    private List<Artist> Artists;
}
