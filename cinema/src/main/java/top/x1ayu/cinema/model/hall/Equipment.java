package top.x1ayu.cinema.model.hall;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Equipment {
    private Long id;
    private Long hall_id;
    private Long type_id;
    private String name;
    private EquipmentStatus status;
    private LocalDateTime start_time;
    private LocalDateTime last_check;

    public enum EquipmentStatus {
        //正常
        NORMAL,
        //维护中
        MAINTAINED,
        //退役
        DISABLED
    }
}


