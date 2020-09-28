import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingAddButton extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _FloatingAddButtonState();

}

class _FloatingAddButtonState extends State<FloatingAddButton>{
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => (print("Floating")),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
      backgroundColor: Colors.amber,
    );
  }
}