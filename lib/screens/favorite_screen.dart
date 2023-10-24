import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Text("Your Favorite Content Goes Here"),
      ),
    );
  }
}
