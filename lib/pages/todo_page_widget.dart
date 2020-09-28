import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes/pages/parts/todo_item_widget.dart';

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
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) => _getWidgets()[index],
    );
  }

  List<ToDoItemWidget> _getWidgets() {
    List<ToDoItemWidget> notes =
        List.generate(10, (index) => ToDoItemWidget("Short text"));
    notes.addAll(List.generate(
        10,
        (index) => ToDoItemWidget(
            '''A lot of energy is squandered because the different parts of our lives, both internal and external, are in conflict with each other. That could be the colleague at work who doesn’t want you to get promoted, the friends who make fun of your goals or even the internal fears and assumptions that keep you hesitating.
Spend some time untangling the different conflicts in your life to see how you could resolve them. Sometimes that can be done in the short-term, by making a change. Sometimes, it requires a long-term plan to escape the toxic environment, social circle or belief system that holds you back.''')));
    notes.shuffle(Random.secure());
    return notes;
  }
}
