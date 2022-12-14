// Mocks generated by Mockito 5.2.0 from annotations
// in clean_architecture_flutter/test/screens/home/presentation/blocs/logout/logout_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:clean_architecture_flutter/core/error/failures.dart' as _i7;
import 'package:clean_architecture_flutter/core/usecases/fetch_token.dart'
    as _i5;
import 'package:clean_architecture_flutter/screens/home/domain/repositories/home_repository.dart'
    as _i4;
import 'package:clean_architecture_flutter/screens/home/domain/usecases/logout_user.dart'
    as _i9;
import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart'
    as _i8;
import 'package:clean_architecture_flutter/screens/login/domain/repositories/login_repository.dart'
    as _i2;
import 'package:dartz/dartz.dart' as _i3;
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

class _FakeLoginRepository_0 extends _i1.Fake implements _i2.LoginRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

class _FakeHomeRepository_2 extends _i1.Fake implements _i4.HomeRepository {}

/// A class which mocks [FetchToken].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchToken extends _i1.Mock implements _i5.FetchToken {
  MockFetchToken() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LoginRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeLoginRepository_0()) as _i2.LoginRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, _i8.Login>> call(
          _i5.TokenParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<_i3.Either<_i7.Failure, _i8.Login>>.value(
                  _FakeEither_1<_i7.Failure, _i8.Login>()))
          as _i6.Future<_i3.Either<_i7.Failure, _i8.Login>>);
}

/// A class which mocks [LogoutUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockLogoutUser extends _i1.Mock implements _i9.LogoutUser {
  MockLogoutUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.HomeRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeHomeRepository_2()) as _i4.HomeRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, bool>> call(_i9.LogoutParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<_i3.Either<_i7.Failure, bool>>.value(
                  _FakeEither_1<_i7.Failure, bool>()))
          as _i6.Future<_i3.Either<_i7.Failure, bool>>);
}
