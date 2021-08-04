import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        // This is the 'Add a task floating button'
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF4562FE),
          child: Icon(
            Icons.add,
          ),
          // Functionality for the 'Add Task' button
          onPressed: () {},
        ),
        // Putting the floating button in the center
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // BottomNavigationBar Customization
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [Icons.home_filled, Icons.settings],
          activeIndex: bottomNavIndex,
          gapLocation: GapLocation.center,
          inactiveColor: Colors.grey,
          onTap: (int index) {
            setState(() {
              bottomNavIndex = index;
            });
          },
        ),
      ),
    );
  }
}
