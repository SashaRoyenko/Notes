import 'package:flutter/material.dart';

class NoteItemWidget extends StatefulWidget {
  final String _text;
  final String _date;
  static int tappedItem = 0;

  NoteItemWidget(this._text, this._date);

  @override
  State<StatefulWidget> createState() => _NoteItemWidgetState();
}

class _NoteItemWidgetState extends State<NoteItemWidget> {
  bool isSelected = false;
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _updateSelectStatusOnLongPress,
      onTap: _updateSelectStatusOnTap,
      behavior: HitTestBehavior.deferToChild,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget._text,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Container(
              child: Stack(children: [
                Opacity(
                  opacity: _opacity,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.amber,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget._date,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSelectStatusOnLongPress() {
    setState(() {
      isSelected = !isSelected;
      _opacity = isSelected ? 1.0 : 0.0;
      int count = NoteItemWidget.tappedItem;
      NoteItemWidget.tappedItem = isSelected
          ? NoteItemWidget.tappedItem = count + 1
          : NoteItemWidget.tappedItem = count - 1;
    });
  }

  void _updateSelectStatusOnTap() {
    if (isSelected || NoteItemWidget.tappedItem > 0) {
      _updateSelectStatusOnLongPress();
    }
  }
}
