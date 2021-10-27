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
  bool changed = false;
  String taskName = CreateTask.taskName;
  static List<String> asd = [];

  clearSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  getBoolValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CreateTask.idk = prefs.getBool('savedBool85') ?? false;
    // String jsonTasks = jsonDecode(prefs.getString('asd4')!);
    // print(jsonTasks);
    print(CreateTask.idk);
    // print(CreateTask.taskList);
    setState(() {});
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('savedDataOfTask85') ?? asd;
    CreateTask.taskList =
        (list.map((e) => TaskWidget.fromMap(jsonDecode(e))).toList());
    // print(prefs.getStringList('savedDataOfTask65'));
    setState(() {});
  }

  // void loadColorData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Color color = Color(prefs.getInt('bbbb3') ?? 0xFF000000);
  //   print(color);
  //   print(prefs.getInt('bbbb3'));
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // clearSP();
    getBoolValue();
    loadData();
    // loadColorData();
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
            CreateTask.idk
                // CreateTask.clickedOnCreateTask
                //     idk
                // test

                /// if clicked, we put an expanded widget, to fit the most possible tasks in the screen.
                ? Expanded(
                    /// We use a listView.builder to build widgets from the list that we want.
                    child: ListView.builder(
                      /// The count of the widgets to build
                      itemCount: CreateTask.taskList.length,
                      itemBuilder: (context, index) {
                        /// Here we return the CheckboxListTile's saved in the taskList with the index
                        // testingIntegers = index;
                        // saveIndex();
                        // return CreateTask.forUse[index];
                        // saveData();
                        return CreateTask.taskList[index];
                        //jsonDecode(taskWidgetsList[index]);
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
  /// Created an object so i could access the 'textOfTheTaskName' after initialization
  static TaskWidget taskWidgetObject = TaskWidget('', '');

  /// Variable to store every task's name individually
  final String textOfTheTaskName;

  /// Variable to store every task's description individually
  final String textOfTheTasksDescription;

  /// A variable, used in the constructor, so the user could pass a value when calling the widget.
  TextDecoration decorOfText = TextDecoration.none;

  /// Color variable, to use in the constructor, for the user to pass a value when calling the widget.
  Color colorOfTasksText = Color(0xFF000000);

  int aaa = 0;

  // int asd = colorOfTasksText.value;

  /// Constructor, so every time a new widget of CheckboxListTile is called, we pass a new task name
  /// also we pass a new description of the task.
  /// initializing the decoration of text as well.
  /// also the color.

  TaskWidget(this.textOfTheTaskName, this.textOfTheTasksDescription);

  TaskWidget.fromMap(Map<String, dynamic> map)
      : this.textOfTheTaskName = map['taskName'],
        this.textOfTheTasksDescription = map['taskDesc'];
  // this.aaa = map['intValue'];
  // this.decorOfText = map['decorOfText'],
  // this.colorOfTasksText = map['colorOfTask'];

  Map<String, dynamic> toMap() {
    return {
      'taskName': this.textOfTheTaskName,
      'taskDesc': this.textOfTheTasksDescription,
      // 'intValue': this.aaa,
      // 'colorOfTask': this.colorOfTasksText.value
      // 'decorOfText': this.decorOfText
    };
  }

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool checkboxChecked = false;
  bool test = false;
  List<int> myIntegerList = [];
  String niceTryVar = "true";
  Color colorObj = Colors.black;
  int anotherTest = 0;

  // Color color = Color(0xFF000000);
  // int myTestColorValue = 1;
  // Color otherColor = Colors.black;
  Color color = Color(0xFF000000);

  void loadColorData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    colorObj = Color(prefs.getInt('colorData148') ?? 0);
    color = colorObj;
    setState(() {});
  }

  void saveSecondColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('secondColorSaved', colorObj.value);
  }

  void getSecondColorValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    anotherTest = prefs.getInt('secondColorSaved') ?? 0xFF000000;
    color = Color(anotherTest);
  }

  /// A method that checks if task is checked, then changes the TextStyle decoration
  /// to a lineThrough. + Changes the color of the completed task's text to red.
  void checkTextDecorationAndColor() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String colorString = otherColor.toString();
    // String valueString = colorString.split('(0x')[1].split(')')[0];
    // int value = int.parse(valueString, radix: 16);
    // Color otherColor2 = Color(value);
    // prefs.setInt('keyB1', value);
    if (checkboxChecked == true) {
      setState(() {
        colorObj = Colors.red;
        color = colorObj;
        saveSecondColor();
        // widget.aaa = Colors.red.value;
        // color = Color(widget.aaa);

        // CreateTask.taskList.map((e) => jsonEncode(e.toMap())).toList();
        // if (CreateTask.colorList.isNotEmpty) {
        //   // widget.aaa = Colors.red.value;
        //   // CreateTask.colorList[CreateTask.counterOfColors] = Color(widget.aaa);
        // }
        // widget.aaa = Colors.red.value;
        // print(widget.aaa);
        // widget.aaa = Colors.red.value;
        // color = Color(Colors.red.value);
        // Color b = Color(widget.aaa);
        // CreateTask.colorList.add(b);
        // CreateTask.colorList[CreateTask.counterOfColors]b;
        // color = Color(widget.aaa);
        // color = Colors.red;
        // /// Change the value of the specific item in list
        // CreateTask.textDecorList[CreateTask.counterOfTextDecorations] =
        //     TextDecoration.lineThrough;
        //
        // /// Getting the current index of the list's value, and changing the color of the task from black to red
        // CreateTask.colorList[CreateTask.counterOfColors] = Colors.red;
        //
        // /// Then assign the changed value to the variable used for the decoration.
        // widget.decorOfText =
        //     CreateTask.textDecorList[CreateTask.counterOfTextDecorations];
        //
        // /// Assigning the value of the list at the counter index to the variable that is used
        // /// to represent the color of the widgets. Updating the color.
        // widget.colorOfTasksText =
        //     CreateTask.colorList[CreateTask.counterOfColors];
      });
    }
    // print(widget.aaa);
    // color = Color(widget.aaa);
  }

  // void getBoolFromSP() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   test = prefs.getBool('4eettiri16') ?? false;
  //   // setState(() {});
  // }
  //
  // void saveBoolFromSP() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('4eettiri16', checkboxChecked);
  //   // setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadColorData();
    getSecondColorValue();
    // print(widget.aaa);
    // print(Colors.black.value);
    // getBoolFromSP();
    // loadColorData();
    // met();
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
        // bool asd = value ?? false;
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setBool('testValue123', value ?? false);
        setState(() {
          checkboxChecked = value ?? false;

          /// This checks if the checkbox is ticked, so then calls the method that puts a line trough the text
          checkTextDecorationAndColor();
          // widget.aaa = Colors.red.value;
          // niceTryVar = "this was checked";
        });
        // saveBoolFromSP();
      },
      title: Text(
        /// Using the object of the TaskWidget, we access the variable and set the Task Name, based on the passed String
        widget.textOfTheTaskName,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: color,
          // Color(widget
          //     .aaa), //niceTryVar == 'this was checked' ? Colors.red : Colors.black,
          //Colors.red,
          //CreateTask.colorList[CreateTask.counterOfColors] //Colors.black,
          // decoration: widget.decorOfText,
        ),
      ),
    );
  }
}
