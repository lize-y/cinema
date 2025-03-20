package top.x1ayu.cinema;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import top.x1ayu.cinema.mapper.ArtistMapper;
import top.x1ayu.cinema.model.movie.Artist;

@SpringBootTest
public class MapperTest {

    @Autowired
    private ArtistMapper artistMapper;

    @Test
    public void Artist_test() {
        Artist artist = new Artist();
        artist.setName("张三");
        artistMapper.insertArtist(artist);
        System.out.println(artist.getId());
    }
}
