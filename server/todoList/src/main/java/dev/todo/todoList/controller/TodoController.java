package dev.todo.todoList.controller;


import dev.todo.todoList.dto.TodoDTO;
import dev.todo.todoList.service.TodoService;
import dev.todo.todoList.service.TodoServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/todo")
public class TodoController {
    private static final Logger logger = LoggerFactory.getLogger(TodoController.class);
    private final TodoService todoService;

    @Autowired
    public TodoController(
            TodoServiceImpl todoService
    ){
        this.todoService = todoService;
    }


    @PostMapping
    public ResponseEntity<TodoDTO> createTodo(
            @RequestBody TodoDTO dto
    ){
        TodoDTO target = this.todoService.createTodo(dto);
        logger.info("[TodoController] createTodo 완료" );
        return ResponseEntity.status(201).body(target);
    }

    @GetMapping("/{id}")
    public ResponseEntity<TodoDTO> readTodo(
            @PathVariable("id") Long id
    ){
        TodoDTO target = this.todoService.readTodo(id);
        logger.info("[TodoController] readTodo 완료" );
        return ResponseEntity.status(200).body(target);
    }

    @GetMapping()
    public ResponseEntity<List<TodoDTO>> readAllTodo(){
        List<TodoDTO> targetList = this.todoService.readAllTodo();
        logger.info("[TodoController] readAllTodo 완료" );
        return ResponseEntity.status(200).body(targetList);
    }

    @PutMapping()
    public ResponseEntity<TodoDTO> updateTodo(
            @RequestBody TodoDTO dto
    ){
        logger.info("{}", dto.getIsChecked());
        TodoDTO target = this.todoService.updateTodo(dto, dto.getId());
        logger.info("[TodoController] updateTodo 완료 checked : {}", dto.getIsChecked() );
        return ResponseEntity.status(200).body(target);
    }

    @DeleteMapping("/{id}")
    public HttpStatus deleteTodo(
            @PathVariable("id") Long id
    ){
        this.todoService.deleteTodo(id);

        return HttpStatus.OK;
    }

}
