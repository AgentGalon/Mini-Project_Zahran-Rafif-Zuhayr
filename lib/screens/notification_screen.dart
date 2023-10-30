import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:car_wash_app/providers/notification_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Notification"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Hapus notifikasi dari NotificationProvider
              notificationProvider.clearNotifications();

              // Hapus notifikasi dari shared_preferences
              notificationProvider.clearSavedNotifications();
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          final notifications = provider.notifications;

          if (notifications.isEmpty) {
            return const Center(
              child: Text("No notifications"),
            );
          }

          return ListView.builder(
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
          );
        },
      ),
    );
  }
}
