import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String? _username;
  String? get username => _username;

  String? _email;
  String? get email => _email;

  int? _phone;
  int? get phone => _phone;

  String? _photo;
  String? get photo => _photo;

  String? _password;
  String? get password => _password;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _rememberUser = false;
  bool get rememberUser => _rememberUser;

  Map<String, dynamic> getUserData() {
    return {
      'username': _username,
      'email': _email,
      'phone': _phone,
      'photo': _photo,
      'password': _password,
    };
  }

  Future<void> login(String email, String password) async {
    final response = await http.get(
      Uri.parse('https://653a61d92e42fd0d54d3c874.mockapi.io/user'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      // Cari pengguna dengan email yang sesuai
      final user = responseData.firstWhere(
        (userData) => userData['email'] == email,
        orElse: () => null,
      );

      if (user != null) {
        final storedPassword = user['password'];

        if (password == storedPassword) {
          _isLoggedIn = true;

          // Simpan semua data pengguna
          _username = user['username'];
          _email = user['email'];
          _phone = user['phone'];
          _photo = user['photo'];
          _password = user['password'];
        } else {
          _isLoggedIn = false;
        }
      } else {
        _isLoggedIn = false;
      }
    } else {
      _isLoggedIn = false;
    }

    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleRememberUser() {
    _rememberUser = !_rememberUser;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _username = null;
    _email = null;
    _phone = null;
    // _photo = null;
    notifyListeners();
  }
}
