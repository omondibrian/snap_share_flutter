
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:test_flutter/core/network/network_info.dart';
class MockDataConnectionChecker extends Mock implements DataConnectionChecker{}
void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp((){
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(connection:mockDataConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to dataConnectionChecker.hasConnection', () async {
      //arrange
      final hasConnectionFuture = Future.value(true);
      when(mockDataConnectionChecker.hasConnection)
      .thenAnswer((_) => hasConnectionFuture);
      //act
      final result = networkInfo.isConnected;
      //assert
      verify(mockDataConnectionChecker.hasConnection);
      expect(result,hasConnectionFuture);

    });

  });

}