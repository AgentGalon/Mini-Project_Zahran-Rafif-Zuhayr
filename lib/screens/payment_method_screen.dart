import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:car_wash_app/models/payment.dart';
import 'package:car_wash_app/providers/history_provider.dart';
import 'package:car_wash_app/screens/payment_confirm_screen.dart';
import 'package:car_wash_app/providers/payment_method_provider.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double totalPrice;
  final String selectedPackage;
  final String selectedCarType;

  const PaymentMethodScreen({
    Key? key,
    required this.totalPrice,
    required this.selectedPackage,
    required this.selectedCarType,
  }) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Method Payment"),
        leading: const CupertinoNavigationBarBackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const PaymentMethodOption(
                  title: "PayPal",
                  image: "assets/images/paypal.png",
                  type: 1,
                  fee: 3.0,
                ),
                const SizedBox(height: 15),
                const PaymentMethodOption(
                  title: "Google Pay",
                  image: "assets/images/google pay.png",
                  type: 2,
                  fee: 5.0,
                ),
                const SizedBox(height: 15),
                const PaymentMethodOption(
                  title: "Apple Pay",
                  image: "assets/images/apple pay.png",
                  type: 3,
                  fee: 6.0,
                ),
                const SizedBox(height: 15),
                const PaymentMethodOption(
                  title: "Amazon Pay",
                  image: "assets/images/amazon pay.png",
                  type: 4,
                  fee: 4.0,
                ),
                const SizedBox(height: 100),
                PaymentSummary(totalPrice: widget.totalPrice),
                const SizedBox(height: 70),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ElevatedButton(
                    onPressed: () {
                      String selectedPaymentMethod = "PayPal";
                      if (Provider.of<PaymentMethodProvider>(context,
                                  listen: false)
                              .type ==
                          2) {
                        selectedPaymentMethod = "Google Pay";
                      } else if (Provider.of<PaymentMethodProvider>(context,
                                  listen: false)
                              .type ==
                          3) {
                        selectedPaymentMethod = "Apple Pay";
                      } else if (Provider.of<PaymentMethodProvider>(context,
                                  listen: false)
                              .type ==
                          4) {
                        selectedPaymentMethod = "Amazon Pay";
                      }

                      // Buat objek Payment
                      Payment payment = Payment(
                        selectedPackage: widget.selectedPackage,
                        selectedCarType: widget.selectedCarType,
                        totalPrice: widget.totalPrice,
                        paymentMethod: selectedPaymentMethod,
                      );

                      // Tambahkan pembayaran ke daftar
                      Provider.of<HistoryProvider>(context, listen: false)
                          .addPayment(payment);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => PaymentConfirmationScreen(
                            totalPrice: widget.totalPrice,
                            paymentMethod: selectedPaymentMethod,
                            selectedPackage: widget.selectedPackage,
                            selectedCarType: widget.selectedCarType,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 48)),
                    ),
                    child: Text(
                      "Buy Now".toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentMethodOption extends StatelessWidget {
  final String title;
  final String image;
  final int type;
  final double fee;

  const PaymentMethodOption({
    super.key,
    required this.title,
    required this.image,
    required this.type,
    required this.fee,
  });

  @override
  Widget build(BuildContext context) {
    final paymentMethodProvider = Provider.of<PaymentMethodProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      decoration: BoxDecoration(
        border: paymentMethodProvider.type == type
            ? Border.all(width: 1, color: Colors.red)
            : Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        color: Colors.transparent,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio(
                    value: type,
                    groupValue: paymentMethodProvider.type,
                    onChanged: (value) {
                      paymentMethodProvider.setPaymentType(type, fee);
                    },
                    activeColor: Colors.red,
                  ),
                  Text(
                    title,
                    style: paymentMethodProvider.type == type
                        ? const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )
                        : const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                  ),
                ],
              ),
              Image.asset(
                image,
                width: 80,
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentSummary extends StatelessWidget {
  final double totalPrice;

  const PaymentSummary({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final paymentMethodProvider = Provider.of<PaymentMethodProvider>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Sub-Total",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            Text(
              "\$${totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Fee",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            Text(
              "\$${paymentMethodProvider.fee.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Divider(
          height: 15,
          color: Colors.black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Prize",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "\$${(totalPrice + paymentMethodProvider.fee).toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
