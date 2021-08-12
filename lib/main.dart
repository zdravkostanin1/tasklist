import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'CreateTaskScreen.dart';
import 'Settings.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int bottomNavIndex = 0;
  bool changed = false;
  String taskName = CreateTask.taskName;

  /// Variable for the Task Name color
  Color colorOfTaskName = Color(0xFF000000);

  /// Setting the default TextDecoration for the TaskName to be none, when the
  /// checkbox isn't checked
  TextDecoration checkTextDecoration = TextDecoration.none;

  /// This method checks if the changed value, is true, e.g checked
  void checkForTextStyle() {
    if (changed == true) {
      /// If the checkbox is checked, then put a line through the text widget.
      checkTextDecoration = TextDecoration.lineThrough;

      /// Setting the variable's color from black to red, after the user checks the box
      colorOfTaskName = Color(0xFFD22B2B);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /// A expandable calendar implemented as a appBar
        appBar: CalendarAppBar(
          onDateChanged: (value) {
            print(value);
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
            /// We retrieve the value of clickedOnCreateTask from
            /// CreateTaskScreen class, and with a ternary operator check if it's true so then
            /// we can add the task, in a CheckBoxListTile with the name of the task
            CreateTask.clickedOnCreateTask
                ? CheckboxListTile(
                    value: changed,

                    /// This changes where the checkbox starts - right now before the Text
                    controlAffinity: ListTileControlAffinity.leading,

                    /// Added the description of the task, below the Task's name in the CheckboxListTile widget.
                    subtitle: Text(
                      CreateTask.descriptionOfTask,
                    ),
                    activeColor: Color(0xFF4562FE),
                    onChanged: (value) {
                      setState(() {
                        changed = value!;

                        /// This checks if the checkbox is ticked, so then calls the method that puts a line trough the text
                        checkForTextStyle();
                      });
                    },
                    title: Text(
                      /// setting the value of the task's name
                      taskName,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: colorOfTaskName,
                        decoration: checkTextDecoration,
                      ),
                    ),
                  )

                /// If value equals false just put an empty container
                : Container(),
          ],
        ),
      ),
    );
  }
}
