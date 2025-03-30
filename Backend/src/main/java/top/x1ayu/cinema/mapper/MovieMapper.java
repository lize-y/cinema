package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import top.x1ayu.cinema.model.movie.Movie;

import java.util.List;

@Mapper
public interface MovieMapper {

    List<Movie> getMovies(
            Movie params
    );

}
