import 'package:flutter/foundation.dart';

enum Category {
  all,
  sport,
  sedan,
  suv,
  classic,
}

class HomeScreenProvider extends ChangeNotifier {
  // Index halaman beranda yang sedang aktif
  int _currentIndex = 0;

  // Kategori layanan yang dipilih di awalan
  Category _selectedCategory = Category.all;

  // Menyimpan layanan yang ditandai sebagai favorit
  final List<Map<String, dynamic>> _favoriteServices = [];

  // Getter untuk mengakses indeks tab saat ini
  int get currentIndex => _currentIndex;

  // Getter untuk mengakses kategori layanan yang dipilih
  Category get selectedCategory => _selectedCategory;

  // Getter untuk mengakses daftar layanan yang ditandai sebagai favorit
  List<Map<String, dynamic>> get favoriteServices => _favoriteServices;

  // Untuk mengatur indeks tab ketika pengguna mengganti halaman
  void setTabIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // Method ini untuk mengatur kategori layanan yang dipilih
  void setSelectedCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Method ini untuk menambahkan layanan package ke daftar favorit
  void addToFavorites(Map<String, dynamic> service) {
    if (!_favoriteServices.contains(service)) {
      _favoriteServices.add(service);
      notifyListeners();
    }
  }

  // Method ini untuk menghapus layanan package dari daftar favorit
  void removeFromFavorites(Map<String, dynamic> service) {
    _favoriteServices.remove(service);
    notifyListeners();
  }
}
