import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoItemPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddTodoPageWidgetState();
}

class _AddTodoPageWidgetState extends State<AddTodoItemPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: Colors.black45,
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Click done to create todo subtask',
              border: InputBorder.none,
            ),
            cursorColor: Colors.amber,
            autofocus: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.white10,
                padding: EdgeInsets.symmetric(horizontal: 15),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.alarm),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Text("Set a reminder"),
                  ],
                ),
              ),
              MaterialButton(
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () => print("Saved"),
              )
            ],
          )
        ],
      ),
    );
  }
}
