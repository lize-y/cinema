package top.x1ayu.cinema.model.order;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class TicketType {
    private Long id;
    private String name;
    private BigDecimal discount;
}
