package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.*;
import top.x1ayu.cinema.model.order.Order;
import top.x1ayu.cinema.model.order.PriceRule;

import java.util.List;

@Mapper
public interface OrderMapper {
    //订单号选
    @Select("SELECT * FROM `order` " +
            "WHERE id = #{id}")
    @Results(id = "ORM",value = {
            @Result(property = "id", column = "id"),
            @Result(property = "movieId", column = "movie_id"),
            @Result(property = "payerId", column = "payer_id"),
            @Result(property = "orderTime", column = "order_time"),
            @Result(property = "totalPrice", column = "pay_amount"),
            @Result(property = "ticketCount", column = "ticket_amount"),
            @Result(property = "status", column = "status"),
            @Result(property = "payMethod", column = "pay_method"),
            @Result(property = "priceRule", column = "price_rule_name",
                javaType = PriceRule.class,
                one = @One(select = "top.x1ayu.cinema.mapper.getByPRName")),
    })
    Order getById(@Param("id")Long id);
    //用户选
    @Select("SELECT * FROM `order` " +
            "WHERE payer_id = #{PayerId}")
    @ResultMap("ORM")
    List<Order> getByPayerId(Long PayerId);
    //
    @Insert("INSERT INTO `order` (movie_id, payer_id, order_time, pay_amount, ticket_amount, price_rule_name, pay_method, status) " +
            "VALUES (#{movieId},#{payerId},#{orderTime},#{payAmount},#{ticketAmount},#{priceRule.name},#{payMethod},#{status})")
    int insert(Order order);

    @Update("UPDATE `order` SET movie_id = #{movieId}, payer_id = #{payerId}, order_time = #{orderTime},pay_amount = #{payAmount},ticket_amount = #{ticketAmount}, price_rule_name = #{priceRule.name}, pay_method = #{payMechod}, status = #{status} " +
            "WHERE id = #{id}")
    int update(Order order);

    @Delete("DELETE FROM `order` " +
            "WHERE id = #{id}")
    int delete(Long id);
}
