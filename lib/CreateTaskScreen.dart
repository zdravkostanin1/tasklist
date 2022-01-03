import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:tasklist_flutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateTask extends StatefulWidget {
  static bool isSwitched = false;
  static String taskName = '';
  static String descriptionOfTask = '';
  static var selectedDate = DateTime.now();
  static bool clickedOnCreateTask = false;
  static int counterOfTasksName = 0;
  static int counterOfTasksDescription = 0;
  static List<TaskWidget> taskList = [];
  static List<String> savedTasksName = [];
  static List<String> savedDescriptionsName = [];
  static TextEditingController descriptionController = TextEditingController();
  static int counterOfTextDecorations = 0;
  static List<TextDecoration> textDecorList = [];
  static List<Color> colorList = [];
  static int counterOfColors = 0;
  static bool booleanValue = false;
  static int intforTesting = 0;
  static int newCounterForColor = 0;

  // CreateTask.fromJson(Map<String, dynamic> map)
  // : colorList = map['test'];
  //
  // Map<String, dynamic> toJson() {
  //   return {'test': colorList};

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  // CreateTask task = CreateTask();

  saveBoolValue() async {
    if (CreateTask.clickedOnCreateTask != false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('savedBoolean238', CreateTask.clickedOnCreateTask);
    }
  }

  void saveTask() async {
    List<String> spList =
        CreateTask.taskList.map((e) => jsonEncode(e.toJson())).toList();
    print(spList);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedDataOfTask238', spList);
    setState(() {});
  }

  // void saveColorList() async {
  //   List<String> spList =
  //       CreateTask.colorList.map((e) => jsonEncode(e.toJson())).toList();
  // }

  // void saveAndUpdateTextColorToRed() async {
  //   CreateTask.intforTesting = Colors.red.value;
  //   widget.intRepresentationOfColorVar = textColorVariable;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('colorOfText61', textColorVariable);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /// I used a SingleChildScrollView, so i could scroll by the widgets, without getting
        /// a render error, when the keyboard shows up
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                /// The Bottom Card widget for the 'Create New Task' text
                /// and TextField
                child: Container(
                  width: 410.0,
                  height: 180.0,
                  padding: EdgeInsets.all(10),
                  child: Card(
                    /// Setting the shape of the Card Widget
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color(0xFF4562FE),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Used SizedBox to put spaces between the Text widgets
                        SizedBox(
                          height: 10.0,
                        ),

                        /// Create New Task text widget
                        Text(
                          '  Create New Task',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),

                        /// Used SizedBox to put spaces between the Text widgets
                        SizedBox(
                          height: 20.0,
                        ),

                        /// Name Text Widget
                        Text(
                          '    Name',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                          ),
                        ),

                        /// Used SizedBox to put spaces between the Text widget & TextField
                        SizedBox(
                          height: 10.0,
                        ),

                        /// Used a container, so i can change the size of the TextField widget
                        Container(
                          /// Fixing a width
                          width: 370.0,

                          /// Setting the margins
                          margin: EdgeInsets.fromLTRB(12.5, 0.0, 12.5, 0.0),
                          child: TextField(
                            /// OnChanged function of the TextField
                            onChanged: (value) {
                              /// Retrieving what is typed by the user in the TextField e.g TaskName
                              CreateTask.taskName = value;
                            },
                            style: TextStyle(
                              /// Changing the color of the text that the users input
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// Container for the Date picker, description, remind me button
              Container(
                /// Fixing Width & height
                width: 380.0,
                height: 240.0,
                padding: EdgeInsets.all(10),

                /// Colors
                color: Color(0xFF004953),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Date Text Widget + styling
                    Text(
                      ' Date',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                      ),
                    ),

                    /// Date Picker
                    SizedBox(
                      height: 10.0,
                    ),
                    DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),

                      /// Colors
                      selectionColor: Colors.black,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        /// Selected new date
                        setState(() {
                          /// Retrieving the selected date from the user & saving it
                          CreateTask.selectedDate = date;
                        });
                      },
                    ),

                    /// SizedBox for space
                    SizedBox(
                      height: 10.0,
                    ),

                    /// Description Text Widget
                    Text(
                      ' Description',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                      ),
                    ),

                    /// SizedBox for space
                    SizedBox(
                      height: 10.0,
                    ),

                    /// Container for the Description TextField
                    Container(
                      /// Fixing a width
                      width: 360.0,

                      /// Setting the margins
                      margin: EdgeInsets.fromLTRB(12, 0.0, 12, 0.0),
                      child: TextField(
                        onChanged: (value) {
                          /// Retrieving what is typed by the user in the TextField
                          CreateTask.descriptionOfTask = value;
                        },
                        style: TextStyle(
                          /// Changing the color of the text that the users input
                          color: Colors.white,
                        ),

                        /// Controller property to see, what value does the textField store
                        controller: CreateTask.descriptionController,
                      ),
                    ),
                  ],
                ),
              ),

              /// Sized Box for space
              SizedBox(
                height: 30.0,
              ),

              /// Row for the Text Widget, and Toggle Button
              Row(
                children: [
                  Text(
                    '    Remind me',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// SizedBox for space
                  SizedBox(
                    width: 240.0,
                  ),

                  /// Toggle Button
                  Switch(
                    value: CreateTask.isSwitched,
                    onChanged: (value) {
                      setState(() {
                        /// Changing if the toggle button is clicked
                        CreateTask.isSwitched = value;
                      });
                    },

                    /// Colors of the toggle button
                    activeTrackColor: Colors.orange,
                    activeColor: Colors.yellow,
                  ),
                ],
              ),

              /// SizedBox for space
              SizedBox(
                height: 40.0,
              ),

              /// Wrapped our ElevatedButton, in a container to fix the size of it.
              Container(
                width: 380.0,
                height: 40.0,

                /// Create Task Button
                child: ElevatedButton(
                  /// Adding a styling, to change the color of the button
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4562FE),
                  ),

                  /// Functionality of the Create Task Button
                  onPressed: () {
                    /// When clicked, pushing to the new screen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyApp();
                    }));

                    /// When the user clicks on the 'Create Task' button
                    /// we update the variable clickedOnCreateTask, to then use it
                    CreateTask.clickedOnCreateTask = true;

                    // CreateTask.newBoolValue = true;
                    // CreateTask.test = true;

                    /// Adding an TextDecoration that is equal to none for every new task.
                    CreateTask.textDecorList.add(TextDecoration.none);

                    /// Adding the color of the task to the list
                    CreateTask.colorList.add(Colors.black);

                    ///testing here
                    CreateTask.newCounterForColor++;

                    /// We add the task name to the 'savedTasksName' list
                    CreateTask.savedTasksName.add(CreateTask.taskName);

                    /// We add the tasks description to the 'savedDescriptionsName' list

                    /// We make a check to see if the description box is empty
                    /// e.g when the user didn't set any description of the task
                    /// we check with the TextEditingController's value
                    if (CreateTask.descriptionController.text.isEmpty) {
                      /// then we save it as a empty string as the var value
                      CreateTask.descriptionOfTask = '';

                      /// we then add to the list.
                      CreateTask.savedDescriptionsName
                          .add(CreateTask.descriptionOfTask);
                    } else {
                      /// If description not empty, just add the task desc to list..
                      CreateTask.savedDescriptionsName
                          .add(CreateTask.descriptionOfTask);
                    }

                    /// Check to see if the savedTasksName.length == 1, to still be able to use the counter
                    /// variable, without an error, because when we create the first task, we need to access the first value of the list.
                    if (CreateTask.savedTasksName.length == 1) {
                      /// code
                    } else {
                      /// After we have accessed the first variable, next time, we increment the counter variable
                      /// to access the next task name..
                      CreateTask.counterOfTasksName++;
                    }

                    /// Check to see if the savedDescriptionsName.length == 1, to still be able to use the counter
                    /// variable, without an error, because when we create the first task, we need to access the first value of the list.
                    if (CreateTask.savedDescriptionsName.length == 1) {
                      /// code
                    } else {
                      /// After we have accessed the first value, next time, we increment the counter variable
                      /// to access the next task name..
                      CreateTask.counterOfTasksDescription++;
                    }

                    /// Check to see if the textDecorList.length == 1, to still be able to use the counter
                    /// variable, without an error, because when we create the first task, we need to access the first value of the list.
                    if (CreateTask.textDecorList.length == 1) {
                      /// code
                    } else {
                      /// After we have accessed the first value, next time, we increment the counter variable
                      /// to access the next task name..
                      CreateTask.counterOfTextDecorations++;
                    }

                    /// Check to see if the colorList.length == 1, to still be able to use the counter
                    /// variable, without an error, because when we create the first task, we need to access the first value of the list.
                    if (CreateTask.colorList.length == 1) {
                      ///code
                    } else {
                      /// After we have accessed the first value, next time, we increment the counter variable
                      /// to access the next task name..
                      CreateTask.counterOfColors++;
                    }

                    /// We add a TaskWidget to the task's list, passing the
                    /// string that is based on the savedTasksName list, using the counter of the widget number as the index
                    /// We also add the description of the tasks, which is also based on the list of Descriptions.
                    CreateTask.taskList.add(
                      TaskWidget(
                        CreateTask
                            .savedTasksName[CreateTask.counterOfTasksName],
                        CreateTask.savedDescriptionsName[
                            CreateTask.counterOfTasksDescription],
                        CreateTask.colorList[CreateTask.counterOfColors].value,
                      ),
                    );
                    saveBoolValue();
                    saveTask();
                  },
                  child: Text('Create Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
