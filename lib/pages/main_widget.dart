import 'package:flutter/material.dart';
import 'package:notes/pages/note_page_widget.dart';
import 'package:notes/pages/parts/floating_add_buttton.dart';
import 'package:notes/pages/parts/header_widget.dart';
import 'package:notes/pages/todo_page_widget.dart';
import 'package:notes/state/header_state.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  List<Widget> pages = [NotePageWidget(), ToDoPageWidget()];
  HeaderState headerState = HeaderState(Colors.amber, Colors.grey);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: HeaderWidget(headerState, () => (setState(() {}))),
        ),
        body: GestureDetector(
          onHorizontalDragUpdate: (DragUpdateDetails details) => (setState(() {
            int index = headerState.index;
            if (details.delta.dx <= 0 && index != 1) {
              headerState.nextPage();
            } else if (details.delta.dx >= 0 && index != 0) {
              headerState.previousPage();
            }
          })),
          child: pages[headerState.index],
        ),
        floatingActionButton: FloatingAddButton(),
      ),
      theme: ThemeData.dark(),
    );
  }
}
