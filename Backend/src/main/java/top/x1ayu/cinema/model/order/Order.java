package top.x1ayu.cinema.model.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private Long id;
    private Long movieId;
    private Long payerId;
    private LocalDateTime orderTime;
    private BigDecimal payAmount;
    private Integer ticketAmount;
    private OrderStatus status;
    private PayMechod payMethod;
    private PriceRule priceRule;
    private LocalDateTime lastChange;


    private List<Ticket> tickets;

    public enum OrderStatus {
        NOT_PAID,
        PAID,
        CHANGE_TICKET,
        CANCELLED,
        REFUNDED,
        CHANGED,
        VERIFIED
    }

    public enum PayMechod {
        CASH,
        ALIPAY,
        WECHAT,
        CREDIT_CARD
    }
}
