package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.*;
import top.x1ayu.cinema.model.movie.Artist;

import java.util.List;

@Mapper
public interface ArtistMapper {

    @Select("SELECT * FROM artist WHERE id = #{id}")
    Artist getArtistById(@Param("id") Long id);

    @Select("SELECT * FROM artist")
    List<Artist> getAllArtists();

    @Insert("INSERT INTO artist (name) VALUES (#{name})")
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    int insertArtist(Artist artist);

    @Update("UPDATE artist SET name = #{name} WHERE id = #{id}")
    int updateArtist(Artist artist);

    @Delete("DELETE FROM artist WHERE id = #{id}")
    int deleteArtistById(@Param("id") Long id);
}
