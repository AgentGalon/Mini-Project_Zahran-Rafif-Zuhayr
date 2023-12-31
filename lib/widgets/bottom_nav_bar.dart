import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTabTapped;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade700,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: GNav(
          tabBorderRadius: 12,
          backgroundColor: Colors.red.shade700,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.white10,
          gap: 6,
          padding: const EdgeInsets.all(8),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.favorite,
              text: "Favorite",
            ),
            GButton(
              icon: Icons.chat,
              text: "ChatBot",
            ),
            GButton(
              icon: Icons.person,
              text: "Profile",
            ),
          ],
          selectedIndex: currentIndex,
          onTabChange: (index) {
            onTabTapped(index);
          },
        ),
      ),
    );
  }
}
