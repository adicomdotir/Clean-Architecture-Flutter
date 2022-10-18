import 'package:clean_architecture_flutter/screens/change_password/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:clean_architecture_flutter/screens/change_password/presentation/blocs/change_password/change_password_event.dart';
import 'package:clean_architecture_flutter/screens/change_password/presentation/blocs/change_password/change_password_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/screens/change_password/domain/usecases/change_password.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_bloc_test.mocks.dart';

@GenerateMocks([ChangePassword])
void main() {
  late MockChangePassword mockChangePassword;
  late ChangePasswordBloc bloc;

  setUp(() {
    mockChangePassword = MockChangePassword();
    bloc = ChangePasswordBloc(changePassword: mockChangePassword);
  });

  group('initialState', () {
    test('should be equal to Initial State', () async {
      //assert
      expect(bloc.initialState, equals(InitialState()));
    });
  });

  group('mapEventToState', () {
    final String tOldPassword = "123456789";
    final String tNewPassword = "987654321";

    test(
        'should return the correct sequence of states '
        'when everything is successfull', () async {
      //arrange
      when(mockChangePassword(ChangePasswordParams(
        oldPassword: tOldPassword,
        newPassword: tNewPassword,
      ))).thenAnswer((_) async => Right(true));

      //assert later
      expect(
          bloc.stream,
          emitsInOrder([
            InitialState(),
            LoadingState(),
            SuccessfulState(),
          ]));

      //act
      bloc.add(PasswordChangeEvent(
        oldPassword: tOldPassword,
        newPassword: tNewPassword,
      ));
      await untilCalled(mockChangePassword(ChangePasswordParams(
        oldPassword: tOldPassword,
        newPassword: tNewPassword,
      )));

      //assert
      verify(mockChangePassword(ChangePasswordParams(
        oldPassword: tOldPassword,
        newPassword: tNewPassword,
      )));
    });

    test(
        'should return the correct sequence of states '
        'when it fails', () async {
      //arrange
      when(mockChangePassword(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      expect(
          bloc.stream,
          emitsInOrder([
            InitialState(),
            LoadingState(),
            ErrorState(changePasswordErrorConst),
          ]));

      //act
      bloc.add(PasswordChangeEvent(
        oldPassword: tOldPassword,
        newPassword: tNewPassword,
      ));
      await untilCalled(mockChangePassword(any));

      //assert
      verify(mockChangePassword(ChangePasswordParams(
        oldPassword: tOldPassword,
        newPassword: tNewPassword,
      )));
    });
  });
}
