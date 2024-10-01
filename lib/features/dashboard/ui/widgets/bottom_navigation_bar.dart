import 'package:flutter/material.dart';


class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BottomNavigationBar(
          currentIndex: _currentIndex, // Current selected index
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Update the selected index
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.report_problem),
              label: 'Complain',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notice',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.shifting, // Ensures labels are always shown
          // selectedItemColor: Colors.blue, // Color for the selected item
          // unselectedItemColor: Colors.grey, // Color for unselected items
        );
      
      },
    );
  }
}