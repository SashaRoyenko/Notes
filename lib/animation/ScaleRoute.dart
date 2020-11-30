import 'package:flutter/material.dart';

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  final Alignment alignment;
  final Curve curve;

  ScaleRoute(
      {@required this.page,
      this.alignment = Alignment.center,
      this.curve = Curves.ease})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            alignment: alignment,
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: curve,
              ),
            ),
            child: child,
          ),
        );
}
