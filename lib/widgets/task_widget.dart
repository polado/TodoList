import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  final String taskName, description;
  final DateTime taskDate;
  final bool longPressEnabled;
  final VoidCallback callback;
  final bool isSelected;
  final int index;

  TaskWidget(
      {this.taskName,
      this.description,
      this.taskDate,
      this.longPressEnabled,
      this.callback,
      this.isSelected,
      this.index});

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onLongPress: () => widget.callback(),
      onTap: () {
        if (widget.longPressEnabled) widget.callback();
      },
      child: Card(
        elevation: 0,
        color: widget.isSelected ? Colors.grey : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                widget.taskName,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Tomica',
                    fontWeight: FontWeight.normal),
              ),
            ),
            new Spacer(),
            Visibility(
              child: Radio(
                activeColor: Colors.black,
                value: true,
                groupValue: widget.isSelected,
              ),
              visible: widget.isSelected,
            ),
            Padding(padding: EdgeInsets.only(left: 0))
          ],
        ),
      ),
    );
  }
}

class TaskWidget2 extends StatelessWidget {
  String taskName, description;
  DateTime taskDate;

  TaskWidget2({this.taskName, this.description, this.taskDate});

  bool visibilityFlag = false;

  void changeVisibility() {
    visibilityFlag = !visibilityFlag;
  }

  Widget visibility = Visibility(
    child: Radio(
      value: 1,
    ),
    visible: false,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: new GestureDetector(
          onLongPress: () => "long press $taskName",
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  taskName,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontFamily: 'Tomica',
                      fontWeight: FontWeight.normal),
                ),
                new Spacer(),
                visibility
              ],
            ),
          )),
    );
  }
}
