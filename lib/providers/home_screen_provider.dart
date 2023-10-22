import 'package:flutter/foundation.dart';

enum Category {
  all,
  sport,
  sedan,
  suv,
  classic,
}

class HomeScreenModel extends ChangeNotifier {
  int _currentIndex = 0;
  Category _selectedCategory = Category.all;

  int get currentIndex => _currentIndex;
  Category get selectedCategory => _selectedCategory;

  void setTabIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setSelectedCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
