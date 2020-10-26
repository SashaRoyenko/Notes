import 'package:flutter/material.dart';
import 'package:notes/pages/parts/header_widget.dart';
import 'package:notes/state/header_state.dart';

class AppBarFactory {
  AppBarFactory._();

  static AppBar headerAppBar(HeaderState headerState, Function function) =>
      AppBar(
        title: HeaderWidget(() {
          function.call(() {});
        }),
      );

  static AppBar multiSelectDeleteAppBar(int count, Function deleteFunction) =>
      AppBar(title: Text("$count item selected"), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          tooltip: 'Delete selected items',
          onPressed: () {
            deleteFunction.call();
          },
        ),
      ]);
}
