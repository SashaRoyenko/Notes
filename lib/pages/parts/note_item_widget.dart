import 'package:flutter/material.dart';

class NoteItemWidget extends StatefulWidget {
  final Key key;
  final String text;
  final String date;
  final ValueChanged<bool> isSelectedCallback;
  final isAnySelected;
  bool isSelected;
  NoteItemWidget({this.text, this.date, this.isSelectedCallback, this.isAnySelected, this.key, this.isSelected});

  @override
  State<StatefulWidget> createState() => _NoteItemWidgetState();
}

class _NoteItemWidgetState extends State<NoteItemWidget>
    with AutomaticKeepAliveClientMixin<NoteItemWidget>
{
//  bool widget.isSelected = false;
  double _opacity = 0.0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              widget.text,
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
                    widget.date,
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
      widget.isSelected = !widget.isSelected;
      _opacity = widget.isSelected ? 1.0 : 0.0;
      widget.isSelectedCallback(widget.isSelected);
    });
  }

  void _updateSelectStatusOnTap() {
      if(widget.isAnySelected) {
        _updateSelectStatusOnLongPress();
      }
  }

  @override
  bool get wantKeepAlive => true;
}
