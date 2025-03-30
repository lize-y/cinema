package top.x1ayu.cinema;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import top.x1ayu.cinema.mapper.ArtistMapper;
import top.x1ayu.cinema.mapper.MovieMapper;
import top.x1ayu.cinema.mapper.PermMapper;
import top.x1ayu.cinema.mapper.ScheduleMapper;
import top.x1ayu.cinema.model.movie.Artist;
import top.x1ayu.cinema.model.movie.Movie;
import top.x1ayu.cinema.model.movie.Schedule;
import top.x1ayu.cinema.model.user.Perm;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@SpringBootTest
public class MapperTest {

    private static final Logger log = LoggerFactory.getLogger(MapperTest.class);

    @Autowired
    private ArtistMapper artistMapper;

    @Autowired
    private MovieMapper movieMapper;

    @Autowired
    private ScheduleMapper scheduleMapper;

    @Autowired
    private PermMapper permMapper;
    @Test
    public void Artist_test() {
        Artist artist = new Artist();
        artist.setName("张三");
        artistMapper.insertArtist(artist);
        System.out.println(artist.getId());
    }

    @Test
    public void Movie_test() {
        System.out.println(movieMapper.getMovies(Movie.builder().name("熊").build()));
    }

    @Test
    public void schedule_test() {
        scheduleMapper.updateStatus(2L, Schedule.ScheduleStatus.disabled);
        System.out.println(scheduleMapper.getSchedules(Schedule.builder().id(2L).build()));
    }

    @Test
    public void perm_test() {
        List<Perm> perms = permMapper.getAllPerms();
        if (perms.isEmpty()) {
            log.info("perms is null");
        }
        else {
            for (Perm perm : perms) {
                log.info("perm: {}", perm);
            }
        }
//        Perm perm = Perm.builder().name("test").build();
//        permMapper.insertPerm(perm);
//        log.info("insert perm: {}", perm);
//        log.info("get perm: {}", permMapper.getPermById(perm.getId()));
    }
}
