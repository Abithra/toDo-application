import 'package:flutter/material.dart';
import 'package:to_do_application/utils/to_do_list.dart';

import '../utils/to_do_tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final List<Map<String, dynamic>> todoList = ToDoTasks.tasks;
  final _formkey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: const Icon(Icons.menu),
        centerTitle: true,
        title: const Text(
          "Todo List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blueGrey,
          Colors.green,
          Colors.blue,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: ToDoList(todoList: todoList),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a task in list",
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Center(child: Text("Add a Task")),
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              content: SizedBox(
                height: 150,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        cursorColor: Colors.black,
                        cursorHeight: 26,
                        controller: myController,
                        cursorWidth: 2,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromRGBO(175, 126, 235, 1)),
                          ),
                          hintText: "your task",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(151, 153, 167, 1),
                          ),
                        ),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Don't be lazy!!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: const Size(40, 40),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            Navigator.of(context).pop();
                            setState(() {
                              todoList.add({
                                'name': myController.text,
                                'done': false,
                              });
                              myController.text = "";
                            });
                          }
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
