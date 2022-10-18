import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/network/network_info.dart';
import 'package:clean_architecture_flutter/screens/home/data/datasources/home_local_datasource.dart';
import 'package:clean_architecture_flutter/screens/home/data/datasources/home_remote_datasource.dart';
import 'package:clean_architecture_flutter/screens/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> logoutUser(String token) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.logoutUser(token);
        await localDataSource.clearToken();
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
