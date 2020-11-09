import 'package:flutter/material.dart';

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
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (BuildContext context, int index) => _getWidgets()[index],
    );
  }
  var isSelected = false;
  var mycolor=Colors.white;
  List<Widget> _getWidgets() {
//    List<Widget> notes = List.generate(
//        10,
//        (index) => Dismissible(
//            key: UniqueKey(),
//            direction: DismissDirection.endToStart,
//            onDismissed: (direction) => (print("dissmissed:  + $direction")),
//            child: ToDoItemWidget("Short text")));
//    notes.addAll(List.generate(
//        10,
//        (index) => Dismissible(
//            direction: DismissDirection.endToStart,
//            key: UniqueKey(),
//            onDismissed: (direction) => (print("dissmissed:  + $direction")),
////            secondaryBackground: Container(),
//            child: ToDoItemWidget(
//                '''A lot of energy is squandered because the different parts of our lives, both internal and external, are in conflict with each other. That could be the colleague at work who doesn’t want you to get promoted, the friends who make fun of your goals or even the internal fears and assumptions that keep you hesitating.
//Spend some time untangling the different conflicts in your life to see how you could resolve them. Sometimes that can be done in the short-term, by making a change. Sometimes, it requires a long-term plan to escape the toxic environment, social circle or belief system that holds you back.'''))));
//    notes.shuffle(Random.secure());


//    List<Widget> notes = List.generate(
//        10,
//        (index) => ToDoItemWidget("Short text"));
//    notes.addAll(List.generate(
//        10,
//        (index) => ToDoItemWidget(
//                '''A lot of energy is squandered because the different parts of our lives, both internal and external, are in conflict with each other. That could be the colleague at work who doesn’t want you to get promoted, the friends who make fun of your goals or even the internal fears and assumptions that keep you hesitating.
//Spend some time untangling the different conflicts in your life to see how you could resolve them. Sometimes that can be done in the short-term, by making a change. Sometimes, it requires a long-term plan to escape the toxic environment, social circle or belief system that holds you back.''')));
//    notes.shuffle(Random.secure());
    List<Widget> notes = List.generate(
      20,
        (index) => ListTile(
            selected: isSelected,
            leading: const Icon(Icons.info),
            title: new Text("Test"),
            subtitle: new Text("Test Desc"),
            trailing: new Text("3"),
            onLongPress: toggleSelection // what should I put here,
        )
    );
    return notes;
  }

  void toggleSelection() {
    setState(() {
      if (isSelected) {
        mycolor=Colors.white;
        isSelected = false;
      } else {
        mycolor=Colors.grey[300];
        isSelected = true;
      }
    });
  }
}
