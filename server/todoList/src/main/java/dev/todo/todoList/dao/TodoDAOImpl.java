package dev.todo.todoList.dao;

import dev.todo.todoList.entity.TodoEntity;
import dev.todo.todoList.repository.TodoRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class TodoDAOImpl implements TodoDAO{
    private static final Logger logger = LoggerFactory.getLogger(TodoDAOImpl.class);
    private final TodoRepository todoRepository;

    TodoDAOImpl(
           @Autowired TodoRepository todoRepository
    ){
        this.todoRepository = todoRepository;
    }


    @Override
    public TodoEntity createTodo(TodoEntity target) {
        TodoEntity result = this.todoRepository.save(target);
        logger.info("[TodoDAO] : TodoEntity 생성 완료 id : ", target.getId());
        return result;
    }

    @Override
    public TodoEntity readTodo(Long id) {
        TodoEntity target = this.todoRepository.getById(id);
        logger.info("[TodoDAO] : TodoEntity Read 완료  id : ", id);

        return target;
    }

    @Override
    public List<TodoEntity> readAllTodo() {
        List<TodoEntity> target = new ArrayList<>();
        for(TodoEntity entity : this.todoRepository.findAll()){
            target.add(entity);
        }
        logger.info("[TodoDAO] : TodoEntity Read ALL 완료");

        return target;
    }

    @Override
    public TodoEntity updateTodo(TodoEntity target, Long id) {
        todoRepository.save(target);
        TodoEntity updateTarget = todoRepository.getById(id);
        logger.info("[TodoDAO] : TodoEntity update 완료 id : ", id);

        return updateTarget;
    }

    @Override
    public void deleteTodo(Long id) {
        todoRepository.delete(todoRepository.getById(id));
        logger.info("[TodoDAO] : TodoEntity delete 완료 id : ", id);

    }
}
