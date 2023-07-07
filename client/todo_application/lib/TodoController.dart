import 'package:get/get.dart';
import 'package:todo_application/TodoValue.dart';
import 'Todo.dart';

class TodoController extends GetxController {
  RxMap<int, TodoValue> TodoList = <int, TodoValue>{}.obs;

  void createTodo(TodoValue target, int key) {
    target.title = "${target.title} $key";
    TodoList[key] = target;
  }

  TodoValue readTodo(int index) {
    return this.TodoList[index]!;
  }

  Map<int, TodoValue> readAllTodo() {
    return this.TodoList;
  }

  void updateTodo(TodoValue target, int index) {
    this.TodoList[index] = target;
  }

  void deleteTodo(int index) {
    for (int i = index; i < this.TodoList.length - 1; i++) {
      this.TodoList[i] = this.TodoList[i + 1]!;
    }
    this.TodoList.remove(TodoList.length - 1);
  }
}
