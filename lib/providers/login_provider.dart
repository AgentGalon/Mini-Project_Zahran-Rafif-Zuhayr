import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _rememberUser = false;
  bool get rememberUser => _rememberUser;

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final token = responseData['token'];

      if (token != null && token.isNotEmpty) {
        _isLoggedIn = true;
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
}
