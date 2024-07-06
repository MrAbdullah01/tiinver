import 'package:flutter/material.dart';
import 'package:tiinver_project/constants/colors.dart';

import '../chat_home_screen/chat_home_screen.dart';
import '../dash_board_screen/dash_board_screen.dart';
import '../notification_screen/notification_screen.dart';
import '../profile_screen/profile_screen.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {

  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          DashBoardScreen(),
          ChatHomeScreen(),
          NotificationScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: bgColor,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: bgColor,
          backgroundColor: themeColor,
          showSelectedLabels: true,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home,),
                label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_rounded,),
                label: "Chat"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications,),
                label: "Notifications"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,),
                label: "My Profile"
            ),
          ]),
    );
  }
}
