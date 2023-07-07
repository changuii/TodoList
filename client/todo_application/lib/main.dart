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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: build_Appbar(),
        body: build_Body(),
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
            Get.dialog(
                AlertDialog(
                  title: Text("Create Todo"),
                  content: SizedBox(
                    height: Get.height / 3,
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
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide()),
                          ),
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

  AppBar build_Appbar() {
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
      child: GetX<TodoController>(builder: (controller) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Todo(index);
          },
          itemCount: controller.TodoList.length,
        );
      }),
    );
  }
}
