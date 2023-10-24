import 'package:flutter/foundation.dart';

class DetailScreenProvider with ChangeNotifier {
  // double _totalPrice = 0.0;
  // List<bool> _additionalServices = List.generate(7, (index) => false);

  // double get totalPrice => _totalPrice;
  // List<bool> get additionalServices => _additionalServices;

  // void toggleAdditionalService(int index, double price) {
  //   _additionalServices[index] = !_additionalServices[index];
  //   if (_additionalServices[index]) {
  //     _totalPrice += price;
  //   } else {
  //     _totalPrice -= price;
  //   }
  //   notifyListeners();
  // }

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
