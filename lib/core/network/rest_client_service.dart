import "dart:async";

import 'package:chopper/chopper.dart';
import 'package:clean_architecture_flutter/core/utils/constants.dart';

part "rest_client_service.chopper.dart";

@ChopperApi(baseUrl: apiBaseUrl)
abstract class RestClientService extends ChopperService {
  static RestClientService create([ChopperClient? client]) =>
      _$RestClientService(client);

  @Post(path: loginUserConst, headers: {'Content-type': 'application/json'})
  Future<Response> loginUser(@Body() String jsonBody);

  @Delete(path: loginUserConst, headers: {'Content-type': 'application/json'})
  Future<Response> logoutUser(
      @Body() String jsonBody, @Header("Authorization") String token);

  @Put(path: createUserConst, headers: {'Content-type': 'application/json'})
  Future<Response> changePassword(@Body() String jsonBody);
}
