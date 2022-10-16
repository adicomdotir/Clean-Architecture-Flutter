import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/usecases/usecase.dart';
import 'package:clean_architecture_flutter/screens/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class FetchToken extends UseCase {
  final LoginRepository repository;

  FetchToken({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return repository.fetchCachedToken();
  }
}

class TokenParams {}
