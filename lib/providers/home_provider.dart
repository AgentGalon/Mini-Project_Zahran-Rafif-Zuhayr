import 'package:flutter/foundation.dart';

enum Category {
  all,
  sport,
  sedan,
  suv,
  classic,
}

class HomeScreenProvider extends ChangeNotifier {
  int _currentIndex = 0;
  Category _selectedCategory = Category.all;
  final List<Map<String, dynamic>> _favoriteServices = [];

  int get currentIndex => _currentIndex;
  Category get selectedCategory => _selectedCategory;
  List<Map<String, dynamic>> get favoriteServices => _favoriteServices;

  void setTabIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setSelectedCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void addToFavorites(Map<String, dynamic> service) {
    if (!_favoriteServices.contains(service)) {
      _favoriteServices.add(service);
      notifyListeners();
    }
  }

  void removeFromFavorites(Map<String, dynamic> service) {
    _favoriteServices.remove(service);
    notifyListeners();
  }
}
