import 'package:flutter/material.dart';

class ToDoItemWidget extends StatefulWidget {

  final String _text;

  ToDoItemWidget(this._text);

  @override
  State<StatefulWidget> createState() => _ToDoItemWidgetState();
}

class _ToDoItemWidgetState extends State<ToDoItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white12,
      ),
      child: Text(widget._text),
    );
  }
}
