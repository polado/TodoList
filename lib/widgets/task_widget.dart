import 'package:flutter/material.dart';

import '../database_helpers.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  final bool longPressEnabled;
  final VoidCallback callback, dissmiss;
  final bool isSelected;
  final int index;

  TaskWidget({this.longPressEnabled,
      this.callback,
      this.isSelected,
    this.index,
    this.task,
    this.dissmiss});

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
        print('tapppp ${widget.longPressEnabled}');
        if (widget.longPressEnabled) widget.callback();
      },
      onHorizontalDragEnd: (details) {
        print('drag ended');
        widget.dissmiss();
      },
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          widget.dissmiss();
        }
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
                widget.task.taskName,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontFamily: 'Tomica',
                  fontWeight: FontWeight.normal,
                  decoration: widget.task.isActive
                      ? TextDecoration.none
                      : TextDecoration.lineThrough,
                ),
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
