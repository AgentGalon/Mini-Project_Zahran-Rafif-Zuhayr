import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/screens/history_screen.dart';
import 'package:car_wash_app/screens/favorite_screen.dart';
import 'package:car_wash_app/providers/login_provider.dart';
import 'package:car_wash_app/screens/notification_screen.dart';
import 'package:car_wash_app/screens/edit_profile_screen.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).getUserData();
    final photoUrl = user['photo'];

    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
          ),
          const Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
            ),
          )
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 3,
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(icon, size: 22),
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: Icons.person_outline,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfileScreen(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "History",
            icon: Icons.history_outlined,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: Icons.notifications_outlined,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Favorite",
            icon: Icons.favorite_outline,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteScreen(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: Icons.logout_outlined,
            press: () {
              // Akses AuthProvider dan panggil fungsi logout
              Provider.of<AuthProvider>(context, listen: false).logout();

              // Setelah logout, Anda dapat membuka halaman login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
