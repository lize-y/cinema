package top.x1ayu.cinema;

import com.mysql.cj.result.LocalDateTimeValueFactory;
import org.junit.jupiter.api.Test;
import org.mockito.internal.matchers.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import top.x1ayu.cinema.mapper.*;
import top.x1ayu.cinema.model.order.Order;
import top.x1ayu.cinema.model.order.PriceRule;


//import java.sql.Date;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
@SpringBootTest
public class MapperTest {

    @Autowired
    private ArtistMapper artistMapper;
    @Autowired
    private HallMapper hallMapper;
    @Autowired
    private SeatMapper seatMapper;
    @Autowired
    private EquipmentTypeMapper equipmentTypeMapper;
    @Autowired
    private EquipmentMapper equipmentMapper;
    @Autowired
    private TicketMapper ticketMapper;
    @Autowired
    private OrderMapper orderMapper;
    @Test
    public void Artist_test() {
        PriceRule priceRule = new PriceRule(new Long(2),"abab",BigDecimal.valueOf(0.60),LocalDateTime.of(2023,5,28,3,55,2),LocalDateTime.now(),null);
//        Order order = new Order(new Long(1),new Long(1),new Long(111),LocalDateTime.now(),BigDecimal.valueOf(333),2, Order.OrderStatus.NOT_PAID, Order.PayMechod.CASH,priceRule,LocalDateTime.now(),null);
        List<Order> order = orderMapper.getByPayerId(new Long(123));
        order.forEach(order1 -> {
            System.out.println(order1.getId());
            System.out.println(order1.getMovieId());
            System.out.println(order1.getPayerId());
            System.out.println(order1.getOrderTime());
            System.out.println(order1.getPayAmount());
            System.out.println(order1.getTicketAmount());
            System.out.println(order1.getPriceRule());
            System.out.println(order1.getPayMethod());
            System.out.println(order1.getStatus());
        });
    }
}
