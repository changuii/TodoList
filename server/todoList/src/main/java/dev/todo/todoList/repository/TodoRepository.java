package dev.todo.todoList.repository;

import dev.todo.todoList.entity.TodoEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


// Jpa Repository
@Repository
public interface TodoRepository extends JpaRepository<TodoEntity, Long> {

}
