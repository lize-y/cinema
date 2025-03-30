package top.x1ayu.cinema.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
public class MovieDTO {
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
    private List<String> movieTypes;
    private List<String> directors;
    private List<String> Artists;
}
