import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'CreateTaskScreen.dart';
import 'Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:json_serializable/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';

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
    CreateTask.booleanValue = prefs.getBool('savedBoolean27') ?? false;
    print(CreateTask.booleanValue);
    setState(() {});
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('savedDataOfTask27') ?? emptyList;
    CreateTask.taskList =
        (list.map((e) => TaskWidget.fromJson(jsonDecode(e))).toList());
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
  static TaskWidget taskWidgetObject = TaskWidget('', '', Colors.black);

  final String textOfTheTaskName;

  final String textOfTheTasksDescription;

  TextDecoration decorOfText = TextDecoration.none;

  Color colorOfTasksText;

  int intRepresentationOfColorVar = 0;

  String stringRepresentationofTextDecVar = "";

  TaskWidget(this.textOfTheTaskName, this.textOfTheTasksDescription,
      this.colorOfTasksText);

  TaskWidget.fromJson(Map<String, dynamic> map)
      : this.textOfTheTaskName = map['taskName'],
        this.textOfTheTasksDescription = map['taskDesc'],
        this.colorOfTasksText = map['color'];

  Map<String, dynamic> toJson() {
    return {
      'taskName': this.textOfTheTaskName,
      'taskDesc': this.textOfTheTasksDescription,
      'color': this.colorOfTasksText,
    };
  }

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool checkboxChecked = false;
  int textColorVariable = Colors.black.value;
  TextDecoration textDecor = TextDecoration.none;
  String test = "";
  bool isRed = false;
  bool savedValOfIsRed = false;
  Color colorVar = Colors.black;
  int valueFromSP = 0;

  // Color nextColor = Colors.black;

  void test555() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt('testTheColor25', widget.colorOfTasksText);
    setState(() {});
  }

  void test666() async {
    // CreateTask.colorList[CreateTask.counterOfColors] =
    //     Color(widget.colorOfTasksText);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // this code here works if one task is made & the checkbox is checked.
    // if (isRed == true &&
    //     widget.colorOfTasksText == Colors.black.value &&
    //     CreateTask.countOfTasks > 1) {
    //   print(CreateTask.countOfTasks);
    //   // widget.colorOfTasksText = Colors.red.value;
    // } else
    // if (isRed == true && widget.colorOfTasksText == Colors.black.value) {
    // if (true) {
    // widget.colorOfTasksText =
    //     prefs.getInt('testTheColor25') ?? Colors.black.value;
    // }
    // }
    // isRed = false;
    // saveSome();
    // test555();
    // widget.colorOfTasksText =
    //     prefs.getInt('testTheColor69') ?? Colors.black.value;
    setState(() {});
  }

  // void getInt() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   count = prefs.getInt("d3") ?? 0;
  // }

  // void saveSome() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool("key189", isRed);
  // }
  //
  // void getSome() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   isRed = prefs.getBool("key189") ?? false;
  // }

  // Changes the color of the completed task's text to red.
  void convertTextToRed() {
    if (checkboxChecked == true) {
      setState(() {
        // saveColor();
        // widget.colorOfTasksText = Colors.red;
        // saveAndUpdateTextColorToRed();
      });
      // getColorForTextWidget();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getInt();
    // widget.colorOfTasksText = Colors.red.value;
    // code here
    // test666();
    // print(CreateTask.colorList.length);
    // print(isRed);
    // print(widget.colorOfTasksText);
    // test666();
    // convertBackPlusGet();
    // print(colorVar);
    // test666();
    // getColor();
    // print(widget.colorOfTasksText);
    // saveAndUpdateTextColorToRed();
    // getColorForTextWidget();
    // getTextDecorationForText();
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
          // widget.colorOfTasksText = Colors.red.value;
          // setState(() {});
          // isRed = true;
          // code here
          // test555();
          // widget.decorOfText = TextDecoration.lineThrough;
          // textDecor = TextDecoration.lineThrough;
          // widget.colorOfTasksText = Colors.red;
          // colorVar = Colors.red;
          // convertToIntPlusSave();
          // String bbb = text.toString();
          // print(bbb);

          /// This checks if the checkbox is ticked, so then calls the method that puts a line trough the text
          // convertTextToRed();
          // test555();
          // widget.intRepresentationOfColorVar = Colors.red.value;
          // test555();
          // test555();
          // getColorForTextWidget();
          // saveTextDecoration();
        });
      },
      title: Text(
        /// Using the object of the TaskWidget, we access the variable and set the Task Name, based on the passed String
        widget.textOfTheTaskName,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: widget.colorOfTasksText,
          decoration: widget.decorOfText,
        ),
      ),
    );
  }
}
