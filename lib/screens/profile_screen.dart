import 'package:flutter/material.dart';

import 'package:car_wash_app/widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        // backgroundColor: Colors.transparent,
        // foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
