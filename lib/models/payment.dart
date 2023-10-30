class Payment {
  final String selectedPackage;
  final String selectedCarType;
  final double totalPrice;
  final String paymentMethod;

  Payment({
    required this.selectedPackage,
    required this.selectedCarType,
    required this.totalPrice,
    required this.paymentMethod,
  });

  // Tambahkan metode untuk mengonversi dari JSON ke objek Payment
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      selectedPackage: json['selectedPackage'],
      selectedCarType: json['selectedCarType'],
      totalPrice: json['totalPrice'],
      paymentMethod: json['paymentMethod'],
    );
  }

  // Tambahkan metode untuk mengonversi dari objek Payment ke JSON
  Map<String, dynamic> toJson() {
    return {
      'selectedPackage': selectedPackage,
      'selectedCarType': selectedCarType,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
    };
  }
}
