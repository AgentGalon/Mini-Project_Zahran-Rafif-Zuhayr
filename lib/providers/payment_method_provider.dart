import 'package:flutter/foundation.dart';

class PaymentMethodProvider with ChangeNotifier {
  int _type = 0;
  double _fee = 0.0;

  int get type => _type;
  double get fee => _fee;

  // Untuk mengatur jenis pembayaran
  void setPaymentType(int newType, double newFee) {
    _type = newType;
    _fee = newFee;
    notifyListeners();
  }
}
