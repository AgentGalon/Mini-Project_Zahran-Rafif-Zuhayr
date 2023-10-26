import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:car_wash_app/providers/notification_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications =
        Provider.of<NotificationProvider>(context, listen: false).notifications;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Notification"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text(
              "Notification",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(notification),
          );
        },
      ),
    );
  }
}
