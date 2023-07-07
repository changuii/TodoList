import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo_application/TodoValue.dart';
import 'Todo.dart';
import 'package:http/http.dart' as http;

// Todo를 그리기위한 값들을 담고있는 Controller
// Map형태로 Key와 Value값을 가지고 있다.
class TodoController extends GetxController {
  RxMap<int, TodoValue> TodoList = <int, TodoValue>{}.obs;
  // 서버 주소
  final url = Uri.parse('http://localhost:8080/todo');

  // Todo 생성
  // 1. local변수인 TodoList에 값을 key값으로 넣는다.
  // 2. 서버에 POST 요청을 보낸다.
  // Body : json value
  // 3. reloadTodoList 서버에 저장된 모든 Todo 값을 불러와 TodoList를 갱신한다.
  void createTodo(TodoValue target, int key) async {
    target.title = "${target.title} $key";
    TodoList[key] = target;

    // HTTP POST REQUEST
    var response = await http.post(url,
        body: jsonEncode(toJson(target, key)),
        headers: {"Content-Type": "application/json"});

    // TODO_LIST RELOAD!
    this.reloadTodoList();
  }

  // 사용 X
  TodoValue readTodo(int index) {
    return this.TodoList[index]!;
  }

  // 사용 X
  Map<int, TodoValue> readAllTodo() {
    return this.TodoList;
  }

  // 서버의 Todo값들과 local 변수의 값을 동기화 시켜주기위한 메소드
  void reloadTodoList() async {
    // HTTP GET REQUEST
    // 해당 경로는 서버에 저장된 모든 Todo값을 json 배열 형태로 가져온다.
    var response = await http.get(url);

    // local에 저장된 todo List 값을 비운다.
    this.TodoList.clear();

    // 서버로부터 받아온 Json Byte값을 UTF8로 디코딩한다. (한글 깨짐 문제 방지)
    List<dynamic> jsondataList = jsonDecode(utf8.decode(response.bodyBytes));
    // For Each문으로 List를 Map형태로 바꾸고 Json형태의 데이터를 local변수의 Map TodoList로 변환해준다.
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

  // Todo를 수정한다.
  void updateTodo(TodoValue target, int index) async {
    this.TodoList[index] = target;

    // HTTP PUT REQUEST
    // 서버로 update 요청을 보낸다.
    var response = await http.put(url,
        // TodoValue와 index 값을 Map형태로 변환하고 다시 Map을 json형태로 변환하여 body에 넣는다.
        body: jsonEncode(toJson(target, index)),
        // json 타입의 body값임을 명시한다.
        headers: {"Content-Type": "application/json"});

    // 서버와 데이터를 동기화 시킨다.
    this.reloadTodoList();
  }

  // 삭제
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

    // HTTP DELETE REQUEST
    // 서버로 삭제 요청을 보낸다.
    var deleteUrl =
        // Path Variable
        Uri.parse('http://localhost:8080/todo/${TodoList.length - 1}');
    var response = await http.delete(deleteUrl);

    // 서버와 변수를 동기화
    this.reloadTodoList();
  }

  // TodoValu와 index값을 Map형태로 변환한다.
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
