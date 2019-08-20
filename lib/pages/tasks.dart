import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_list/widgets/done_tasks_widget.dart';
import 'package:todo_list/widgets/task_widget.dart';

import 'add_new.dart';
import 'home.dart';

class TasksView extends StatefulWidget {
  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool longPressFlag = false;
  List<Element> indexList = new List();
  List<int> clicked = new List();

  Widget icon = Icon(Icons.view_module);
  bool iconSwitch = true;

  List<String> tasks = [
    "Feed the Cat",
    "Buy Pepsi",
    "Pay Internet Bill",
    "Call Uncle Hany",
    "Wash Your Cloth"
  ];

  onElementSelected(int index) {
    setState(() {
      indexList[index].isSelected = !indexList[index].isSelected;
    });
  }

  void longPress() {
    print("longpress ${clicked.length}");
    setState(() {
      if (clicked.isEmpty) {
        longPressFlag = false;
      } else {
        longPressFlag = true;
      }
    });
  }

  void clearAll() {
    setState(() {
      longPressFlag = false;
      clicked.clear();
      for (int i = 0; i < indexList.length; i++) {
        indexList[i].isSelected = false;
      }
    });
  }

  Widget _getTaskWidget(BuildContext context, int index) {
    return new TaskWidget(
      index: index,
      taskName: tasks[index],
      isSelected: indexList[index].isSelected,
      longPressEnabled: longPressFlag,
      callback: () {
        onElementSelected(index);
        if (clicked.contains(index)) {
          clicked.remove(index);
        } else {
          clicked.add(index);
        }

        longPress();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < tasks.length; i++) {
      indexList.add(Element(isSelected: false));
    }

    Widget bottomSheet = Container(
      color: Colors.black,
      child: Padding(
          padding: EdgeInsets.all(8),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      child: Center(
                        child: Text(
                          "Done Tasks",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Tomica',
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  DoneTaskWidget(
                    taskName: "Call my Dad",
                  ),
                  DoneTaskWidget(
                    taskName: "Check my Car Engine",
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.keyboard_arrow_down),
                  Text(
                    "Undone",
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                ],
              )
            ],
          )),
    );

    Widget appbar = AppBar(
      automaticallyImplyLeading: false,
      title: InkWell(
        onTap: () => Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.upToDown, child: HomeView())),
        child: Text(
          "My Tasks",
          style: TextStyle(fontFamily: 'Tomica', fontWeight: FontWeight.normal),
        ),
      ),
      actions: <Widget>[
        Center(
          child: Text(
            "Sunday >",
            textScaleFactor: 1.5,
            style: TextStyle(
                fontSize: 10,
                fontFamily: 'Tomica',
                fontWeight: FontWeight.normal),
          ),
        ),
        Visibility(
            visible: !longPressFlag,
            child: IconButton(
              tooltip: "Change View",
              icon: icon,
              onPressed: () {
                setState(() {
                  icon = iconSwitch
                      ? Icon(Icons.view_list)
                      : Icon(Icons.view_module);
                  iconSwitch = !iconSwitch;
                });
              },
            )),
        Visibility(
            visible: longPressFlag,
            child: IconButton(
              tooltip: "Cancel",
              icon: Icon(Icons.close),
              onPressed: () => clearAll(),
            )),
      ],
    );

    Widget body = Column(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: _getTaskWidget,
            itemCount: 5,
          ),
        )),
        Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              disabledBorderColor: Colors.black87,
              disabledTextColor: Colors.black54,
              textColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(16),
              child: Text(
                "Add New +",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Tomica',
                    fontWeight: FontWeight.normal),
              ),
              onPressed: longPressFlag
                  ? null
                  : () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: AddNewView()));
                    },
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Visibility(
            visible: !longPressFlag,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: InkWell(
                onTap: () {
                  print("show botttom sheet");
                  _scaffoldKey.currentState
                      .showBottomSheet((context) => bottomSheet);
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.keyboard_arrow_up),
                      Text(
                        "Done",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            )),
        Visibility(
          visible: longPressFlag,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: (clicked.length <= 1)
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    visible: clicked.length <= 1,
                    child: FlatButton(
                        onPressed: () => clearAll(),
                        child: Text(
                          "Edit",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                  FlatButton(
                      onPressed: () => clearAll(),
                      child: Text(
                        "Delete",
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: appbar,
      body: body,
    );
  }
}

class Element {
  bool isSelected;

  Element({this.isSelected});
}
