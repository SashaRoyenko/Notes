import 'package:flutter/material.dart';
import 'package:notes/enums/app_rouetes.dart';
import 'package:notes/pages/add_note_page_widget.dart';
import 'package:notes/pages/note_page_widget.dart';
import 'package:notes/pages/parts/floating_add_buttton.dart';
import 'package:notes/pages/parts/header_widget.dart';
import 'package:notes/pages/todo_page_widget.dart';
import 'package:notes/service/note_service.dart';
import 'package:notes/state/header_state.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with SingleTickerProviderStateMixin {
  List<Widget> pages = [NotePageWidget(), ToDoPageWidget()];
  HeaderState headerState = HeaderState(Colors.amber, Colors.grey);
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteService(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: HeaderWidget(headerState, () {
              _animateSwipe(() {});
            }),
          ),
          body: GestureDetector(
            onHorizontalDragUpdate: _changePage,
            behavior: HitTestBehavior.translucent,
            child: SlideTransition(
              position: _getAnimation(),
              child: pages[headerState.index],
            ),
          ),
//        child: PageView(
//            children: pages,
//        ),
//        ),
          floatingActionButton: FloatingAddButton(),
        ),
        theme: ThemeData.dark(),
        routes: {
          AppRoutes.NOTE: (context) => AddNotePageWidget(),
        },
      ),
    );
  }

  void _changePage(DragUpdateDetails details) {
    int index = headerState.index;
    if (details.delta.dx <= 0 && index != 1) {
      _animateSwipe(() => headerState.nextPage());
    } else if (details.delta.dx >= 0 && index != 0) {
      _animateSwipe(() => headerState.previousPage());
    }
  }

  Animation<Offset> _getAnimation() {
    return Tween(
            begin: Offset.zero,
            end: Offset(headerState.index == 0 ? -1 : 1, 0.5))
        .animate(_curvedAnimation);
  }

  void _animateSwipe(Function function) {
    _animationController.forward().whenComplete(() {
      setState(() {
        _animationController.reverse();
        function.call();
      });
    });
  }
}
