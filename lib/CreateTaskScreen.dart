import 'package:flutter/material.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({Key? key}) : super(key: key);

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
                height: 160.0,
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
