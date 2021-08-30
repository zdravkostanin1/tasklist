import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'CreateTaskScreen.dart';
import 'Settings.dart';

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
            CreateTask.clickedOnCreateTask

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
                : Container(),
          ],
        ),
      ),
    );
  }
}

/// This is the CheckboxListTile widget template that we'll be using.
// ignore: must_be_immutable
class TaskWidget extends StatefulWidget {
  static Color textColor = Color(0xFF000000);

  /// Created an object so i could access the 'textOfTheTaskName' after initialization
  static TaskWidget taskWidgetObject = TaskWidget(
      '',
      '',
      CreateTask.textDecorList[CreateTask.counterOfTextDecorations],
      Colors.black);

  /// Variable to store every task's name individually
  final String textOfTheTaskName;

  /// Variable to store every task's description individually
  final String textOfTheTasksDescription;

  /// A variable, used in the constructor, so the user could pass a value when calling the widget.
  TextDecoration decorOfText;

  /// Color variable, to use in the constructor, for the user to pass a value when calling the widget.
  Color colorOfTasksText;

  /// Constructor, so every time a new widget of CheckboxListTile is called, we pass a new task name
  /// also we pass a new description of the task.
  /// initializing the decoration of text as well.
  /// also the color.
  TaskWidget(this.textOfTheTaskName, this.textOfTheTasksDescription,
      this.decorOfText, this.colorOfTasksText);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool checkboxChecked = false;

  /// A method that checks if task is checked, then changes the TextStyle decoration
  /// to a lineThrough. + Changes the color of the completed task's text to red.
  void checkTextDecorationAndColor() {
    if (checkboxChecked == true) {
      setState(() {
        /// Change the value of the specific item in list
        CreateTask.textDecorList[CreateTask.counterOfTextDecorations] =
            TextDecoration.lineThrough;

        /// Getting the current index of the list's value, and changing the color of the task from black to red
        CreateTask.colorList[CreateTask.counterOfColors] = Colors.red;

        /// Then assign the changed value to the variable used for the decoration.
        widget.decorOfText =
            CreateTask.textDecorList[CreateTask.counterOfTextDecorations];

        /// Assigning the value of the list at the counter index to the variable that is used
        /// to represent the color of the widgets. Updating the color.
        widget.colorOfTasksText =
            CreateTask.colorList[CreateTask.counterOfColors];
      });
    }
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
          checkboxChecked = value!;

          /// This checks if the checkbox is ticked, so then calls the method that puts a line trough the text
          checkTextDecorationAndColor();
        });
      },
      title: Text(
        /// Using the object of the TaskWidget, we access the variable and set the Task Name, based on the passed String
        widget.textOfTheTaskName,
        style: TextStyle(
          fontSize: 18.0,
          color: widget.colorOfTasksText,
          decoration: widget.decorOfText,
        ),
      ),
    );
  }
}
