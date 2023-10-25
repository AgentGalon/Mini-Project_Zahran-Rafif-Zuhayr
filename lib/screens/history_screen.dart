import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:car_wash_app/models/payment.dart';
import 'package:car_wash_app/providers/history_provider.dart';
import 'package:car_wash_app/screens/payment_confirm_screen.dart';

class HistoryScreen extends StatelessWidget {
  final List<Payment> payments;

  const HistoryScreen({
    Key? key,
    required this.payments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final payments = Provider.of<HistoryProvider>(context).payments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment History"),
      ),
      body: ListView.builder(
        itemCount: payments.length,
        itemBuilder: (context, index) {
          final payment = payments[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PaymentConfirmationScreen(
                    totalPrice: payment.totalPrice,
                    paymentMethod: payment.selectedPackage,
                    selectedPackage: payment.selectedPackage,
                    selectedCarType: payment.selectedCarType,
                  ),
                ),
              );
            },
            child: ListTile(
              title: Text(
                "Package: ${payment.selectedPackage}",
              ),
              subtitle: Text(
                "Car Type: ${payment.selectedCarType}",
              ),
              trailing: Text(
                "Total Prize: \$${payment.totalPrice.toStringAsFixed(2)}",
              ),
            ),
          );
        },
      ),
    );
  }
}
