import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_list/widgets/task_widget.dart';

import '../database_helpers.dart';
import 'add_new.dart';
import 'home.dart';

class TasksView extends StatefulWidget {
  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool longPressFlag = false;
  List<Element> indexListActive = new List();
  List<Element> indexListInActive = new List();
  List<int> clicked = new List();

  Widget icon = Icon(Icons.view_module);
  bool iconSwitch = true;

  bool isTasksLoaded = false;

  List<String> tasks = [
    "Feed the Cat",
    "Buy Pepsi",
    "Pay Internet Bill",
    "Call Uncle Hany",
    "Wash Your Cloth"
  ];

  List<Task> activeTasks, inActiveTasks;
  List<Task> list2, list;

  _readActiveTasks() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    list2 = await helper.queryActiveTasks();
    if (list2 == null) {
      print('read rows: empty');
    } else {
      list2.forEach(
              (t) => print('read row ${t.id} ${t.taskName} ${t.isActive}'));

      setState(() {
        indexListActive.clear();
        for (var i = 0; i < activeTasks.length; i++) {
          indexListActive.add(Element(isSelected: false));
        }
        activeTasks = list2;
      });
    }
  }

  _readInActiveTasks() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    list = await helper.queryInActiveTasks();
    if (list == null) {
      print('read rows: empty');
    } else {
      list.forEach(
              (t) => print('read row ${t.id} ${t.taskName} ${t.isActive}'));

      setState(() {
        indexListInActive.clear();
        for (var i = 0; i < inActiveTasks.length; i++) {
          indexListInActive.add(Element(isSelected: false));
        }
        inActiveTasks = list;
      });
    }
  }

  _updateActiveTask(Task task) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int res = await helper.updateActive(task);
    if (res == 1)
      setState(() {
        activeTasks.remove(task);

        indexListActive.clear();
        for (var i = 0; i < activeTasks.length; i++) {
          indexListActive.add(Element(isSelected: false));
        }

        clearAll();

        _readInActiveTasks();
      });
  }

  _updateInActiveTask(Task task) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int res = await helper.updateInActive(task);
    if (res == 1)
      setState(() {
        inActiveTasks.remove(task);
        print(indexListInActive.length);

        indexListInActive.clear();
        for (var i = 0; i < inActiveTasks.length; i++) {
          indexListInActive.add(Element(isSelected: false));
        }
        print(indexListInActive.length);

        clearAll();

        _readActiveTasks();
      });
  }

  _deleteTask(int id) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int res = await helper.delete(id);
    if (res == 1)
      setState(() {
        Task tt;
        activeTasks.forEach((t) {
          if (t.id == id) tt = t;
        });

        activeTasks.remove(tt);

        indexListActive.clear();
        for (var i = 0; i < activeTasks.length; i++) {
          indexListActive.add(Element(isSelected: false));
        }

        clearAll();
      });
  }

  _deleteTasks(List<int> ids) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int res = await helper.deleteMulti(ids);
    if (res > 1)
      setState(() {
        List<Task> lt = new List<Task>();
        activeTasks.forEach((t) {
          if (ids.contains(t.id)) lt.add(t);
        });

        lt.forEach((t) => activeTasks.remove(t));

        indexListActive.clear();
        for (var i = 0; i < activeTasks.length; i++) {
          indexListActive.add(Element(isSelected: false));
        }

        clearAll();
      });
  }

  onElementSelected(int index) {
    setState(() {
      indexListActive[index].isSelected = !indexListActive[index].isSelected;
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
    print('longpressflag $longPressFlag');
  }

  void clearAll() {
    setState(() {
      longPressFlag = false;
      clicked.clear();
      for (int i = 0; i < indexListActive.length; i++) {
        indexListActive[i].isSelected = false;
      }
    });
  }

  Widget _getActiveTaskWidget(BuildContext context, int index) {
    return new TaskWidget(
      index: index,
      task: activeTasks[index],
      isSelected: indexListActive[index].isSelected,
      longPressEnabled: longPressFlag,
      callback: () {
        print('callback');
        onElementSelected(index);
        if (clicked.contains(index)) {
          clicked.remove(index);
        } else {
          clicked.add(index);
        }

        longPress();
      },
      dissmiss: () {
        print('index $index ${activeTasks[index].taskName}');
        _updateActiveTask(activeTasks[index]);
      },
    );
  }

  Widget _getInActiveTaskWidget(BuildContext context, int index) {
    return new TaskWidget(
      index: index,
      task: inActiveTasks[index],
      isSelected: indexListInActive[index].isSelected,
      longPressEnabled: false,
      callback: () {},
      dissmiss: () {
        print('index $index ${inActiveTasks[index].taskName}');
        _updateInActiveTask(inActiveTasks[index]);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    activeTasks = new List<Task>();
    inActiveTasks = new List<Task>();
    _readActiveTasks();
    _readInActiveTasks();
  }

  Widget tempBody,
      primeBody = Text(""),
      body,
      bottomSheet;

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < activeTasks.length; i++) {
      indexListActive.add(Element(isSelected: false));
    }

    for (var i = 0; i < inActiveTasks.length; i++) {
      indexListInActive.add(Element(isSelected: false));
    }

    bottomSheet = Container(
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
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemBuilder: _getInActiveTaskWidget,
                          itemCount: inActiveTasks.length,
                        ),
                      )),
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
            "${DateFormat('EEEE').format(DateTime.now())} >",
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

    body = Column(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: _getActiveTaskWidget,
            itemCount: activeTasks.length,
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
                              child: AddNewView(
                                typeNew: true,
                              )));
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: AddNewView(
                                    typeNew: false,
                                    task: activeTasks[clicked.first],
                                  )));
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                  FlatButton(
                      onPressed: () {
                        if (clicked.length == 1)
                          _deleteTask(activeTasks[clicked.first].id);
                        else if (clicked.length > 1) {
                          List<int> ids = new List<int>();
                          clicked.forEach((i) => ids.add(i));
                          _deleteTasks(ids);
                        }
                      },
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
