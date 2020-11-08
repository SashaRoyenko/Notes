import 'package:flutter/material.dart';

class AppBarState extends ChangeNotifier{

  Widget _appBar;
  Widget _mainBar;

  AppBarState(Widget mainBar) {
        this._mainBar = mainBar;
        this._appBar = mainBar;
  }

  Widget get appBar => _appBar;

  set appBar(Widget value) {
    _appBar = value;
    notifyListeners();
  }

  Widget get mainBar => _mainBar;

}

