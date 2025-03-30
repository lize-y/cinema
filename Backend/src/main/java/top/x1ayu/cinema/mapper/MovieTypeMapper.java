package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.*;
import top.x1ayu.cinema.model.movie.Artist;
import top.x1ayu.cinema.model.movie.MovieType;

import java.util.List;

@Mapper
public interface MovieTypeMapper {

    @Select("SELECT * FROM movie_type WHERE id = #{id}")
    MovieType getMovieTypeById(@Param("id") Long id);

    @Select("SELECT * FROM movie_type")
    List<MovieType> getAllMovieTypes();

    @Select("SELECT movie_type.* FROM movie_type " +
            "JOIN movie_type_conn ON movie_type.id = movie_type_conn.type_id " +
            "WHERE movie_type_conn.movie_id = #{id}")
    List<MovieType> getMovieTypesByMovieId(@Param("id") Long id);

    @Insert("INSERT INTO movie_type (name) VALUES (#{name})")
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    int insertMovieType(MovieType movieType);

    @Update("UPDATE movie_type SET name = #{name} WHERE id = #{id}")
    int updateMovieType(MovieType movieType);

    @Delete("DELETE FROM movie_type WHERE id = #{id}")
    int deleteMovieTypeById(@Param("id") Long id);
}
