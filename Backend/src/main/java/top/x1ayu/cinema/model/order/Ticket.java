package top.x1ayu.cinema.model.order;

import java.math.BigDecimal;

public class Ticket {
    private Long id;
    private Long order_id;
    private Long schedule_id;
    private Integer row;
    private Integer column;
    private TicketType TicketType;
    private BigDecimal price;
    private TicketStatus status;

    public enum TicketStatus {
        ENABLED,
        DISABLED
    }
}
