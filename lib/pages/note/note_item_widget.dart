import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/entity/note.dart';
import 'package:notes/enums/app_routes.dart';

class NoteItemWidget extends StatefulWidget {
  final Key key;
  final Note note;
  final ValueChanged<bool> isSelectedCallback;
  final isAnySelected;
  bool isSelected;

  NoteItemWidget(
      {this.isSelectedCallback, this.isAnySelected, this.key, this.note})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteItemWidgetState();
}

class _NoteItemWidgetState extends State<NoteItemWidget>
    with AutomaticKeepAliveClientMixin<NoteItemWidget> {
  double _opacity = 0.0;
  bool _isWantKeepAlive = false;
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onLongPress: _updateSelectStatusOnLongPress,
      onTap: () => _updateSelectStatusOnTap(context),
      behavior: HitTestBehavior.deferToChild,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.note.text,
              style: Theme.of(context).textTheme.bodyText1,
//              TextStyle(
//                fontSize: 16,
//              ),
            ),
            Container(
              child: Stack(children: [
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(milliseconds: 200),
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
                    formattedDate(),
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
      final navigator = Navigator.of(context);
      navigator.pushNamed(AppRoutes.NOTE, arguments: widget.note);
    }
  }

  String formattedDate() {
    final DateFormat formatter = DateFormat('dd MMMM');
    return formatter.format(DateTime.parse(widget.note.updateDate));
  }


  @override
  bool get wantKeepAlive => _isWantKeepAlive;
}
