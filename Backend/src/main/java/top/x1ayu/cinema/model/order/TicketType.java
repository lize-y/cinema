package top.x1ayu.cinema.model.order;

import lombok.Getter;

@Getter
public enum TicketType {
    full(1.0),
    student(0.8),
    child(0.6),
    senior(0.7),
    group(0.8),
    normal(1);

    private final double discount;

    TicketType(double discount) {
        this.discount = discount;
    }
}