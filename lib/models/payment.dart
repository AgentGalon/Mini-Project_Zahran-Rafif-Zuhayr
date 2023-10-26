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
}
