import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  List<String> notifications = [];

  NotificationProvider() {
    // Mengambil notifikasi dalam Shared Preferences saat aplikasi dimulai
    loadNotifications();
  }

  Future<void> addNotification(String notification) async {
    notifications.add(notification);
    notifyListeners();

    // Menyimpan notifikasi yang baru ke Shared Preferences
    await saveNotifications();
  }

  Future<void> loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedNotifications =
        prefs.getStringList('notifications') ?? [];
    notifications.addAll(savedNotifications);
    notifyListeners();
  }

  Future<void> saveNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notifications', notifications);
  }

  void clearNotifications() {
    notifications.clear();
    notifyListeners();
  }

  Future<void> clearSavedNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
  }
}
