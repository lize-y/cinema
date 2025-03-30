package top.x1ayu.cinema.model.hall;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Seat {
    private long id;
    private long hallId;
    private Integer row;
    private Integer startColumn;
    private Integer endColumn;
}
