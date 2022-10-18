import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/usecases/fetch_token.dart';
import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/screens/home/domain/usecases/logout_user.dart';
import 'package:clean_architecture_flutter/screens/home/presentation/blocs/logout/logout_bloc.dart';
import 'package:clean_architecture_flutter/screens/home/presentation/blocs/logout/logout_event.dart';
import 'package:clean_architecture_flutter/screens/home/presentation/blocs/logout/logout_state.dart';
import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_bloc_test.mocks.dart';

@GenerateMocks([FetchToken, LogoutUser])
void main() {
  late MockFetchToken mockFetchToken;
  late MockLogoutUser mockLogoutUser;
  late LogoutBloc logoutBloc;

  setUp(() {
    mockLogoutUser = MockLogoutUser();
    mockFetchToken = MockFetchToken();
    logoutBloc = LogoutBloc(
      logoutUser: mockLogoutUser,
      fetchToken: mockFetchToken,
    );
  });

  group('initialState', () {
    test('should return LoggedInState as the initial state', () async {
      //assert
      expect(LogoutBloc.initialState, equals(LoggedInState()));
    });
  });

  group('mapEventToState', () {
    final String tToken = "123456789";

    test(
        'should return the correct sequence of states '
        'when everything is successfull', () async {
      //arrange
      when(mockFetchToken(any)).thenAnswer((_) async => Right(Login(
            token: tToken,
          )));
      when(mockLogoutUser(any)).thenAnswer((_) async => Right(true));

      //assert later
      expectLater(
          logoutBloc.stream,
          emitsInOrder([
            LoggedInState(),
            LoadingState(),
            LoggedOutState(),
          ]));

      //act
      logoutBloc.add(UserLogoutEvent());
      await untilCalled(mockLogoutUser.call(any));

      //assert
      verify(mockFetchToken.call(TokenParams()));
      verify(mockLogoutUser.call(LogoutParams(token: tToken)));
    });

    test(
        'should return the correct sequence of states '
        'when logoutuser is not successfull', () async {
      //arrange
      when(mockFetchToken.call(any)).thenAnswer((_) async => Right(Login(
            token: tToken,
          )));
      when(mockLogoutUser.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      expectLater(
          logoutBloc.stream,
          emitsInOrder([
            LoggedInState(),
            LoadingState(),
            ErrorState(loggingOutErrorConst),
          ]));

      //act
      logoutBloc.add(UserLogoutEvent());
      await untilCalled(mockLogoutUser.call(any));

      //assert
      verify(mockFetchToken.call(TokenParams()));
      verify(mockLogoutUser.call(LogoutParams(token: tToken)));
    });

    test(
        'should return the correct sequence of states '
        'when fetch token is not successfull', () async {
      //arrange
      when(mockFetchToken.call(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      expectLater(
          logoutBloc.stream,
          emitsInOrder([
            LoggedInState(),
            LoadingState(),
            ErrorState(loggingOutErrorConst),
          ]));

      //act
      logoutBloc.add(UserLogoutEvent());
      await untilCalled(mockFetchToken.call(any));

      //assert
      verify(mockFetchToken.call(TokenParams()));
      verifyZeroInteractions(mockLogoutUser);
    });
  });
}
