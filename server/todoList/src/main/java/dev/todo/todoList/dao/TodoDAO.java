package dev.todo.todoList.dao;

import dev.todo.todoList.entity.TodoEntity;

import java.util.List;
import java.util.Optional;

public interface TodoDAO {

    TodoEntity createTodo(TodoEntity target);
    TodoEntity readTodo(Long id);
    List<TodoEntity> readAllTodo();

    TodoEntity updateTodo(TodoEntity target, Long id);
    void deleteTodo(Long id);

}
