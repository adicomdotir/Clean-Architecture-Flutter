import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/usecases/usecase.dart';
import 'package:clean_architecture_flutter/screens/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LogoutUser extends UseCase<bool, LogoutParams> {
  final HomeRepository repository;

  LogoutUser({required this.repository});

  @override
  Future<Either<Failure, bool>> call(LogoutParams params) {
    return repository.logoutUser(params.token);
  }
}

class LogoutParams extends Equatable {
  final String token;

  LogoutParams({required this.token});

  @override
  List<Object?> get props => [token];
}
