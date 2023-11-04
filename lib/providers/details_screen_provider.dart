import 'package:flutter/foundation.dart';

class DetailScreenProvider with ChangeNotifier {
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  // Untuk mengubah status favorit dari `false` ke `true` atau sebaliknya
  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
