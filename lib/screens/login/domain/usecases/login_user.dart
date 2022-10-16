import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart';
import 'package:clean_architecture_flutter/screens/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUser {
  final LoginRepository repository;

  LoginUser({required this.repository});

  Future<Either<Failure, Login>> call(LoginParams params) {
    return repository.loginUser(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
