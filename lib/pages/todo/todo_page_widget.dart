import 'package:flutter/material.dart';
import 'package:notes/entity/todo_item.dart';
import 'package:notes/pages/todo/todo_item_widget.dart';
import 'package:notes/service/todo_item_service.dart';
import 'package:provider/provider.dart';

class ToDoPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToDoPageWidgetState();
}

class _ToDoPageWidgetState extends State<ToDoPageWidget> {
  TodoItemService _todoItemService;

  @override
  Widget build(BuildContext context) {
    _todoItemService = Provider.of<TodoItemService>(context);

    return FutureBuilder<List<TodoItem>>(
        future: _todoItemService.findAllTodoItemsOrderByUpdateDate(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? _todoItemListViewWidget(snapshot.data, context)
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  var isSelected = false;
  var mycolor = Colors.white;

  Widget _todoItemListViewWidget(List<TodoItem> data, context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: data.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (BuildContext context, int index) =>
          ToDoItemWidget(data[index]),
    );
  }

  void toggleSelection() {
    setState(() {
      if (isSelected) {
        mycolor = Colors.white;
        isSelected = false;
      } else {
        mycolor = Colors.grey[300];
        isSelected = true;
      }
    });
  }
}
