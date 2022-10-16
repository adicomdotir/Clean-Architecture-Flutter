// Mocks generated by Mockito 5.2.0 from annotations
// in clean_architecture_flutter/test/screens/login/data/repositories/login_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:clean_architecture_flutter/core/network/network_info.dart'
    as _i7;
import 'package:clean_architecture_flutter/screens/login/data/models/login_model.dart'
    as _i3;
import 'package:clean_architecture_flutter/screens/login/data/datasources/login_local_datasource.dart'
    as _i6;
import 'package:clean_architecture_flutter/screens/login/data/datasources/login_remote_datasource.dart'
    as _i4;
import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart'
    as _i2;
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

class _FakeLogin_0 extends _i1.Fake implements _i2.Login {}

class _FakeLoginModel_1 extends _i1.Fake implements _i3.LoginModel {}

/// A class which mocks [LoginRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginRemoteDataSource extends _i1.Mock
    implements _i4.LoginRemoteDataSource {
  MockLoginRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Login> loginUser(String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#loginUser, [email, password]),
              returnValue: Future<_i2.Login>.value(_FakeLogin_0()))
          as _i5.Future<_i2.Login>);
}

/// A class which mocks [LoginLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginLocalDataSource extends _i1.Mock
    implements _i6.LoginLocalDataSource {
  MockLoginLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.LoginModel> getLastToken() =>
      (super.noSuchMethod(Invocation.method(#getLastToken, []),
              returnValue: Future<_i3.LoginModel>.value(_FakeLoginModel_1()))
          as _i5.Future<_i3.LoginModel>);
  @override
  _i5.Future<void> cacheToken(_i3.LoginModel? loginModel) =>
      (super.noSuchMethod(Invocation.method(#cacheToken, [loginModel]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i7.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}
