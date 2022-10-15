// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$RestClientService extends RestClientService {
  _$RestClientService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = RestClientService;

  @override
  Future<Response<dynamic>> loginUser(String jsonBody) {
    final $url = 'BASE_URL/tokens';
    final $headers = {
      'Content-type': 'application/json',
    };

    final $body = jsonBody;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> logoutUser(String jsonBody, String token) {
    final $url = 'BASE_URL/tokens';
    final $headers = {
      'Authorization': token,
      'Content-type': 'application/json',
    };

    final $body = jsonBody;
    final $request =
        Request('DELETE', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> changePassword(String jsonBody) {
    final $url = 'BASE_URL/create';
    final $headers = {
      'Content-type': 'application/json',
    };

    final $body = jsonBody;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
