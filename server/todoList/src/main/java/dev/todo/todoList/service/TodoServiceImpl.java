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

@Service
public class TodoServiceImpl implements TodoService{
    private static final Logger logger = LoggerFactory.getLogger(TodoServiceImpl.class);
    private final TodoDAO todoDAO;

    @Autowired
    public TodoServiceImpl(
            TodoDAOImpl todoDAO
    ){
        this.todoDAO = todoDAO;
    }

    @Override
    public TodoDTO createTodo(TodoDTO dto) {
        TodoEntity target = new TodoEntity();
        target.setId(dto.getId());
        target.setTitle(dto.getTitle());
        target.setContent(dto.getContent());
        target.setChecked(dto.isChecked());

        TodoEntity todo = todoDAO.createTodo(target);
        logger.info("[TodoService] createTodo 완료 id : ", todo.getId() );
        dto.setId(todo.getId());
        dto.setTitle(todo.getTitle());
        dto.setContent(todo.getContent());
        dto.setChecked(todo.isChecked());

        return dto;
    }

    @Override
    public TodoDTO readTodo(Long id) {
        TodoEntity todo = todoDAO.readTodo(id);
        TodoDTO target = new TodoDTO();

        target.setId(todo.getId());
        target.setTitle(todo.getTitle());
        target.setContent(todo.getContent());
        target.setChecked(todo.isChecked());
        logger.info("[TodoService] readTodo 완료, id : ", target.getId() );

        return target;
    }

    @Override
    public List<TodoDTO> readAllTodo() {
        List<TodoEntity> todoList = todoDAO.readAllTodo();
        List<TodoDTO> targetList = new ArrayList<>();
        for(TodoEntity todo : todoList){
            TodoDTO target = new TodoDTO();
            target.setId(todo.getId());
            target.setTitle(todo.getTitle());
            target.setContent(todo.getContent());
            target.setChecked(todo.isChecked());
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
        target.setChecked(dto.isChecked());

        TodoEntity todo =  todoDAO.updateTodo(target, id);
        logger.info("[TodoService] updateTodo 완료, id : ",id );
        dto.setId(todo.getId());
        dto.setTitle(todo.getTitle());
        dto.setContent(todo.getContent());
        dto.setChecked(todo.isChecked());


        return dto;
    }

    @Override
    public void deleteTodo(Long id) {
        todoDAO.deleteTodo(id);
        logger.info("[TodoService] deleteTodo 완료, id : ", id );
    }
}
