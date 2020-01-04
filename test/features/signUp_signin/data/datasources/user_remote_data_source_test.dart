import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as Http;
import 'package:test_flutter/core/errors/exceptions.dart';
import 'package:matcher/matcher.dart';
import 'package:test_flutter/features/signUp_signIn/Data/Models/user_model.dart';
import 'package:test_flutter/features/signUp_signIn/Data/dataSources/user_remote_data_source.dart';
import '../../../../fixtures/fixture_reader.dart';
class MockHttpClient extends Mock implements Http.Client{}

void main(){
    UserRemoteDataSourceImpl datasource;
    MockHttpClient mockHttpClient;
      setUp((){
    mockHttpClient = MockHttpClient();
    datasource = UserRemoteDataSourceImpl(httpClient:mockHttpClient);
  });


  final tUserModel = parseUsers(fixture('users.json'));
  final tUser = parseUser(fixture('user.json'));

group('getUsers', () {
    final String token ='vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
   
    test('''should perform a GET request returnig all the users  
            from the backend api and the AUTH_TOKEN header set''', ()async {
      //arrange
      when(mockHttpClient.get(any,headers:anyNamed('headers')))
      .thenAnswer(((_)async =>Http.Response(fixture('users.json'),200)));
      //act
     datasource.getUsers(['1','2','3']);
      //assert
      verify(mockHttpClient.get(any,
      headers: {
        'AUTH_TOKEN':token
      }
      ));

    });

    test('should return a list of userModel when the response code is 200', () async{
      //arrange
      when(mockHttpClient.get(any,headers:anyNamed('headers')))
      .thenAnswer(((_)async =>Http.Response(fixture('users.json'),200)));
      //act
      datasource.getUsers(['1','2','3']);
      //assert
      verify(mockHttpClient.get(any,
      headers: {
        'AUTH_TOKEN':token
      }));
      //act
      final result = await datasource.getUsers(['1','2','3']);
      //assert
      expect(result,equals(tUserModel));

    });
    test('should throw a server exception when the response code is 404 or any other code', () async{
     //arrange
      when(mockHttpClient.get(any,headers:anyNamed('headers')))
      .thenAnswer(((_)async =>Http.Response('error',404)));
        // act

        //assert
      expect(() => datasource.getUsers(['1','2','3']),throwsA(TypeMatcher<ServerException>() ));
    });

  });



group('getUser', () {
    final String token ='vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
   
    test('''should perform a GET request returnig  the user
            from the backend api and the AUTH_TOKEN header set''', ()async {
      //arrange
      when(mockHttpClient.get(any,headers:anyNamed('headers')))
      .thenAnswer(((_)async =>Http.Response(fixture('user.json'),200)));
      //act
     datasource.getUser();
      //assert
      verify(mockHttpClient.get(any,
      headers: {
        'AUTH_TOKEN':token
      }
      ));

    });

    test('should return user when the response code is 200', () async{
      //arrange
      when(mockHttpClient.get(any,headers:anyNamed('headers')))
      .thenAnswer(((_)async =>Http.Response(fixture('user.json'),200)));
      //act
      datasource.getUser();
      //assert
      verify(mockHttpClient.get(any,
      headers: {
        'AUTH_TOKEN':token
      }));
      //act
      final result = await  datasource.getUser();
      //assert
      expect(result,equals(tUser));

    });
    test('should throw a server exception when the response code is 404 or any other code', () async{
     //arrange
      when(mockHttpClient.get(any,headers:anyNamed('headers')))
      .thenAnswer(((_)async =>Http.Response('error',404)));
        // act

        //assert
      expect(() =>  datasource.getUser(),throwsA(TypeMatcher<ServerException>() ));
    });

  });

}
