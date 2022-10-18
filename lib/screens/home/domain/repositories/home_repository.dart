import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, bool>> logoutUser(String token);
}
