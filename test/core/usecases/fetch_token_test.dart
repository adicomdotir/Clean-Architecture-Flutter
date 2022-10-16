import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/usecases/fetch_token.dart';
import 'package:clean_architecture_flutter/screens/login/data/datasources/login_local_datasource.dart';
import 'package:clean_architecture_flutter/screens/login/data/models/login_model.dart';
import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart';
import 'package:clean_architecture_flutter/screens/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_token_test.mocks.dart';

@GenerateMocks([LoginRepository, LoginLocalDataSource])
void main() {
  late MockLoginLocalDataSource mockLoginLocalDataSource;
  late MockLoginRepository mockLoginRepository;
  late FetchToken useCase;

  setUp(() {
    mockLoginLocalDataSource = MockLoginLocalDataSource();
    mockLoginRepository = MockLoginRepository();
    useCase = FetchToken(repository: mockLoginRepository);
  });

  final tToken = "123456789";

  test('should return the cached token if available', () async {
    //arrange
    when(mockLoginLocalDataSource.getLastToken())
        .thenAnswer((_) async => LoginModel(token: ''));
    when(mockLoginRepository.fetchCachedToken())
        .thenAnswer((_) async => Right(Login(token: tToken)));

    //act
    final result = await useCase(TokenParams());

    //assert
    verify(mockLoginRepository.fetchCachedToken());
    verifyNoMoreInteractions(mockLoginRepository);
    expect(result, Right(Login(token: tToken)));
  });

  test('should return failure if token not excist', () async {
    //arrange
    when(mockLoginRepository.fetchCachedToken())
        .thenAnswer((_) async => Left(CacheFailure()));

    //act
    final result = await useCase(TokenParams());

    //assert
    expect(result, Left(CacheFailure()));
  });
}
