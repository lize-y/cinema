package top.x1ayu.cinema.model.hall;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Hall {
    private Long id;
    private String name;
    private Integer seating;

    private List<Seat> Seats;
    private List<Equipment> equipment;
}
