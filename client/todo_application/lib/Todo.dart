import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:todo_application/TodoController.dart';
import 'package:get/get.dart';
import 'package:todo_application/checkBoxController.dart';

import 'TodoValue.dart';

class Todo extends StatelessWidget {
  int index = 0;

  Todo(int index) {
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {
    TodoController TodoCtrl = Get.put(TodoController());
    return Stack(
      children: [
        Card(
          elevation: 2,
          child: Container(
            height: Get.height / 8,
            width: Get.width,
            child: GetX<TodoController>(builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.timer_sharp,
                        size: 15,
                      ),
                      Text(
                        " ${controller.TodoList[index]!.title}",
                      ),
                    ],
                  ),
                  Text("${controller.TodoList[index]!.content}"),
                  Row(
                    children: [
                      Text("  Complete : "),
                      Checkbox(
                        value: controller.TodoList[index]!.isChecked,
                        onChanged: (value) {
                          controller.TodoList[index]!.isChecked =
                              !controller.TodoList[index]!.isChecked;
                        },
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
        SizedBox(
          height: Get.height / 8 + 10,
          width: Get.width,
          child: TextButton(
            onPressed: () {
              // Get.snackbar(
              //   "Snack Bar",
              //   "You are Click!",
              //   snackPosition: SnackPosition.TOP,
              //   animationDuration: Duration(seconds: 1),
              //   forwardAnimationCurve: Curves.bounceIn,
              //   reverseAnimationCurve: Curves.easeOutCirc,
              // );
              String changeTitle = TodoCtrl.TodoList[index]!.title;
              String changeContent = TodoCtrl.TodoList[index]!.content;
              checkBoxController checkCtrl = Get.put(checkBoxController());
              checkCtrl.isChecked.value = TodoCtrl.TodoList[index]!.isChecked;
              Get.dialog(
                  AlertDialog(
                    title: Text("Update or Delete"),
                    content: SizedBox(
                      height: Get.height / 3,
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Complated : "),
                              GetX<checkBoxController>(builder: (controller) {
                                return Checkbox(
                                  value: checkCtrl.isChecked.value,
                                  onChanged: (chekced) {
                                    checkCtrl.check();
                                  },
                                );
                              })
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLength: 20,
                            decoration: InputDecoration(
                                labelText: TodoCtrl.TodoList[index]!.title,
                                hintText: "Title",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            onChanged: (value) {
                              changeTitle = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLength: 70,
                            decoration: InputDecoration(
                                labelText: TodoCtrl.TodoList[index]!.content,
                                hintText: "Content",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            onChanged: (value) {
                              changeContent = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  TodoValue target = TodoCtrl.TodoList[index]!;
                                  target.title = changeTitle;
                                  target.content = changeContent;
                                  target.isChecked = checkCtrl.isChecked.value;
                                  TodoCtrl.updateTodo(target, index);
                                  Get.back();
                                },
                                child: Text("Update"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  TodoCtrl.deleteTodo(index);
                                  Get.back();
                                },
                                child: Text("Delete"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  barrierDismissible: false);
            },
            child: Text(""),
          ),
        ),
      ],
    );
  }
}
