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
    final payments =
        Provider.of<HistoryProvider>(context, listen: false).payments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
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
                    paymentMethod: payment.paymentMethod,
                    selectedPackage: payment.selectedPackage,
                    selectedCarType: payment.selectedCarType,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Package: ${payment.selectedPackage}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Car Type: ${payment.selectedCarType}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Total Prize: \$${payment.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
