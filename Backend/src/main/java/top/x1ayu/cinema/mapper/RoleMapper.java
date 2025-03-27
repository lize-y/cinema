package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.*;
import top.x1ayu.cinema.model.user.Role;

import java.util.List;

@Mapper
public interface RoleMapper {

    List<Role> getAllRoles();

    List<Role> getRoles(Role params);

    Role getRoleById(@Param("id") Long id);

    @Insert("INSERT INTO role (name) VALUES (#{name})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Role role);

    @Insert("INSERT INTO role_perm (role_id, perm_id) VALUES (#{roleId}, #{permId})")
    int insertRolePerm(
            @Param("roleId") Long roleId,
            @Param("permId") Long permId
    );

    @Update("UPDATE role SET name = #{name} WHERE id = #{id}")
    int update(Role role);

    @Delete("DELETE FROM role WHERE id = #{id}")
    int delete(@Param("id") Long id);
}
