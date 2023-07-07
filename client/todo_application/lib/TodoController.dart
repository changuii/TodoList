import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo_application/TodoValue.dart';
import 'Todo.dart';
import 'package:http/http.dart' as http;

class TodoController extends GetxController {
  RxMap<int, TodoValue> TodoList = <int, TodoValue>{}.obs;
  final url = Uri.parse('http://localhost:8080/todo');

  void createTodo(TodoValue target, int key) async {
    target.title = "${target.title} $key";
    TodoList[key] = target;

    print(jsonEncode(toJson(target, key)));
    var response = await http.post(url,
        body: jsonEncode(toJson(target, key)),
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    this.reloadTodoList();
  }

  TodoValue readTodo(int index) {
    return this.TodoList[index]!;
  }

  Map<int, TodoValue> readAllTodo() {
    return this.TodoList;
  }

  void reloadTodoList() async {
    var response = await http.get(url);
    this.TodoList.clear();
    List<dynamic> jsondataList = jsonDecode(utf8.decode(response.bodyBytes));
    jsondataList.forEach((jsondata) {
      Map<String, dynamic> json = jsondata;
      print("$json, asdasdasd");
      TodoValue todo = new TodoValue();
      todo.title = json["title"];
      todo.content = json["content"];
      todo.isChecked = json["isChecked"];
      this.TodoList[json["id"]] = todo;
      print(TodoList[json["id"]]!.title);
      print(TodoList[json["id"]]!.content);
      print(TodoList[json["id"]]!.isChecked);
    });
  }

  void updateTodo(TodoValue target, int index) async {
    this.TodoList[index] = target;

    var response = await http.put(url,
        body: jsonEncode(toJson(target, index)),
        headers: {"Content-Type": "application/json"});
    this.reloadTodoList();
  }

  void deleteTodo(int index) async {
    if (index != this.TodoList.length - 1) {
      for (int i = index; i < this.TodoList.length - 1; i++) {
        this.TodoList[i] = this.TodoList[i + 1]!;
        var response = await http.put(url,
            body: jsonEncode(toJson(TodoList[i + 1]!, i)),
            headers: {"Content-Type": "application/json"});
        print(response);
      }
    }
    var deleteUrl =
        Uri.parse('http://localhost:8080/todo/${TodoList.length - 1}');
    var response = await http.delete(deleteUrl);
    this.reloadTodoList();
  }

  Map<String, dynamic> toJson(TodoValue todo, int index) {
    String json = "{'id' = $index, ''}";

    Map<String, dynamic> target = {};
    target['id'] = index;
    target['title'] = todo.title;
    target['content'] = todo.content;
    target['isChecked'] = todo.isChecked;

    return target;
  }
}
