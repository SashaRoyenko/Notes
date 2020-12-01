import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/service/theme_service.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  String _animationName;
  bool _isDarkTheme;
  ThemeService _themeService;

  @override
  void initState() {
    super.initState();
    _themeService = ThemeService();
    _isDarkTheme = _themeService.isDarkTheme;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeService = Provider.of<ThemeService>(context);
    _isDarkTheme = _themeService.isDarkTheme;
    _initThemeAnimation(_isDarkTheme);
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            navigator.pop();
          },
          icon: Icon(Icons.keyboard_backspace),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
//            SwitchListTile(
//              onChanged: (bool value) {
//                setState(() {
//                  themeValue = value;
//                });
//              },
//              value: themeValue,
//              activeColor: Colors.amber,
//              contentPadding:
//                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//              title: Text("Change theme"),
//              secondary: Icon(
//                Icons.nights_stay,
//              ),
//            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(child: child, scale: animation);
                    },
                    child: Icon(
                      _isDarkTheme ? Icons.nights_stay : Icons.wb_sunny,
                      color: Colors.amber,
                      key: Key(_isDarkTheme ? "darkThemeKey" : "lightThemeKey"),
                    ),
                  ),
//                  Icon(
//                    isDarkTheme ? Icons.nights_stay : Icons.wb_sunny,
//                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Change theme",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _setThemeChangingAnimation();
                        _themeService.changeTheme();
                      });
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      child: FlareActor(
                        'assets/animation/switch_daytime.flr',
                        animation: _animationName,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        callback: (s) {
                          setState(() {
                            _setCurrentThemeAnimation();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _setThemeChangingAnimation() {
    if (_isDarkTheme) {
      _animationName = 'switch_day';
      _isDarkTheme = false;
    } else {
      _animationName = 'switch_night';
      _isDarkTheme = true;
    }
  }

  void _initThemeAnimation(isDarkTheme) {
    if (!isDarkTheme) {
      _animationName = 'switch_day';
      _isDarkTheme = false;
    } else {
      _animationName = 'switch_night';
      _isDarkTheme = true;
    }
  }

  void _setCurrentThemeAnimation() {
    _animationName = _isDarkTheme ? 'night_idle' : 'day_idle';
  }
}
