import 'package:flutter/foundation.dart';

class NotificationProvider extends ChangeNotifier {
  List<String> notifications = [];

  void addNotification(String notification) {
    notifications.add(notification);
    notifyListeners();
  }
}
