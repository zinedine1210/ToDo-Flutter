import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onToDoDelete;

  const TodoItem(
      {Key? key,
      required this.todo,
      required this.onToDoChange,
      required this.onToDoDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () {
          onToDoChange(todo);
        },
        leading: Icon(todo.isDone ? Icons.check_box : Icons.check_box_outline_blank, color: Colors.white),
        title: Text(
          todo.title.toString(),
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.bold,
            decoration: todo.isDone ? TextDecoration.lineThrough : null
          ),
        ),
        subtitle: Text(
          todo.username.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Colors.blue,
        trailing: Container(
          padding: EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 20,
            icon: Icon(Icons.delete),
            onPressed: () {
              // print("Delete todo");
              onToDoDelete(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
