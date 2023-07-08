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

import static org.apache.coyote.http11.Constants.a;


//  ../todo로 들어오는 요청을 맵핑
@RestController
@RequestMapping("/todo")
public class TodoController {

    // logger
    private static final Logger logger = LoggerFactory.getLogger(TodoController.class);
    // todoService
    private final TodoService todoService;


    // Bean객체인 TodoService를 주입한다.
    @Autowired
    public TodoController(
            TodoServiceImpl todoService
    ){
        this.todoService = todoService;
    }


    // ../todo
    // Methdo : POST
    // Todo를 생성한다.
    @PostMapping
    public ResponseEntity<TodoDTO> createTodo(
            // Body값을 dto로 가져온다.
            @RequestBody TodoDTO dto
    ){
        // service에서 todo를 생성
        TodoDTO target = this.todoService.createTodo(dto);
        logger.info("[TodoController] createTodo 완료" );
        logger.info(dto.toString());
        return ResponseEntity.status(201).body(target);
    }

    // Todo값을 id로 가져온다.
    @GetMapping("/{id}")
    public ResponseEntity<TodoDTO> readTodo(
            @PathVariable("id") Long id
    ){
        TodoDTO target = this.todoService.readTodo(id);
        logger.info("[TodoController] readTodo 완료" );
        return ResponseEntity.status(200).body(target);
    }

    // 모든 Todo값을 가져온다.
    @GetMapping()
    public ResponseEntity<List<TodoDTO>> readAllTodo(){
        List<TodoDTO> targetList = this.todoService.readAllTodo();
        logger.info("[TodoController] readAllTodo 완료" );
        for(TodoDTO target : targetList){
            logger.info(target.toString());
        }
        return ResponseEntity.status(200).body(targetList);
    }

    @PutMapping()
    public ResponseEntity<TodoDTO> updateTodo(
            @RequestBody TodoDTO dto
    ){
        TodoDTO target = this.todoService.updateTodo(dto, dto.getId());
        logger.info("[TodoController] updateTodo 완료 ");
        logger.info(dto.toString());
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
