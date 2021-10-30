import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'CreateTaskScreen.dart';
import 'Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int bottomNavIndex = 0;
  String taskName = CreateTask.taskName;
  static List<String> emptyList = [];

  clearSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void getBoolValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CreateTask.booleanValue = prefs.getBool('savedBoolean1') ?? false;
    print(CreateTask.booleanValue);
    setState(() {});
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('savedDataOfTask1') ?? emptyList;
    CreateTask.taskList =
        (list.map((e) => TaskWidget.fromMap(jsonDecode(e))).toList());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // clearSP();
    getBoolValue();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /// A expandable calendar implemented as a appBar
        appBar: CalendarAppBar(
          onDateChanged: (value) {
            // print(value);
          },
          firstDate: DateTime.now().subtract(Duration(days: 140)),
          lastDate: DateTime.now(),

          /// colors
          white: Colors.white,
          black: Colors.black,
          accent: Color(0xFF4562FE),
        ),

        /// Scaffold color
        backgroundColor: Colors.white,

        /// This is the 'Add a task floating button'
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF4562FE),
          child: Icon(
            Icons.add,
          ),

          /// Functionality for the 'Add Task' button
          onPressed: () {
            setState(() {
              /// Navigate to the second Screen e.g 'Create Task'
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateTask();
              }));

              /// After the user clicks to make a new task, delete the last task's description e.g clear
              CreateTask.descriptionController.clear();
            });
          },
        ),

        /// Putting the floating button in the center
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        /// BottomNavigationBar Customization
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [Icons.home_filled, Icons.settings],
          activeIndex: bottomNavIndex,
          gapLocation: GapLocation.center,
          inactiveColor: Colors.grey,

          /// Functionality of the BottomNavigationBar
          onTap: (int index) {
            setState(() {
              bottomNavIndex = index;
              if (bottomNavIndex == 1) {
                /// Navigate to the Settings Screen
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingsPage();
                }));

                /// Setting bottomNavIndex to 0, so we can go to the 'Home' icon
                /// on the navigation bottom screen
                bottomNavIndex = 0;
              }
            });
          },
        ),
        body: Column(
          children: [
            /// We  use a ternary operator to check if somebody clicked on the 'Create Task' button.
            CreateTask.booleanValue

                /// if clicked, we put an expanded widget, to fit the most possible tasks in the screen.
                ? Expanded(
                    /// We use a listView.builder to build widgets from the list that we want.
                    child: ListView.builder(
                      /// The count of the widgets to build
                      itemCount: CreateTask.taskList.length,
                      itemBuilder: (context, index) {
                        /// Here we return the CheckboxListTile's saved in the taskList with the index
                        return CreateTask.taskList[index];
                      },
                    ),
                  )

                /// If 'Create Task' button is not clicked, put an empty container, e.g task is not created
                : Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.red,
                  ),
          ],
        ),
      ),
    );
  }
}

/// This is the CheckboxListTile widget template that we'll be using.
// ignore: must_be_immutable
class TaskWidget extends StatefulWidget {
  //Created an object so i could access the 'textOfTheTaskName' after initialization
  static TaskWidget taskWidgetObject = TaskWidget('', '', 0);

  final String textOfTheTaskName;

  final String textOfTheTasksDescription;

  TextDecoration decorOfText = TextDecoration.none;

  Color colorOfTasksText = Color(0xFF000000);

  int intRepresentationOfColorVar;

  TaskWidget(this.textOfTheTaskName, this.textOfTheTasksDescription,
      this.intRepresentationOfColorVar);

  TaskWidget.fromMap(Map<String, dynamic> map)
      : this.textOfTheTaskName = map['taskName'],
        this.textOfTheTasksDescription = map['taskDesc'],
        this.intRepresentationOfColorVar = map['intValue'];

  Map<String, dynamic> toMap() {
    return {
      'taskName': this.textOfTheTaskName,
      'taskDesc': this.textOfTheTasksDescription,
      'intValue': this.intRepresentationOfColorVar,
    };
  }

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool checkboxChecked = false;
  int textColorVariable = Colors.black.value;

  void saveAndUpdateTextColorToRed() async {
    textColorVariable = Colors.red.value;
    widget.intRepresentationOfColorVar = textColorVariable;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('colorOfText1', textColorVariable);
    setState(() {});
  }

  void getColorForTextWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    textColorVariable = prefs.getInt('colorOfText1') ?? 0xFF000000;
    setState(() {});
  }

  // Changes the color of the completed task's text to red.
  void convertTextToRed() {
    if (checkboxChecked == true) {
      setState(() {
        saveAndUpdateTextColorToRed();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getColorForTextWidget();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: checkboxChecked,

      /// This changes where the checkbox starts - right now before the Text e.g checkbox is in front of the text
      controlAffinity: ListTileControlAffinity.leading,

      /// Added the description of the task, below the Task's name in the CheckboxListTile subtitle property.
      subtitle: Text(
        /// Using the object of the TaskWidget, we access the variable and set the Task Description, based on the passed String
        widget.textOfTheTasksDescription,
      ),
      activeColor: Color(0xFF4562FE),
      onChanged: (value) {
        setState(() {
          checkboxChecked = value ?? false;

          /// This checks if the checkbox is ticked, so then calls the method that puts a line trough the text
          convertTextToRed();
        });
      },
      title: Text(
        /// Using the object of the TaskWidget, we access the variable and set the Task Name, based on the passed String
        widget.textOfTheTaskName,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(widget.intRepresentationOfColorVar),
          // decoration: widget.decorOfText,
        ),
      ),
    );
  }
}
