import 'package:flutter/material.dart';
import 'package:notes/entity/todo_item.dart';
import 'package:notes/factory/app_bar_factory.dart';
import 'package:notes/pages/todo/todo_item_widget.dart';
import 'package:notes/service/todo_item_service.dart';
import 'package:notes/state/app_bar_state.dart';
import 'package:provider/provider.dart';

class ToDoPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToDoPageWidgetState();
}

class _ToDoPageWidgetState extends State<ToDoPageWidget> {
  TodoItemService _todoItemService;
  Set<TodoItem> _selectedTodoItems = Set();
  AppBarState _appBarState;

  @override
  Widget build(BuildContext context) {
    _todoItemService = Provider.of<TodoItemService>(context);

    return FutureBuilder<List<TodoItem>>(
        future: _todoItemService.findAllTodoItemsOrderByUpdateDate(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? _todoItemListViewWidget(snapshot.data, context)
              : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.amber,
                  ),
                );
        });
  }

  Widget _todoItemListViewWidget(List<TodoItem> data, context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: data.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (BuildContext context, int index) => ToDoItemWidget(
          data[index],
          isAnySelected: _selectedTodoItems.length > 0,
          key: Key(data[index].id.toString()),
          isSelectedCallback: (bool value) {
        _isSelectCallback(value, data[index]);
      }),
    );
  }

  void _isSelectCallback(bool value, TodoItem note) {
    if (value) {
      _selectedTodoItems.add(note);
    } else {
      _selectedTodoItems.remove(note);
    }
    _appBarState = Provider.of<AppBarState>(context);
    if (_selectedTodoItems.length > 0) {
      AppBar appBar = AppBarFactory.multiSelectDeleteAppBar(
          _selectedTodoItems.length, _deleteTodoItems);
      _appBarState.appBar = appBar;
    } else {
      _appBarState.appBar = _appBarState.mainBar;
    }
  }

  void _deleteTodoItems() {
    setState(() {
      _selectedTodoItems.forEach((element) {
        _todoItemService.delete(element.id);
      });
      _selectedTodoItems = Set();
      _appBarState.appBar = _appBarState.mainBar;
    });
  }
}
