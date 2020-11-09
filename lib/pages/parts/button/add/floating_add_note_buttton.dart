import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/enums/app_routes.dart';

class FloatingAddNoteButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FloatingAddNoteButtonState();
}

class _FloatingAddNoteButtonState extends State<FloatingAddNoteButton> {
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return FloatingActionButton(
      onPressed: () => navigator.pushNamed(AppRoutes.NOTE),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
      backgroundColor: Colors.amber,
    );
  }
}
