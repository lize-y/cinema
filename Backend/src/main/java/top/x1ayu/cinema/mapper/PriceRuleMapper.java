package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.*;
import top.x1ayu.cinema.model.movie.Movie;
import top.x1ayu.cinema.model.order.PriceRule;

import java.util.List;

@Mapper
public interface PriceRuleMapper {
    @Insert("INSERT INTO price_rule (rule_name, discount, start_time, end_time) " +
            "VALUES (#{rule_name},#{discount},#{start_time},#{end_time})")
    int insert(PriceRule priceRule);

    @Update("UPDATE price_rule SET rule_name = #{rule_name}, discount = #{discount}, " +
            "start_time = #{start_time}, end_time = #{end_time} WHERE id = #{id}")
    int update(PriceRule priceRule);
    @Select("SELECT * FROM price_rule WHERE id = #{id}")
    @Results(id = "PRRM",value = {
            @Result(property = "appliedMovie", column = "price_rule_id",
            javaType = List.class,
            many = @Many(select = "getMByPrid"))
    })
    PriceRule getById(@Param("id")Long id);
    //票价策略选电影
    @Select("SELECT m.* FROM movie m " +
            "LEFT JOIN movie_rule mr ON m.id = mr.movie_id " +
            "WHERE mr.rule_id = #{id}")
    List<Movie> getMByPrid(Long id);
    @Select("SELECT * FROM price_rule WHERE rule_name = #{priceRuleName}")
    @ResultMap("PRRM")
    PriceRule getByPRName(String priceRuleName);

    @Delete("DELETE FROM price_rule " +
            "WHERE id = #{id}")
    int deleteById(long id);

    //电影选票价策略
//    @Select("SELECT * FROM movie_rule " +
//            "LEFT JOIN price_rule ON movie_rule.rule_id = price_rule.id " +
//            "LEFT JOIN movie on movie_rule.movie_id = movie.id " +
//            "WHERE movie_id = #{id}")
//    List<PriceRule> getByMid(long id);
}
