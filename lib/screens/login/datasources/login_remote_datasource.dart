import 'dart:convert';

import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/network/rest_client_service.dart';
import 'package:clean_architecture_flutter/screens/login/data/models/login_model.dart';
import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart';

abstract class LoginRemoteDataSource {
  Future<Login> loginUser(String email, String password);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final RestClientService restClientService;

  LoginRemoteDataSourceImpl({required this.restClientService});

  @override
  Future<Login> loginUser(String email, String password) async {
    final response = await restClientService.loginUser(jsonEncode({
      'email': email,
      'password': password,
    }));
    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
