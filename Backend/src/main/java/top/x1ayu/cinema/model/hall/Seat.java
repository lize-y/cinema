package top.x1ayu.cinema.model.hall;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Seat {
    private Long id;
    private long hall_id;
    private Integer row;
    private Integer start;
    private Integer end;
}
