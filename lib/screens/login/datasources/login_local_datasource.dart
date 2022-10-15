import 'dart:convert';

import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/screens/login/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  Future<LoginModel> getLastToken();
  Future<void> cacheToken(LoginModel loginModel);
}

class LoginLocalDataSourceImpl extends LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<LoginModel> getLastToken() async {
    String? jsonStr = sharedPreferences.getString(cachedTokenKey);
    if (jsonStr == null) {
      throw CacheException();
    }
    return Future.value(LoginModel.fromJson(jsonDecode(jsonStr)));
  }

  @override
  Future<void> cacheToken(LoginModel loginModel) {
    return sharedPreferences.setString(
        cachedTokenKey, jsonEncode(loginModel.toJson()));
  }
}
