import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, bool>> changePassword(
      String oldPassword, String newPassword);
}
