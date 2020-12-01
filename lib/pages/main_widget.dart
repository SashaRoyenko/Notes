import 'package:flutter/material.dart';
import 'package:notes/factory/app_bar_factory.dart';
import 'package:notes/pages/parts/button/add/floating_add_note_buttton.dart';
import 'package:notes/pages/parts/button/add/floating_add_todo_item_buttton.dart';
import 'package:notes/pages/todo/todo_page_widget.dart';
import 'package:notes/service/note_service.dart';
import 'package:notes/service/theme_service.dart';
import 'package:notes/service/todo_item_service.dart';
import 'package:notes/state/app_bar_state.dart';
import 'package:notes/state/header_state.dart';
import 'package:provider/provider.dart';

import 'file:///D:/KPI/4.1/flutter/notes/lib/utils/route_generator.dart';

import 'note/note_page_widget.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget>
    with SingleTickerProviderStateMixin {
  List<Widget> pages = [NotePageWidget(), ToDoPageWidget()];
  HeaderState _headerState;
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;
  AppBarState _appBarState;
  ThemeService _themeService;

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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NoteService()),
          ChangeNotifierProvider(create: (context) => TodoItemService()),
          ChangeNotifierProvider(create: (context) => ThemeService()),
          ChangeNotifierProvider(
              create: (context) => AppBarState(
                  AppBarFactory.headerAppBar(_headerState, _animateSwipe))),
          ChangeNotifierProvider(
              create: (context) => HeaderState(Colors.amber, Colors.grey)),
        ],
        child: Builder(
          builder: (context) {
            _appBarState = Provider.of<AppBarState>(context);
            _headerState = Provider.of<HeaderState>(context);
            _themeService = Provider.of<ThemeService>(context);
            return MaterialApp(
              home: Scaffold(
                appBar: _appBarState.appBar,
                body: GestureDetector(
                  onHorizontalDragUpdate: _changePage,
                  behavior: HitTestBehavior.translucent,
                  child: SlideTransition(
                    position: _getAnimation(),
                    child: pages[_headerState.index],
                  ),
                ),
//        body: PageView(
//            children: pages,
//        ),
//        ),
                floatingActionButton: getAddButton(),
              ),
              theme: _themeService.currentTheme,
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          },
        ));
  }

  void _changePage(DragUpdateDetails details) {
    int index = _headerState.index;
    if (details.delta.dx <= 0 && index != 1) {
      _animateSwipe(() => _headerState.nextPageWithNotify());
    } else if (details.delta.dx >= 0 && index != 0) {
      _animateSwipe(() => _headerState.previousPageWithNotify());
    }
  }

  Animation<Offset> _getAnimation() {
    return Tween(
            begin: Offset.zero,
            end: Offset(_headerState.index == 0 ? -1 : 1, 0.5))
        .animate(_curvedAnimation);
  }

  void _animateSwipe(Function function) {
    _animationController.forward().whenComplete(() {
      setState(() {
        _appBarState.appBar = _appBarState.mainBar;
        _animationController.reverse();
        function.call();
      });
    });
  }

  Widget getAddButton() {
    return _headerState.index == 0
        ? FloatingAddNoteButton()
        : FloatingAddTodoItemButton();
  }
}
