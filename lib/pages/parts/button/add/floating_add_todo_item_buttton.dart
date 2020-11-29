import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/pages/todo/add_todo_item_widget.dart';

class FloatingAddTodoItemButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FloatingAddTodoItemButtonState();
}

class _FloatingAddTodoItemButtonState extends State<FloatingAddTodoItemButton> {

  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        /*showGeneralDialog(
          barrierColor: Colors.transparent,
          barrierDismissible: true,
          barrierLabel: "AddTodoItem",
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return Dialog(
              insetPadding: EdgeInsets.all(15),
              child: AddTodoItemPageWidget(),
            );
          },
        );*/
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
                ));
          },
        );
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
      backgroundColor: Colors.amber,
    );
  }
}
