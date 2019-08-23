import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/model/themes.dart';
import 'package:todo_list/pages/tasks.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _getTheme() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      String theme = sharedPreferences.get('Theme');
      print('shared pref $theme');
      if (theme != null)
        _setTheme(theme);
      else
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.downToUp, child: HomeView()));
    });
  }

  _setTheme(String theme) {
    switch (theme) {
      case 'red':
        DynamicTheme.of(context).setThemeData(CustomTheme.redTheme());
        break;
      case 'yellow':
        DynamicTheme.of(context).setThemeData(CustomTheme.yellowTheme());
        break;
      case 'blue':
        print('bluw');
        DynamicTheme.of(context).setThemeData(CustomTheme.blueTheme());
        break;
      case 'indigo':
        DynamicTheme.of(context).setThemeData(CustomTheme.indigoTheme());
        break;
      case 'green':
        DynamicTheme.of(context).setThemeData(CustomTheme.greenTheme());
        break;
      case 'black':
        DynamicTheme.of(context).setThemeData(CustomTheme.blackTheme());
        break;
      default:
        DynamicTheme.of(context).setThemeData(CustomTheme.blackTheme());
    }

    navigate();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _getTheme();
  }

  navigate() {
    Navigator.pushReplacement(context,
        PageTransition(type: PageTransitionType.downToUp, child: TasksView()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Scaffold(
            body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Loading..."),
          Padding(padding: EdgeInsets.only(top: 20)),
          CircularProgressIndicator(),
        ],
      ),
    )));
  }
}
