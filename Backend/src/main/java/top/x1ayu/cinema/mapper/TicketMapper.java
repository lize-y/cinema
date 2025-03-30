package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.*;
import top.x1ayu.cinema.model.order.Ticket;

import java.util.List;

@Mapper
public interface TicketMapper {
    @Select("SELECT * FROM order_ticket " +
            "WHERE id = #{id}")
    @ResultMap("ticketRM")
    Ticket getByTid(long Tid);
    @Select("SELECT * FROM order_ticket " +
            "WHERE order_id = #{Oid}")
    @Results(id = "ticketRM",value = {
            @Result(property = "id", column = "id"),
            @Result(property = "orderId", column = "order_id"),
            @Result(property = "scheduleId", column = "schedule_id"),
            @Result(property = "row", column = "row"),
            @Result(property = "column", column = "column"),
            @Result(property = "ticketType", column = "ticket_type"),
            @Result(property = "ticketPrice", column = "ticket_price"),
            @Result(property = "ticketStatus", column = "ticket_status"),
    })
    List<Ticket> getByOid(long Oid);

    @Insert("INSERT INTO order_ticket (order_id, schedule_id, `row`, `column`, ticket_type, ticket_price, ticket_status) " +
            "VALUES (#{orderId},#{scheduleId},#{row},#{column},#{ticketType},#{ticketPrice},#{ticketStatus} )")
    int insert(Ticket ticket);

    @Update("UPDATE order_ticket SET order_id = #{orderId}, schedule_id = #{scheduleId}, " +
            "`row` = #{row}, `column` = #{column}, ticket_type = #{ticketType}, ticket_price = #{ticketPrice}, ticket_status = #{ticketStatus} " +
            "WHERE id = #{id} ")
    int update(Ticket ticket);

    @Delete("DELETE FROM order_ticket " +
            "WHERE id = #{Tid}")
    int delete(long Tid);

}
