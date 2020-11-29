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
    with
        AutomaticKeepAliveClientMixin<ToDoItemWidget>,
        TickerProviderStateMixin {
  bool chValue = false;
  bool _isSelected = false;
  double _opacity = 0.0;
  bool _isWantKeepAlive = false;
  TodoItemService _todoItemService;

  AnimationController lineThroughController;
  Animation lineThroughAnimation;

  bool _isChecked = false;
  Color _activeColor = Colors.black45;
  Color _crossLineColor = Colors.amber;

  @override
  void initState() {
    _isChecked = widget._todoItem.isDone;

    lineThroughController = new AnimationController(
      duration: new Duration(milliseconds: 700),
      vsync: this,
    );

    final CurvedAnimation curve = new CurvedAnimation(
        parent: lineThroughController, curve: Curves.easeOut);

    lineThroughAnimation = new Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _todoItemService = Provider.of<TodoItemService>(context);
    return GestureDetector(
      onLongPress: _updateSelectStatusOnLongPress,
      onTap: () => _updateSelectStatusOnTap(context),
      behavior: HitTestBehavior.deferToChild,
      child: Container(
        padding: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (bool value) {
                _isChecked = value;
                if (value) {
                  _crossLineColor = Colors.amber;
                  _activeColor = Colors.amber;
                  lineThroughController.forward(from: 0.0).whenComplete(() {
                    _crossLineColor = Colors.white10;
                    _activeColor = Colors.black45;
                    widget._todoItem.isDone = value;
                    _updateTodoItem(widget._todoItem);
                  });
                } else {
                  widget._todoItem.isDone = value;
                  _updateTodoItem(widget._todoItem);
                }
              },
              activeColor: _activeColor,
              checkColor: Colors.white24,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  widget._todoItem.text,
                  style: TextStyle(
                    color:
                        widget._todoItem.isDone ? Colors.white10 : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: widget._todoItem.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                new Container(
                  transform: Matrix4.identity()
                    ..scale(lineThroughAnimation.value, 1.0),
                  child: new Text(
                    widget._todoItem.text,
                    style: new TextStyle(
                      color: Colors.transparent,
                      decorationColor: _crossLineColor,
                      decorationThickness: 4,
                      decorationStyle: TextDecorationStyle.solid,
                      decoration: _isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 200),
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

  void _updateTodoItem(TodoItem todoItem) {
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

  @override
  void dispose() {
    lineThroughController.dispose();
    super.dispose();
  }
}
