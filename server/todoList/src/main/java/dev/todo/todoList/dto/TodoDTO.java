package dev.todo.todoList.dto;


import lombok.*;


// Data Transfer Object
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class TodoDTO {
    private Long id;
    private String title;
    private String content;
    private Boolean isChecked;
}
