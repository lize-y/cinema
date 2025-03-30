package top.x1ayu.cinema.service;

import org.springframework.stereotype.Service;
import top.x1ayu.cinema.mapper.HallMapper;
import top.x1ayu.cinema.model.hall.Hall;

@Service
public interface HallService extends HallMapper {
    int insert(Hall hall);
}
