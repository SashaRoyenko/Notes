import 'package:flutter/material.dart';
import 'package:notes/animation/ScaleRoute.dart';
import 'package:notes/enums/app_routes.dart';
import 'package:notes/pages/main_widget.dart';
import 'package:notes/pages/note/add_note_page_widget.dart';

class RouteGenerator {

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.HOME:
        return MaterialPageRoute(builder: (_) => MainWidget());
      case AppRoutes.NOTE:
        return ScaleRoute(page: AddNotePageWidget(
            navigationParams: routeSettings.arguments
        ));
      default:
        return MaterialPageRoute(builder: (_) => MainWidget());
    }
  }
}
