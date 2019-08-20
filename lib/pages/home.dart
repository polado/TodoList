import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_list/model/themes.dart';
import 'package:todo_list/pages/tasks.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  navigate() {
    Navigator.pushReplacement(context,
        PageTransition(type: PageTransitionType.downToUp, child: TasksView()));
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "My Tasks",
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Tomica',
                fontWeight: FontWeight.normal),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            "My Tasks",
            style: TextStyle(
              fontSize: 50,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            "Flutter App",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );

    Widget color = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          "Choose Your Color",
          style: TextStyle(fontSize: 24, fontFamily: 'Dosis'),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          size: 30,
        ),
        Container(
          color: Colors.black,
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(
                onTap: () {
                  DynamicTheme.of(context).setThemeData(CustomTheme.redTheme());
                  navigate();
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  DynamicTheme.of(context)
                      .setThemeData(CustomTheme.yellowTheme());
                  navigate();
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  DynamicTheme.of(context)
                      .setThemeData(CustomTheme.blueTheme());
                  navigate();
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  DynamicTheme.of(context)
                      .setThemeData(CustomTheme.indigoTheme());
                  navigate();
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.indigo,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  DynamicTheme.of(context)
                      .setThemeData(CustomTheme.greenTheme());
                  navigate();
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  DynamicTheme.of(context)
                      .setThemeData(CustomTheme.blackTheme());
                  navigate();
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    Widget stack = Container(
      child: Stack(
        children: <Widget>[
          title,
          color,
        ],
      ),
    );

    return Scaffold(
      body: stack,
    );
  }
}
