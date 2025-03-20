package top.x1ayu.cinema.model.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import top.x1ayu.cinema.model.order.Order;

import java.time.LocalDate;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Long id;
    private String name;
    private String password;
    private String email;
    private String phone;
    private String age;
    private LocalDate birthday;
    private String sex;
    private String photo;

    // 不在 User 表中的字段
    private List<Role> roles;
    private List<Order> orders;
}
