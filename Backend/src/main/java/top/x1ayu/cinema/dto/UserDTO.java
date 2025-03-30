package top.x1ayu.cinema.dto;

import top.x1ayu.cinema.model.user.User;

import java.time.LocalDate;

public class UserDTO {
    private Long id;
    private String name;
    private String email;
    private String phone;
    private LocalDate birthday;
    private User.SexType sex;
    private String photoPath;
}
