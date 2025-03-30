package top.x1ayu.cinema.service;

import top.x1ayu.cinema.model.movie.Movie;

import java.util.List;

public interface MovieService {

    List<Movie> getMovies(Movie params);


}
