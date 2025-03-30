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
    private Long hallId;
    private EquipType type;
    private String name;
    private EquipmentStatus status;
    private LocalDateTime startTime;
    private LocalDateTime lastCheck;

    public enum EquipmentStatus{
        //正常
        NORMAL,
        //维护中
        MAINTAINED,
        //退役
        DISABLED
    }
}


