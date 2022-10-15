import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> loginUser(String email, String password);
}
