package top.x1ayu.cinema.model.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Ticket {
    private Long id;
    private Long orderId;
    private Long scheduleId;
    private Integer row;
    private Integer column;
    private TicketType ticketType;
    private BigDecimal ticketPrice;
    private TicketStatus ticketStatus;

    public enum TicketStatus {
        ENABLED,
        DISABLED
    }
}
