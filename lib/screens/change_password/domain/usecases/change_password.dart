import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/usecases/usecase.dart';
import 'package:clean_architecture_flutter/screens/change_password/domain/repositories/change_password_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ChangePassword extends UseCase<bool, ChangePasswordParams> {
  final ChangePasswordRepository repository;

  ChangePassword({required this.repository});

  @override
  Future<Either<Failure, bool>> call(ChangePasswordParams params) {
    return repository.changePassword(params.oldPassword, params.newPassword);
  }
}

class ChangePasswordParams extends Equatable {
  final String oldPassword;
  final String newPassword;

  ChangePasswordParams({required this.oldPassword, required this.newPassword});

  @override
  List<Object?> get props => [oldPassword, newPassword];
}
