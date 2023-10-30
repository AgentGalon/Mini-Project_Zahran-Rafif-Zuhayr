import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:car_wash_app/models/payment.dart';

class HistoryProvider extends ChangeNotifier {
  List<Payment> _payments = [];

  List<Payment> get payments => _payments;

  HistoryProvider() {
    // Memuat data dari Shared Preferences saat provider dibuat
    loadPayments();
  }

  Future<void> loadPayments() async {
    final prefs = await SharedPreferences.getInstance();
    final paymentsString = prefs.getString('payments');

    if (paymentsString != null) {
      final paymentsList = json.decode(paymentsString) as List<dynamic>;
      _payments =
          paymentsList.map((payment) => Payment.fromJson(payment)).toList();
    }

    notifyListeners();
  }

  Future<void> addPayment(Payment payment) async {
    _payments.add(payment);
    notifyListeners();

    // Simpan daftar pembayaran ke Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    final paymentsList = _payments.map((payment) => payment.toJson()).toList();
    prefs.setString('payments', json.encode(paymentsList));
  }

  // Metode untuk menghapus semua riwayat pembayaran
  Future<void> clearPayments() async {
    _payments.clear();
    notifyListeners();

    // Hapus riwayat pembayaran dari Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('payments');
  }
}
