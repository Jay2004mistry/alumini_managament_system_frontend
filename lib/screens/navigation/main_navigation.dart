import 'package:flutter/material.dart';

import '../dashboard/alumni_home_screen.dart';
import '../dashboard/faculty_home_screen.dart';
import '../community/community_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/alumni_profile_screen.dart';
import '../profile/faculty_profile_screen.dart';

class MainNavigation extends StatefulWidget {
  final String userRole;

  const MainNavigation({
    super.key,
    required this.userRole,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    if (widget.userRole == "FACULTY") {
      pages = const [
        FacultyDashboard(),
        CommunityScreen(),
        ChatScreen(),
        FacultyProfileScreen(),
      ];
    } else {
      // Default → Alumni
      pages = const [
        HomeScreen(),
        CommunityScreen(),
        ChatScreen(),
        AlumniProfileScreen(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(Icons.home_outlined, 0),
              buildNavItem(Icons.groups_outlined, 1),
              const SizedBox(width: 40),
              buildNavItem(Icons.chat_bubble_outline, 2),
              buildNavItem(Icons.person_outline, 3),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0D1B2A),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildNavItem(IconData icon, int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
      icon: Icon(
        icon,
        color: selectedIndex == index
            ? const Color(0xFF0D1B2A)
            : Colors.grey,
      ),
    );
  }
}