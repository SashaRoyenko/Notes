import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/entity/todo_item.dart';
import 'package:notes/service/todo_item_service.dart';
import 'package:provider/provider.dart';

class AddTodoItemPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddTodoPageWidgetState();
}

class _AddTodoPageWidgetState extends State<AddTodoItemPageWidget> {
  TodoItemService _todoItemService;
  final textEditingController = TextEditingController();
  bool _isTextFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(_checkTextField);
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _todoItemService = Provider.of<TodoItemService>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: Colors.black45,
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: 'Click done to create todo subtask',
              border: InputBorder.none,
            ),
            cursorColor: Colors.amber,
            autofocus: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.white10,
                padding: EdgeInsets.symmetric(horizontal: 15),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.alarm),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Text("Set a reminder"),
                  ],
                ),
              ),
              MaterialButton(
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: _isTextFieldEmpty ? Colors.white70 : Colors.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: _isTextFieldEmpty ? null : _saveTodoItem,
              )
            ],
          )
        ],
      ),
    );
  }

  void _saveTodoItem() {
    var date = DateTime.now().toIso8601String();
    TodoItem todoItem = TodoItem(null, textEditingController.text, date, false);
    _todoItemService.insertTodoItem(todoItem);
  }

  _checkTextField() {
    setState(() {
      _isTextFieldEmpty = textEditingController.text.isEmpty;
    });
  }
}
