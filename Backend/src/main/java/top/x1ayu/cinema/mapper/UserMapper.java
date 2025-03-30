package top.x1ayu.cinema.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import top.x1ayu.cinema.model.user.User;

import java.util.List;

public interface UserMapper {
    @Select("SELECT rp.perm_id " +
            "FROM user_role AS ur" +
            " JOIN role_perm AS rp ON ur.role_id = rp.role_id" +
            " WHERE ur.user_id = #{id}")
    List<Long> getPermIdsByUserId(@Param("userId") Long userId);

    User getUserById(@Param("id") Long id);

    List<User> getUsers(User params);

    @Insert("INSERT INTO user_role (user_id, role_id) VALUES (#{id}, #{roleId})")
    int insertUserRole(User user, List<Long> RoleIds);

    int insertUser(User user);

    int updateUser(User user);

    int deleteUserById(@Param("id") Long id);
}
