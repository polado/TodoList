import 'package:flutter/material.dart';

class DoneTaskWidget extends StatelessWidget {
  String taskName, description;
  DateTime taskDate;

  DoneTaskWidget({this.taskName, this.description, this.taskDate});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    taskName,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontFamily: 'Tomica',
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              new Spacer(),
              Visibility(
                child: Radio(
                  value: 1,
                ),
                visible: false,
              )
            ],
          )),
    );
  }
}
