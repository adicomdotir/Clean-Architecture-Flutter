import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/usecases/usecase.dart';
import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart';
import 'package:clean_architecture_flutter/screens/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchToken extends UseCase<Login, TokenParams> {
  final LoginRepository repository;

  FetchToken({required this.repository});

  @override
  Future<Either<Failure, Login>> call(TokenParams params) {
    return repository.fetchCachedToken();
  }
}

class TokenParams extends Equatable {
  @override
  List<Object?> get props => [];
}
