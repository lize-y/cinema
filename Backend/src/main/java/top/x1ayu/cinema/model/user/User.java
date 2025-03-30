package top.x1ayu.cinema.model.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import top.x1ayu.cinema.model.order.Order;

import java.time.LocalDate;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class User {
    private Long id;
    private String name;
    private String password;
    private String email;
    private String phone;
    private LocalDate birthday;
    private SexType sex;
    private String photoPath;

    // 不在 User 表中的字段
    private int age;
    private List<Integer> perm_ids;
    private List<Role> roles;// lazy load
    private List<Order> orders; //lazy load

    public enum SexType {
        male,
        female,
        other
    }
}
