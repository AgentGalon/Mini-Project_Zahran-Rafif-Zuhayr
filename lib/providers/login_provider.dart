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

  // Mendapatkan data pengguna saat ini.
  Map<String, dynamic> getUserData() {
    return {
      'username': _username,
      'email': _email,
      'phone': _phone,
      'photo': _photo,
      'password': _password,
    };
  }

  // Metode login user berdasarkan email dan kata sandi.
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

          // Simpan data pengguna
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

  // Untuk mengirim perubahan data pengguna ke server.
  Future<void> updateUserData(Map<String, dynamic> updatedData) async {
    final response = await http.get(
      Uri.parse('https://653a61d92e42fd0d54d3c874.mockapi.io/user'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      // Cari pengguna dengan alamat email yang sesuai
      final user = responseData.firstWhere(
        (userData) => userData['email'] == _email,
        orElse: () => null,
      );

      // Memperbarui data pengguna dari edit profile.
      if (user != null) {
        user['username'] = updatedData['username'];
        user['email'] = updatedData['email'];
        user['phone'] = updatedData['phone'];
        user['password'] = updatedData['password'];

        // Mengirim perubahan data pengguna ke api.
        final putResponse = await http.put(
          Uri.parse(
              'https://653a61d92e42fd0d54d3c874.mockapi.io/user/${user['id']}'),
          body: json.encode(user),
          headers: {'Content-Type': 'application/json'},
        );

        if (putResponse.statusCode == 200) {
          _username = user['username'];
          _email = user['email'];
          _phone = user['phone'];
          _password = user['password'];
        }
      }
    }

    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _username = null;
    _email = null;
    _phone = null;
    _photo = null;
    notifyListeners();
  }
}
