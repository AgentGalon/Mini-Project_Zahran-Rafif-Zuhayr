import 'package:flutter/foundation.dart';

import 'package:car_wash_app/models/payment.dart';

class HistoryProvider extends ChangeNotifier {
  final List<Payment> _payments = [];

  List<Payment> get payments => _payments;

  void addPayment(Payment payment) {
    _payments.add(payment);
    notifyListeners();
  }
}
