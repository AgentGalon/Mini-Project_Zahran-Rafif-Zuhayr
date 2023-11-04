import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:car_wash_app/screens/payment_method_screen.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final double totalPrice;
  final String paymentMethod;
  final String selectedPackage;
  final String selectedCarType;

  final List<String> randomImages = [
    "assets/images/QR-code_01.png",
    "assets/images/QR-code_02.png",
    "assets/images/QR-code_03.png",
    "assets/images/QR-code_04.png",
    "assets/images/QR-code_05.png",
    "assets/images/QR-code_06.png",
    "assets/images/QR-code_07.png",
  ];

  String getRandomImage() {
    final random = Random();
    final index = random.nextInt(randomImages.length);
    return randomImages[index];
  }

  PaymentConfirmationScreen({
    Key? key,
    required this.totalPrice,
    required this.paymentMethod,
    required this.selectedPackage,
    required this.selectedCarType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final randomImage = getRandomImage();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Payment Confirmation"),
        leading: const CupertinoNavigationBarBackButton(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Menampilkan gambar QR code
                Image.asset(
                  randomImage,
                  width: 240,
                  height: 240,
                ),
                const SizedBox(height: 40),

                // Menampilkan paket yang dipilih
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Package",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      selectedPackage,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Menampilkan jenis mobil yang dipilih
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Car Type",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      selectedCarType,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Menampilkan metode pembayaran
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Payment Method",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      paymentMethod,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Menampilkan Sub-Total, Fee dan Total Prize
                PaymentSummary(totalPrice: totalPrice),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
