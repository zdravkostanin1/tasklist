import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SafeArea(
              /// The Bottom Card widget for the 'Create New Task' text
              /// and textfield
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

                      /// Create New Task text wdiget
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

            /// Container for the Date picker, descripition, remind me button
            Container(
              /// Fixing Width & height
              width: 380.0,
              height: 260.0,
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
                        // _selectedValue = date;
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
                      style: TextStyle(
                        /// Changing the color of the text that the users input
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
