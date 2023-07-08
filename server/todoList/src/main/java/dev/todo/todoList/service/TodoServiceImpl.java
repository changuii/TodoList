package dev.todo.todoList.service;

import dev.todo.todoList.dao.TodoDAO;
import dev.todo.todoList.dao.TodoDAOImpl;
import dev.todo.todoList.dto.TodoDTO;
import dev.todo.todoList.entity.TodoEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


// Service 구현 객체
@Service
public class TodoServiceImpl implements TodoService{

    // logger
    private static final Logger logger = LoggerFactory.getLogger(TodoServiceImpl.class);
    // TodoDAO
    private final TodoDAO todoDAO;

    // Bean객체인 TodoDAO를 주입한다.
    @Autowired
    public TodoServiceImpl(
            TodoDAOImpl todoDAO
    ){
        this.todoDAO = todoDAO;
    }

    //Create Todo 비즈니스 로직
    @Override
    public TodoDTO createTodo(TodoDTO dto) {
        // 받아온 dto값을 Entity 객체로 바꿔준다.
        TodoEntity target = new TodoEntity();
        target.setId(dto.getId());
        target.setTitle(dto.getTitle());
        target.setContent(dto.getContent());
        target.setIsChecked(dto.getIsChecked());

        TodoEntity todo = todoDAO.createTodo(target);
        logger.info("[TodoService] createTodo 완료 id : ", todo.getId() );
        // database에 저장하고 받은 값을 다시 controller로 반환한다.
        dto.setId(todo.getId());
        dto.setTitle(todo.getTitle());
        dto.setContent(todo.getContent());
        dto.setIsChecked(todo.getIsChecked());

        return dto;
    }

    @Override
    public TodoDTO readTodo(Long id) {
        TodoEntity todo = todoDAO.readTodo(id);
        TodoDTO target = new TodoDTO();

        target.setId(todo.getId());
        target.setTitle(todo.getTitle());
        target.setContent(todo.getContent());
        target.setIsChecked(todo.getIsChecked());
        logger.info("[TodoService] readTodo 완료, id : ", target.getId() );

        return target;
    }

    @Override
    public List<TodoDTO> readAllTodo() {
        List<TodoEntity> todoList = todoDAO.readAllTodo();
        // 받아온 Entity값들을 TodoDTO값으로 모두 바꿔준다.
        List<TodoDTO> targetList = new ArrayList<>();
        for(TodoEntity todo : todoList){
            TodoDTO target = new TodoDTO();
            target.setId(todo.getId());
            target.setTitle(todo.getTitle());
            target.setContent(todo.getContent());
            target.setIsChecked(todo.getIsChecked());
            targetList.add(target);
        }
        logger.info("[TodoService] readAllTodo 완료" );


        return targetList;
    }

    @Override
    public TodoDTO updateTodo(TodoDTO dto, Long id) {
        TodoEntity target = new TodoEntity();
        target.setId(dto.getId());
        target.setTitle(dto.getTitle());
        target.setContent(dto.getContent());
        target.setIsChecked(dto.getIsChecked());
        logger.info("[TodoService] updateTodo 완료");
        TodoEntity todo =  todoDAO.updateTodo(target, id);
        logger.info("[TodoService] updateTodo 완료, id : ",id );
        dto.setId(todo.getId());
        dto.setTitle(todo.getTitle());
        dto.setContent(todo.getContent());
        dto.setIsChecked(todo.getIsChecked());


        return dto;
    }

    @Override
    public void deleteTodo(Long id) {
        todoDAO.deleteTodo(id);
        logger.info("[TodoService] deleteTodo 완료, id : ", id );
    }
}
