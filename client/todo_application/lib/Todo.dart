import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Todo extends StatelessWidget {
  var title = "This is Todo";
  var text = "Todo text!";
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 2,
          child: Container(
            height: 80,
            width: Get.width,
            child: Column(
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
                      " ${title}",
                    ),
                  ],
                ),
                Text("${text}"),
                Row(
                  children: [
                    Text("  Complete : "),
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        isChecked = !isChecked;
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 90,
          width: Get.width,
          child: TextButton(
            onPressed: () {
              Get.snackbar(
                "Snack Bar",
                "You are Click!",
                snackPosition: SnackPosition.TOP,
                animationDuration: Duration(seconds: 1),
                forwardAnimationCurve: Curves.bounceIn,
                reverseAnimationCurve: Curves.easeOutCirc,
              );
            },
            child: Text(""),
          ),
        ),
      ],
    );
  }
}
