import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/widget/todo_item.dart';
import '../model/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  var faker = new Faker();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  children: [
                    _searchBox(),
                    Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(bottom: 50),
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: const Text(
                            'All My Todo',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 30),
                          ),
                        ),
                        for (ToDo todo in _foundToDo)
                          TodoItem(
                              todo: todo,
                              onToDoChange: _handleToDoChange,
                              onToDoDelete: _handleToDoDelete)
                      ],
                    ))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(0.0, 1),
                                blurRadius: 10.0,
                                spreadRadius: 0.0)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                          hintMaxLines: 4,
                          hintText: 'Add new todo list',
                          border: InputBorder.none,
                        ),
                      ),
                    )),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, right: 10),
                      // color: Colors.yellow,
                      child: ElevatedButton(
                        onPressed: () {
                          _addToDo(_todoController.text);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(50, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.red,
                            elevation: 10),
                        child: Text(
                          '+',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleToDoDelete(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              item.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  void _addToDo(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: toDo,
          username: faker.person.name()));
    });

    _todoController.clear();
  }

  Widget _searchBox() {
    // final 
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(50)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        // autofocus: true,
        decoration: InputDecoration(
            // fillColor: Colors.red,
            // filled: true,
            // labelText: 'Hallo',
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: Colors.white, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 25, maxWidth: 20),
            border: InputBorder.none,
            hintText: 'Type here to search..',
            hintStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: Colors.blue,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Todo App',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    )),
                Text(
                  'Zinedine Ziddan Fahdlevy',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 13),
                )
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  backgroundImage: NetworkImage('https://picsum.photos/50/50'),
                )
              ],
            )
          ],
        ),
        leading: Container(
            child: Icon(
          Icons.menu,
          color: Colors.white,
        )),
        leadingWidth: 50);
  }
}
