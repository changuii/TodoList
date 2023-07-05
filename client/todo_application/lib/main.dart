import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:todo_application/Todo.dart';

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
          onPressed: () {
            Get.dialog(AlertDialog(
              title: Text("Create Todo"),
              content: SizedBox(
                height: Get.height / 2,
                child: Column(children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Input Content"),
                  TextField(),
                ]),
              ),
            ));
          },
        ),
      ),
    );
  }

  AppBar build_Appbar() {
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
    return Center(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Todo();
        },
        itemCount: 10,
      ),
    );
  }
}
