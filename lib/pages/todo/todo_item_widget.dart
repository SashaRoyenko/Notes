import 'package:flutter/material.dart';
import 'package:notes/entity/todo_item.dart';

class ToDoItemWidget extends StatefulWidget {
  final TodoItem _todoItem;
  final ValueChanged<bool> isSelectedCallback;
  bool isAnySelected = false;

  ToDoItemWidget(this._todoItem, {this.isSelectedCallback, this.isAnySelected});

  @override
  State<StatefulWidget> createState() => _ToDoItemWidgetState();
}

class _ToDoItemWidgetState extends State<ToDoItemWidget> {
  bool chValue = false;
  bool _isSelected = false;
  double _opacity = 0.0;
  bool _isWantKeepAlive = false;

  @override
  Widget build(BuildContext context) {
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
                });
              },
              activeColor: Colors.amber,
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

  void _updateSelectStatusOnLongPress() {
    setState(() {
      _isSelected = !_isSelected;
      _isWantKeepAlive = !_isWantKeepAlive;
      _opacity = _isSelected ? 1.0 : 0.0;
      //widget.isSelectedCallback(_isSelected);
    });
  }

  void _updateSelectStatusOnTap(context) {
//    if (widget.isAnySelected) {
//      _updateSelectStatusOnLongPress();
//    } else {
    //final navigator = Navigator.of(context);
//      navigator.pushNamed(AppRoutes.TODO, arguments: widget.note);
    //navigator.pushNamed(AppRoutes.TODO);
//    }
  }
}
