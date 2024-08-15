import 'package:flutter/material.dart';

import 'package:frontend/menu/Home_page.dart';
import 'package:frontend/menu/Friends_page.dart';
import 'package:frontend/menu/Profile_page.dart';

class Menu_Main extends StatefulWidget {
  const Menu_Main({Key? key}) : super(key: key);
  @override
  State<Menu_Main> createState() => _Menu_Main_State();
}

class _Menu_Main_State extends State<Menu_Main> {
  int _currentIndex = 0;
  final tabs = [Home_Page(), Friends_Page(), Profile_Page()];

  @override
  Widget build(Object context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        iconSize: 35,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 255, 255, 255)),
            activeIcon:
                Icon(Icons.home, color: Color.fromARGB(255, 170, 97, 97)),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 23, 107, 135),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.family_restroom,
                color: Color.fromARGB(255, 255, 255, 255)),
            activeIcon: Icon(Icons.family_restroom,
                color: Color.fromARGB(255, 170, 97, 97)),
            label: 'Friends',
            backgroundColor: Color.fromARGB(255, 23, 107, 135),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 255, 255, 255)),
            activeIcon:
                Icon(Icons.person, color: Color.fromARGB(255, 170, 97, 97)),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 23, 107, 135),
          ),
        ],
        onTap: (index) {
          // วาดหน้าใหม่
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
