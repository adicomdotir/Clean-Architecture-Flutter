import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/usecases/fetch_token.dart';
import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart';
import 'package:clean_architecture_flutter/screens/login/domain/usecases/login_user.dart';
import 'package:clean_architecture_flutter/screens/login/presentation/blocs/user_login/user_login_bloc.dart';
import 'package:clean_architecture_flutter/screens/login/presentation/blocs/user_login/user_login_event.dart';
import 'package:clean_architecture_flutter/screens/login/presentation/blocs/user_login/user_login_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_login_bloc_test.mocks.dart';

@GenerateMocks([LoginUser, FetchToken])
void main() {
  late UserLoginBloc userLoginBloc;
  late MockLoginUser mockLoginUser;
  late MockFetchToken mockFetchToken;

  setUp(() {
    mockLoginUser = MockLoginUser();
    mockFetchToken = MockFetchToken();
    userLoginBloc = UserLoginBloc(
      loginUser: mockLoginUser,
      fetchToken: mockFetchToken,
    );
  });

  tearDown(() {
    userLoginBloc.close();
  });

  final String tEmail = 'test@test.com';
  final String tPassword = 'test';

  test('should initial state equals to NotLoggedIn', () async {
    //assert
    expect(userLoginBloc.initialState, equals(NotLoggedState()));
  });

  group(
    'loginUser',
    () {
      test('should return an error if login is not successfull', () async {
        //arrange
        when(mockLoginUser(any)).thenAnswer((_) async => Left(ServerFailure()));

        //act
        userLoginBloc.add(LoginEvent(tEmail, tPassword));

        //assert
        expectLater(
          userLoginBloc.stream,
          emitsInOrder(
            [
              NotLoggedState(),
              LoadingState(),
              ErrorState(message: loggingErrorConst)
            ],
          ),
        );
      });

      test(
        'should return LoggedState if login is successfull',
        () async {
          //arrange
          when(mockLoginUser(any))
              .thenAnswer((_) async => Right(Login(token: "1234")));

          //act
          userLoginBloc.add(LoginEvent(tEmail, tPassword));

          //assert
          expect(
            userLoginBloc.stream,
            emitsInOrder(
              [
                NotLoggedState(),
                LoadingState(),
                LoggedState(login: Login(token: "1234"))
              ],
            ),
          );
        },
      );
    },
  );

  group('fetchToken', () {
    test('should return an error if token is not exists', () async {
      //arrange
      when(mockFetchToken(any)).thenAnswer((_) async => Left(CacheFailure()));

      //act
      userLoginBloc.add(CheckLoginStatusEvent());

      //assert
      expectLater(
        userLoginBloc.stream,
        emitsInOrder(
          [
            NotLoggedState(),
            LoadingState(),
            NotLoggedState(),
          ],
        ),
      );
    });

    test('should return the token if exists', () async {
      //arrange
      when(mockFetchToken(any))
          .thenAnswer((_) async => Right(Login(token: "1234")));

      //act
      userLoginBloc.add(CheckLoginStatusEvent());

      //assert
      expect(
        userLoginBloc.stream,
        emitsInOrder(
          [
            NotLoggedState(),
            LoadingState(),
            LoggedState(login: Login(token: "1234")),
          ],
        ),
      );
    });
  });
}
