import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/network/rest_client_service.dart';
import 'package:clean_architecture_flutter/screens/change_password/data/datasources/change_password_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'change_password_remote_datasource_test.mocks.dart';

@GenerateMocks([RestClientService])
void main() {
  late MockRestClientService mockRestClientService;
  late ChangePasswordRemoteDataSource remoteDataSource;

  setUp(() {
    mockRestClientService = MockRestClientService();
    remoteDataSource = ChangePasswordRemoteDataSourceImpl(
      restClientService: mockRestClientService,
    );
  });

  group('changePassword', () {
    final String tOldPassword = "123456789";
    final String tNewPassword = "987654321";

    test('should return true when the task is successful', () async {
      //arrange
      when(mockRestClientService.changePassword(any))
          .thenAnswer((_) async => Response(http.Response("", 204), ''));

      //act
      final result =
          await remoteDataSource.changePassword(tOldPassword, tNewPassword);

      //assert
      verify(mockRestClientService.changePassword(jsonEncode({
        'oldPassword': tOldPassword,
        'newPassword': tNewPassword,
      })));
      verifyNoMoreInteractions(mockRestClientService);
      expect(result, equals(true));
    });

    test('should return a server exception if it fails', () async {
      //arrange
      when(mockRestClientService.changePassword(any))
          .thenThrow(ServerException());

      //act
      final call = remoteDataSource.changePassword;

      //assert
      expect(() => call(tOldPassword, tNewPassword),
          throwsA(isA<ServerException>()));
    });
  });
}
