import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_woocomerce/model/login_model.dart';
import 'dart:convert';

class SharedService {
  static Future<bool> isLoggedin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_details") != null ? true : false;
  }

  static Future<LoginResponse> loginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_details") != null
        ? LoginResponse.fromJson(jsonDecode(prefs.getString("login_details")))
        : null;
  }

  static Future<void> setLoginDetails(LoginResponse responseModel) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("login_details",
        responseModel != null ? jsonEncode(responseModel.toJson()) : null);
  }

  static Future<void> logout(BuildContext context) async {
    await setLoginDetails(null);
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
