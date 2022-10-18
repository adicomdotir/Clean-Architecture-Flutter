import 'dart:convert';

import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/network/rest_client_service.dart';

abstract class HomeRemoteDataSource {
  Future<bool> logoutUser(String token);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final RestClientService restClientService;

  HomeRemoteDataSourceImpl({required this.restClientService});

  @override
  Future<bool> logoutUser(String token) async {
    final response =
        await restClientService.logoutUser(jsonEncode({"token": token}), token);
    if (response.statusCode == 204) {
      return true;
    }
    throw ServerException();
  }
}
