import 'package:clean_architecture_flutter/core/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(
        internetConnectionChecker: mockInternetConnectionChecker);
  });

  group('is Connected', () {
    setUp(() {
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);
    });

    test('should forward the connection to the desired method', () async {
      //act
      final result = await networkInfoImpl.isConnected;

      //assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
