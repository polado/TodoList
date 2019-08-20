import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_list/pages/tasks.dart';
import 'package:todo_list/widgets/add_task_dialog.dart';

class AddNewView extends StatefulWidget {
  @override
  _AddNewViewState createState() => _AddNewViewState();
}

class _AddNewViewState extends State<AddNewView> {
  String taskDay = "Tab to choose a day";
  Text buttonText = Text(
    "Tab to choose a day",
    style: TextStyle(
        fontSize: 20,
        color: Colors.black87,
        fontFamily: 'Tomica',
        fontWeight: FontWeight.normal),
  );

  void navigate() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight, child: TasksView()));
  }

  Future _openAddEntryDialog() async {
//    Text txt = await Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) => new AddTaskDialogWidget(),
//            fullscreenDialog: true));
    Text txt = await Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) => new AddTaskDialogWidget(),
      fullscreenDialog: true,
    ));

    if (txt != null)
      setState(() {
        buttonText = txt;
      });
  }

  @override
  Widget build(BuildContext context) {
    Widget appbar = AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigate();
          }),
      title: Text("Add New"),
    );

    Widget body = Container(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Task Name",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Example: Take the medicine"),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Description",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        minLines: 5,
                        maxLines: 8,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText:
                                "I should eat before medicine, and don't have to wait after eating."),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Task Day",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(16),
                        child: buttonText,
                        onPressed: () {
                          _openAddEntryDialog();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.all(24),
                  child: Text(
                    "Add the task +",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                        fontFamily: 'Tomica',
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    navigate();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: appbar,
      body: body,
    );
  }
}
