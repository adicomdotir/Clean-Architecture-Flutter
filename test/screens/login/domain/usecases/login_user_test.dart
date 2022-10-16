import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart';
import 'package:clean_architecture_flutter/screens/login/domain/repositories/login_repository.dart';
import 'package:clean_architecture_flutter/screens/login/domain/usecases/login_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_user_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late MockLoginRepository mockUserRepository;
  late LoginUser useCase;

  setUp(() {
    mockUserRepository = MockLoginRepository();
    useCase = LoginUser(repository: mockUserRepository);
  });

  final tEmail = "test@test.com";
  final Login tUser = Login(token: "");

  test('should return a User object with relevant email and token', () async {
    //arrange
    when(mockUserRepository.loginUser(tEmail, "test"))
        .thenAnswer((_) async => Right(tUser));

    //act
    final result = await useCase(LoginParams(email: tEmail, password: "test"));

    //assert
    expect(result, Right(tUser));
    verify(mockUserRepository.loginUser(tEmail, "test"));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
