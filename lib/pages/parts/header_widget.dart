import 'package:flutter/material.dart';
import 'package:notes/state/header_state.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {

  final Function() _notifyParent;
  HeaderWidget(this._notifyParent);

  @override
  State<StatefulWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  HeaderState _state;
  @override
  Widget build(BuildContext context) {
    _state = Provider.of<HeaderState>(context);
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: () {
                _updatePage(1);
              },
              icon: Icon(Icons.assignment),
              color: _state.noteColor,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
            ),
            IconButton(
              onPressed: () {
                _updatePage(0);
              },
              icon: Icon(Icons.check_box),
              color: _state.toDoColor,
            ),
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => (print("Pressed")),
            icon: Icon(Icons.more_vert),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void _updatePage(int index) {
    setState(() {
      _state.updateStateToPage(index);
      widget._notifyParent.call();
    });
  }
}
