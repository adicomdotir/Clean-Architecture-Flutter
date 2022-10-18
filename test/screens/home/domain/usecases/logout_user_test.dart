import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/screens/home/domain/repositories/home_repository.dart';
import 'package:clean_architecture_flutter/screens/home/domain/usecases/logout_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_user_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late MockHomeRepository mockHomeRepository;
  late LogoutUser logoutUser;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    logoutUser = LogoutUser(repository: mockHomeRepository);
  });

  group('call', () {
    final String tToken = "123456789";

    test('should return true if logging out is successfull', () async {
      //arrange
      when(mockHomeRepository.logoutUser(any))
          .thenAnswer((_) async => Right(true));

      //act
      final result = await logoutUser(LogoutParams(token: tToken));

      //assert
      verify(mockHomeRepository.logoutUser(tToken));
      expect(result, Right(true));
    });

    test('should return a failure if logging out returns', () async {
      //arrange
      when(mockHomeRepository.logoutUser(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      //act
      final result = await logoutUser(LogoutParams(token: tToken));

      //assert
      verify(mockHomeRepository.logoutUser(tToken));
      expect(result, Left(ServerFailure()));
    });
  });
}
