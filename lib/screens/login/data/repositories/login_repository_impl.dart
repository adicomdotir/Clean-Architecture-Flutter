import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/network/network_info.dart';
import 'package:clean_architecture_flutter/screens/login/data/datasources/login_local_datasource.dart';
import 'package:clean_architecture_flutter/screens/login/data/datasources/login_remote_datasource.dart';
import 'package:clean_architecture_flutter/screens/login/data/models/login_model.dart';
import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart';
import 'package:clean_architecture_flutter/screens/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl extends LoginRepository {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;

  LoginRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Login>> loginUser(
      String email, String password) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final result = await remoteDataSource.loginUser(email, password);
        localDataSource.cacheToken(LoginModel(token: result.token));
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Login>> fetchCachedToken() async {
    try {
      final localData = await localDataSource.getLastToken();
      return Right(localData);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
