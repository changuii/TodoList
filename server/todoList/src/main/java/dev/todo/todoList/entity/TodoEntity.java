package dev.todo.todoList.entity;


import lombok.*;

import javax.persistence.*;


// Entity 객체 DB에 넣을 때 사용
@Table()
@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TodoEntity {

    @Id
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private String Content;


    @Column(nullable = false)
    private Boolean isChecked;





}
