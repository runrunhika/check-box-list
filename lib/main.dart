import 'package:checkbox_list_group_sample/model/checkbox_state.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(unselectedWidgetColor: Colors.red),
      home: MyHomePage(title: 'CheckBox List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final allNotifications = CheckBoxState(title: "Allow Notifications");

  final notifications = [
    CheckBoxState(title: "CheckBoxListTile 1"),
    CheckBoxState(title: "CheckBoxListTile 2"),
    CheckBoxState(title: "CheckBoxListTile 3"),
    CheckBoxState(title: "CheckBoxListTile 4"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          buildGroupCheckbox(allNotifications),
          Divider(
            color: Colors.white,
          ),
          ...notifications.map(buildSingleCheckbox).toList()
        ],
      ),
    );
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.red,
        value: checkbox.value,
        title: Text(
          checkbox.title,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onChanged: (value) {
          setState(() {
            checkbox.value = value!;
            allNotifications.value =
                notifications.every((notification) => notification.value);
          });
        });
  }

  Widget buildGroupCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.red,
        value: checkbox.value,
        title: Text(
          checkbox.title,
          style: TextStyle(fontSize: 20),
        ),
        onChanged: toggleGroupSCheckbox,
      );

  void toggleGroupSCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      allNotifications.value = value;
      notifications.forEach((notification) => notification.value = value);
    });
  }
}
