import 'package:flutter/material.dart';
import 'package:notes/pages/todo/todo_item_widget.dart';

class ToDoPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToDoPageWidgetState();
}

class _ToDoPageWidgetState extends State<ToDoPageWidget> {
//  List<NoteItemWidget> _notes = _getWidgets();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: 5,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (BuildContext context, int index) => _getWidgets()[index],
    );
  }

  var isSelected = false;
  var mycolor = Colors.white;

  List<Widget> _getWidgets() {
//    List<Widget> notes = List.generate(
////      20,
////        (index) => ListTile(
////            selected: isSelected,
////            leading: const Icon(Icons.info),
////            title: new Text("Test"),
////            subtitle: new Text("Test Desc"),
////            trailing: new Text("3"),
////            onLongPress: toggleSelection // what should I put here,
////        )
////    );
    List<Widget> todoWidgets = List.generate(
        5,
        (index) => ToDoItemWidget(
          "Finish labs"
        ));
    return todoWidgets;
  }

  void toggleSelection() {
    setState(() {
      if (isSelected) {
        mycolor = Colors.white;
        isSelected = false;
      } else {
        mycolor = Colors.grey[300];
        isSelected = true;
      }
    });
  }
}
