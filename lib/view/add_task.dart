import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _controller = TextEditingController();
   List<TodoItem> _todoList = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // Load tasks from SharedPreferences
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todoData = prefs.getString('todoList');
    if (todoData != null) {
      final List<dynamic> taskJson = jsonDecode(todoData);
      setState(() {
        _todoList = taskJson.map((item) => TodoItem.fromJson(item)).toList();
      });
    }
  }


  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String taskData = jsonEncode(_todoList.map((item) => item.toJson()).toList());
    await prefs.setString('todoList', taskData);
  }

  void addTask(String title) {
    if (title.isNotEmpty) {
      setState(() {
        _todoList.add(TodoItem(title: title));
      });
      _controller.clear();
      saveTasks();
    }
  }



  void markCompleted(int index) {
    setState(() {
      _todoList[index].isCompleted = !_todoList[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter Task Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => addTask(_controller.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _todoList[index].title,
                    style: TextStyle(
                      decoration: _todoList[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Checkbox(
                    value: _todoList[index].isCompleted,
                    onChanged: (value) => markCompleted(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
