package top.x1ayu.cinema.model.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Role {
    private Long id;
    private String name;
    private String description;

    private List<Perm> perms;
    private List<User> users;// lazy load

}
