import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/screens/change_password/domain/repositories/change_password_repository.dart';
import 'package:clean_architecture_flutter/screens/change_password/domain/usecases/change_password.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_test.mocks.dart';

@GenerateMocks([ChangePasswordRepository])
void main() {
  late MockChangePasswordRepository mockRepository;
  late ChangePassword usecase;

  setUp(() {
    mockRepository = MockChangePasswordRepository();
    usecase = ChangePassword(
      repository: mockRepository,
    );
  });

  group('call', () {
    final String tOldPassword = "123456789";
    final String tNewPassword = "987654321";

    test('should return true if everything is successfull', () async {
      //arrange
      when(mockRepository.changePassword(any, any))
          .thenAnswer((_) async => Right(true));

      //act
      final result = await usecase(ChangePasswordParams(
        oldPassword: tOldPassword,
        newPassword: tNewPassword,
      ));

      //assert
      verify(mockRepository.changePassword(tOldPassword, tNewPassword));
      verifyNoMoreInteractions(mockRepository);
      expect(result, Right(true));
    });

    test('should return failure if anything is wrong', () async {
      //arrange
      when(mockRepository.changePassword(any, any))
          .thenAnswer((_) async => Left(ServerFailure()));

      //act
      final result = await usecase(ChangePasswordParams(
        oldPassword: tOldPassword,
        newPassword: tNewPassword,
      ));

      //assert
      verify(mockRepository.changePassword(tOldPassword, tNewPassword));
      verifyNoMoreInteractions(mockRepository);
      expect(result, Left(ServerFailure()));
    });
  });
}
