import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:todo_application/Todo.dart';
import 'package:todo_application/TodoController.dart';
import 'package:get/get.dart';
import 'TodoValue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // debug 배너 false
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: build_Appbar(),
        body: build_Body(),
        // Todo생성 버튼
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add_box_outlined,
            color: Colors.amber[800],
          ),
          backgroundColor: Colors.amber[200],
          onPressed: () {
            TodoValue target = TodoValue();
            String title = "New Todo";
            String content = "explain plz";
            // dialog를 띄운다.
            Get.dialog(
                // AlertDialog 띄운다.
                AlertDialog(
                  title: Text("Create Todo"),
                  content: SizedBox(
                    height: Get.height / 3,
                    // 키보드를 띄울 때 화면이 깨지는 문제 해결
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Text("Please save the value to make Todo"),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Title",
                            hintText: "Please input data",
                            // TextField 모서리를 둥글게 깍는다.
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide()),
                          ),
                          // 최대 길이 20
                          maxLength: 20,
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                          width: Get.width,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Content",
                            hintText: "Please input data",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide()),
                          ),
                          maxLength: 70,
                          onChanged: (value) {
                            content = value;
                          },
                        ),
                        SizedBox(
                          height: Get.height / 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  target.title = title;
                                  target.content = content;
                                  TodoController controller =
                                      Get.put(TodoController());
                                  controller.createTodo(
                                      target, controller.TodoList.length);
                                  Get.back(closeOverlays: true);
                                },
                                child: Text("저장")),
                            OutlinedButton(
                                onPressed: () {
                                  Get.back(closeOverlays: true);
                                },
                                child: Text("취소")),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
                barrierDismissible: false);
          },
        ),
      ),
    );
  }

  // Appbar 그리기
  AppBar build_Appbar() {
    // 앱 실행시 서버로부터 모든 Todo를 가져온다.
    // URI : /todo
    // Method : GET
    TodoController ctrl = Get.put(TodoController());
    ctrl.reloadTodoList();
    return AppBar(
      title: Text(
        "Todo List",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 26,
          fontStyle: FontStyle.italic,
        ),
      ),
      backgroundColor: Colors.amber[600],
    );
  }

  Widget build_Body() {
    Get.put(TodoController());
    return Center(
      // 메인화면 Todo들을 홈 화면에 그려준다.
      child: GetX<TodoController>(builder: (controller) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Todo(index);
          },
          // TodoController의 TodoList의 길이만큼 홈화면에 위젯을 그려준다.
          // TodoList는 TodoValue, Todo위젯에 필요한 값들을 Map형태로 담고 있다.
          itemCount: controller.TodoList.length,
        );
      }),
    );
  }
}
