package top.x1ayu.cinema.service;

import jakarta.annotation.Resource;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.x1ayu.cinema.mapper.EquipmentMapper;
import top.x1ayu.cinema.mapper.HallMapper;
import top.x1ayu.cinema.mapper.SeatMapper;
import top.x1ayu.cinema.model.hall.Equipment;
import top.x1ayu.cinema.model.hall.Hall;
import top.x1ayu.cinema.model.hall.Seat;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class HallServiceImpl implements HallService{
    @Autowired
    HallMapper hallMapper;
    @Autowired
    SeatMapper seatMapper;
    @Autowired
    EquipmentMapper equipmentMapper;
    @Resource
    private SqlSessionFactory sqlSessionFactory;

    @Override
    public List<Hall> getAll() {
        return hallMapper.getAll();
    }

    @Override
    public Hall getDetailById(Long id) {

        return hallMapper.getDetailById(id);
    }

    public int insert(Hall hall){
        List<Seat> seatList = hall.getSeats();
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH,false);
        Integer successNum = 0;
        try {
            seatList.stream().forEach(seat -> {
                seatMapper.insert(seat);
            });
        }catch (Exception e){
            sqlSession.rollback();
            sqlSession.close();
            return 0;
        }
        return 1;
    }

    @Override
    public int update(Hall hall) {
        return hallMapper.update(hall);
    }

    @Override
    public int deleteById(Long id) {
        equipmentMapper.deleteByHid(id);
        return deleteById(id);
    }
}
