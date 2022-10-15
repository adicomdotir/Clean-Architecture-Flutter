import 'dart:convert';

import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/screens/login/data/models/login_model.dart';
import 'package:clean_architecture_flutter/screens/login/datasources/login_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'login_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LoginLocalDataSourceImpl dataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl =
        LoginLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastToken', () {
    final LoginModel tLoginModel =
        LoginModel.fromJson(jsonDecode(fixture('user_login.json')));

    test('should return last stored token (cached)', () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('user_login.json'));

      //act
      final result = await dataSourceImpl.getLastToken();

      //assert
      verify(mockSharedPreferences.getString(cachedTokenKey));
      expect(result, tLoginModel);
    });

    test('should return a Cache Failure when there is no stored token',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenThrow(CacheException());

      //act
      final call = dataSourceImpl.getLastToken;

      //assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheToken', () {
    final LoginModel tLoginModel = LoginModel(token: '123456');

    test('should store the token', () async {
      // arrange
      when(mockSharedPreferences.setString(
              cachedTokenKey, jsonEncode(tLoginModel)))
          .thenAnswer((_) async => Future.value(true));

      //act
      dataSourceImpl.cacheToken(tLoginModel);

      //assert
      verify(mockSharedPreferences.setString(
          cachedTokenKey, jsonEncode(tLoginModel)));
    });
  });
}
