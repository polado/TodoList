import 'package:flutter/material.dart';

class AddTaskDialogWidget extends StatefulWidget {
  @override
  _AddTaskDialogWidgetState createState() => _AddTaskDialogWidgetState();
}

class _AddTaskDialogWidgetState extends State<AddTaskDialogWidget> {
  List<String> days = [
    "Satarday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];

  List<Element> indexList = new List();
  bool selected = false;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  Widget _getDays2(BuildContext context, int index) {
    return new DayWidget(
      index: index,
      text: days[index],
      isSelected: indexList[index].isSelected,
      callback: () {
        print('hello $selected ${indexList[index].isSelected}');
        if (!selected || indexList[index].isSelected)
          setState(() {
            indexList[index].isSelected = !indexList[index].isSelected;
            selected = !selected;
            selectedIndex = index;
          });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 7; i++) {
      indexList.add(Element(isSelected: false));
    }

    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Choose Day",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemBuilder: _getDays2,
                itemCount: 7,
              ),
            )),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.all(24),
                child: Text(
                  "Done",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                      fontFamily: 'Tomica',
                      fontWeight: FontWeight.normal),
                ),
                onPressed: () {
                  if (selected) {
                    print("pressed");
//                    Navigator.of(context).pop('Sunday');
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

class DayWidget extends StatefulWidget {
  final int index;
  final String text;
  final bool longPressEnabled;
  final VoidCallback callback;
  final bool isSelected;

  const DayWidget(
      {Key key,
      this.index,
      this.text,
      this.longPressEnabled,
      this.callback,
      this.isSelected})
      : super(key: key);

  @override
  _DayWidgetState createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.callback();
        },
        child: Card(
          elevation: 0,
          color: widget.isSelected ? Colors.white : Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              widget.text,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontFamily: 'Tomica',
                  fontWeight: FontWeight.normal),
            ),
          ),
        ));
  }
}

class Element {
  bool isSelected;

  Element({this.isSelected});
}