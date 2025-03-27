package top.x1ayu.cinema;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import top.x1ayu.cinema.mapper.PermMapper;
import top.x1ayu.cinema.mapper.RoleMapper;
import top.x1ayu.cinema.model.user.Perm;
import top.x1ayu.cinema.model.user.Role;

import java.util.List;

@SpringBootTest
public class UserTest {

    private static final Logger log = LoggerFactory.getLogger(UserTest.class);

    @Autowired
    private PermMapper permMapper;

    @Autowired
    private RoleMapper roleMapper;
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
        Perm perm = Perm.builder().name("排片").build();
        permMapper.insertPerm(perm);
        log.info("insert perm: {}", perm);
        log.info("get perm: {}", permMapper.getPermById(perm.getId()));
    }

    @Test
    public void role_test() {
//        List<Role> roles = roleMapper.getAllRoles();
//        if (roles.isEmpty())
//            log.info("roles is null");
//        else
//            for (Role role : roles)
//                log.info("role: {}", role);
//        Role role = Role.builder().name("test").build();
//        roleMapper.insert(role);
//        log.info("insert role: {}", role);
//        roleMapper.insertRolePerm(role.getId(), 1L);
//        roleMapper.insertRolePerm(1L, 2L);
//        log.info("get role: {}", roleMapper.getRoleById(1L));
        roleMapper.delete(1L);
    }
}
