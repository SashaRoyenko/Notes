import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notes/entity/todo_item.dart';
import 'package:notes/service/todo_item_service.dart';
import 'package:provider/provider.dart';

import 'add_todo_item_widget.dart';

class ToDoItemWidget extends StatefulWidget {
  final TodoItem _todoItem;
  final ValueChanged<bool> isSelectedCallback;
  bool isAnySelected = false;

  ToDoItemWidget(this._todoItem,
      {Key key, this.isSelectedCallback, this.isAnySelected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ToDoItemWidgetState();
}

class _ToDoItemWidgetState extends State<ToDoItemWidget>
    with AutomaticKeepAliveClientMixin<ToDoItemWidget> {
  bool chValue = false;
  bool _isSelected = false;
  double _opacity = 0.0;
  bool _isWantKeepAlive = false;
  TodoItemService _todoItemService;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _todoItemService = Provider.of<TodoItemService>(context);
    return GestureDetector(
      onLongPress: _updateSelectStatusOnLongPress,
      onTap: () => _updateSelectStatusOnTap(context),
      behavior: HitTestBehavior.deferToChild,
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: widget._todoItem.isDone,
              onChanged: (bool value) {
                setState(() {
                  widget._todoItem.isDone = value;
                  updateTodoItem(widget._todoItem);
                });
              },
              activeColor:
                  widget._todoItem.isDone ? Colors.black45 : Colors.amber,
            ),
            Text(
              widget._todoItem.text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                decoration: widget._todoItem.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            Opacity(
              opacity: _opacity,
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateTodoItem(TodoItem todoItem) {
    _todoItemService.updateTodoItem(todoItem);
  }

  void _updateSelectStatusOnLongPress() {
    setState(() {
      _isSelected = !_isSelected;
      _isWantKeepAlive = !_isWantKeepAlive;
      _opacity = _isSelected ? 1.0 : 0.0;
      widget.isSelectedCallback(_isSelected);
    });
  }

  void _updateSelectStatusOnTap(context) {
    if (widget.isAnySelected) {
      _updateSelectStatusOnLongPress();
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddTodoItemPageWidget(
                  parentCallback: () => Navigator.pop(context),
                  todoItem: widget._todoItem));
        },
      );
    }
  }

  @override
  bool get wantKeepAlive => _isWantKeepAlive;
}
