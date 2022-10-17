import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/network/network_info.dart';
import 'package:clean_architecture_flutter/screens/change_password/data/datasources/change_password_local_datasource.dart';
import 'package:clean_architecture_flutter/screens/change_password/data/datasources/change_password_remote_datasource.dart';
import 'package:clean_architecture_flutter/screens/change_password/domain/repositories/change_password_repository.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordRepositoryImpl extends ChangePasswordRepository {
  final ChangePasswordLocalDataSource localDataSource;
  final ChangePasswordRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChangePasswordRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, bool>> changePassword(
      String oldPassword, String newPassword) async {
    if (await networkInfo.isConnected) {
      try {
        var result =
            await remoteDataSource.changePassword(oldPassword, newPassword);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(NoConnectionFailure());
  }
}
