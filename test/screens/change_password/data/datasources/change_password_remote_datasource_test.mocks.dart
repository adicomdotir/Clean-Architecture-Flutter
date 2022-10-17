// Mocks generated by Mockito 5.2.0 from annotations
// in clean_architecture_flutter/test/screens/change_password/data/datasources/change_password_remote_datasource_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:chopper/chopper.dart' as _i2;
import 'package:clean_architecture_flutter/core/network/rest_client_service.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeChopperClient_0 extends _i1.Fake implements _i2.ChopperClient {}

class _FakeType_1 extends _i1.Fake implements Type {}

class _FakeResponse_2<BodyType> extends _i1.Fake
    implements _i2.Response<BodyType> {}

/// A class which mocks [RestClientService].
///
/// See the documentation for Mockito's code generation for more information.
class MockRestClientService extends _i1.Mock implements _i3.RestClientService {
  MockRestClientService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ChopperClient get client =>
      (super.noSuchMethod(Invocation.getter(#client),
          returnValue: _FakeChopperClient_0()) as _i2.ChopperClient);
  @override
  set client(_i2.ChopperClient? _client) =>
      super.noSuchMethod(Invocation.setter(#client, _client),
          returnValueForMissingStub: null);
  @override
  Type get definitionType =>
      (super.noSuchMethod(Invocation.getter(#definitionType),
          returnValue: _FakeType_1()) as Type);
  @override
  _i4.Future<_i2.Response<dynamic>> loginUser(String? jsonBody) =>
      (super.noSuchMethod(Invocation.method(#loginUser, [jsonBody]),
              returnValue: Future<_i2.Response<dynamic>>.value(
                  _FakeResponse_2<dynamic>()))
          as _i4.Future<_i2.Response<dynamic>>);
  @override
  _i4.Future<_i2.Response<dynamic>> logoutUser(
          String? jsonBody, String? token) =>
      (super.noSuchMethod(Invocation.method(#logoutUser, [jsonBody, token]),
              returnValue: Future<_i2.Response<dynamic>>.value(
                  _FakeResponse_2<dynamic>()))
          as _i4.Future<_i2.Response<dynamic>>);
  @override
  _i4.Future<_i2.Response<dynamic>> changePassword(String? jsonBody) =>
      (super.noSuchMethod(Invocation.method(#changePassword, [jsonBody]),
              returnValue: Future<_i2.Response<dynamic>>.value(
                  _FakeResponse_2<dynamic>()))
          as _i4.Future<_i2.Response<dynamic>>);
}