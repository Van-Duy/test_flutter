import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';

class AuthProvider extends ChangeNotifier {
  String _token = '';
  int _expires = 0;

  bool get isAuth {
    return _token.isNotEmpty;
  }

  Future<void> _authentication(
      String email, String password, String type) async {
    const url = 'http://apiforlearning.zendvn.com/api/auth/login';

    try {
      final respone = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {"email": email, "password": password},
        ),
      );

      final responeData = jsonDecode(respone.body);
      _token = responeData['access_token'];
      _expires = responeData['expires_in'];
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({"token": _token});
      await prefs.setString('userData', userData);
    } catch (e) {
      print(e);
    }
  }

  void login(String email, String password) {
    _authentication(email, password, 'login');
  }

  Future<void> logout() async {
    _token = '';
    _expires = 0;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  static void registerPluginsForIsolates() {
    if (Platform.isIOS) {
      SharedPreferencesIOS.registerWith();
    }
  }

  Future<bool> autoLogin() async {
    DartPluginRegistrant.ensureInitialized();
    registerPluginsForIsolates();
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    // final data = jsonDecode(prefs.getString('userData') ?? '');
    return true;
  }
}
