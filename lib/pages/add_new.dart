import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/pages/tasks.dart';
import 'package:todo_list/widgets/add_task_dialog.dart';

import '../database_helpers.dart';

class AddNewView extends StatefulWidget {
  final bool typeNew;
  final Task task;

  AddNewView({Key key, this.typeNew, this.task}) : super(key: key);

  @override
  _AddNewViewState createState() => _AddNewViewState();
}

class _AddNewViewState extends State<AddNewView> {
  String title,
      saveButtonText,
      taskDay = "Tab to choose a day";

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dayController =
  TextEditingController(text: 'Tab to choose a day');

  _save() async {
    Task task = Task();
    if (widget.typeNew) {
      task.taskName = nameController.text;
      task.description = descriptionController.text;
      task.taskDate = dayController.text;
      task.isActive = true;
      DatabaseHelper helper = DatabaseHelper.instance;
      int id = await helper.insert(task);
      print('inserted row: $id');
    } else {
      task = widget.task;
      task.taskName = nameController.text;
      task.description = descriptionController.text;
      task.taskDate = dayController.text;
      task.isActive = true;
      print(task);
      DatabaseHelper helper = DatabaseHelper.instance;
      int res = await helper.updateInActive(task);
      print('updated row: $res');
    }

    navigate();
  }

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
    await Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) => new AddTaskDialogWidget(),
      fullscreenDialog: true,
    ));

//    if (txt != null)
//      setState(() {
//        taskDay = txt;
//      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.typeNew) {
      title = 'Add New';
      saveButtonText = 'Add the task +';
    } else {
      title = 'Edit';
      saveButtonText = 'Save the task +';
      dayController.text = widget.task.taskDate;
      nameController.text = widget.task.taskName;
      descriptionController.text = widget.task.description;
    }
  }

  @override
  Widget build(BuildContext context) {


    Widget appbar = AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigate();
          }),
      title: Text(title),
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
                        style: TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColorDark),
                        controller: nameController,
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
                        controller: descriptionController,
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
                        child: Text(
                          dayController.text,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontFamily: 'Tomica',
                              fontWeight: FontWeight.normal),
                        ),
                        onPressed: () {
                          _getDay();
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
                color: Theme
                    .of(context)
                    .primaryColorDark,
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.all(24),
                  child: Text(
                    saveButtonText,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                        fontFamily: 'Tomica',
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    print(dayController.text);
                    (nameController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty)
                        ? _save()
                        : print('No Data');
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

  _getDay() async {
    await _openAddEntryDialog();
    var sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      print(sharedPreferences.getString('Day'));
//      taskDay = sharedPreferences.getString('Day');
      dayController.text = sharedPreferences.getString('Day');
//      if (!widget.typeNew) widget.task.taskDate = dayController.text;
      sharedPreferences.remove('Day');
    });
    print('getday ' + dayController.text);
  }
}
