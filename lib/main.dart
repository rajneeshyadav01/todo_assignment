import 'package:flutter/material.dart';
import 'package:to_do_assignment/view/add_task.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme:  const AppBarTheme(
          color: Colors.blueAccent,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 21
          )
        )
      ),
      home: const AddTaskScreen(),
    );
  }
}




