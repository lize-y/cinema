package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.*;
import top.x1ayu.cinema.model.user.Perm;

import java.util.List;

@Mapper
public interface PermMapper {
    @Select("SELECT * FROM perm WHERE id = #{id}")
    Perm getPermById(@Param("id") Long id);

    @Select("SELECT * FROM perm")
    List<Perm> getAllPerms();

    @Insert("INSERT INTO perm (name) VALUES (#{name})")
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    int insertPerm(Perm perm);

    @Update("UPDATE perm SET name = #{name} WHERE id = #{id}")
    int updatePerm(Perm perm);

    @Delete("DELETE FROM perm WHERE id = #{id}")
    int deletePermById(@Param("id") Long id);
}
