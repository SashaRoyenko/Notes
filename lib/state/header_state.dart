import 'dart:ui';

import 'package:flutter/material.dart';

class HeaderState {
  int _index = 0;

  Color _noteColor;
  Color _toDoColor;

  final Color _ACTIVE_COLOR;
  final Color _UN_ACTIVE_COLOR;

  HeaderState(this._ACTIVE_COLOR, this._UN_ACTIVE_COLOR) {
    _noteColor = _ACTIVE_COLOR;
    _toDoColor = _UN_ACTIVE_COLOR;
  }

  void nextPage() {
    _index++;
    _noteColor = _UN_ACTIVE_COLOR;
    _toDoColor = _ACTIVE_COLOR;
  }

  void previousPage() {
    _index--;
    _noteColor = _ACTIVE_COLOR;
    _toDoColor = _UN_ACTIVE_COLOR;
  }

  void updateState() {
    switch (index) {
      case 0:
        nextPage();
        break;
      case 1:
        previousPage();
        break;
    }
  }

  Color get toDoColor => _toDoColor;

  Color get noteColor => _noteColor;

  int get index => _index;
}
