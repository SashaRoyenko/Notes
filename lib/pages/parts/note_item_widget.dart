import 'package:flutter/material.dart';

class NoteItemWidget extends StatefulWidget {

  final String _text;

  NoteItemWidget(this._text);

  @override
  State<StatefulWidget> createState() => _NoteItemWidgetState();
}

class _NoteItemWidgetState extends State<NoteItemWidget> {
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
