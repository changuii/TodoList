package dev.todo.todoList.service;

import dev.todo.todoList.dto.TodoDTO;
import org.springframework.stereotype.Service;

import java.util.List;


// Service interface
public interface TodoService {

    TodoDTO createTodo(TodoDTO dto);
    TodoDTO readTodo(Long id);
    List<TodoDTO> readAllTodo();
    TodoDTO updateTodo(TodoDTO dto, Long id);
    void deleteTodo(Long id);


}
