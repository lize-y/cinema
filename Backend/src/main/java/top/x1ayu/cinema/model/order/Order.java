package top.x1ayu.cinema.model.order;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class Order {
    private Long id;
    private Long movie_id;
    private Long payer_id;
    private PriceRule PriceRule;
    private LocalDateTime order_time;
    private BigDecimal total_price;
    private Integer ticket_count;
    private OrderStatus status;
    private PlayerType player_type;

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

    public enum PlayerType {
        CASH,
        ALIPAY,
        WECHAT,
        CREDIT_CARD
    }
}
