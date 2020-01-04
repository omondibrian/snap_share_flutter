
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/core/errors/exceptions.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/core/network/network_info.dart';
import 'package:test_flutter/features/signUp_signIn/Data/Models/user_model.dart';
import 'package:test_flutter/features/signUp_signIn/Data/Repositories/signup_signin_repository_impl.dart';
import 'package:test_flutter/features/signUp_signIn/Data/dataSources/user_local_data_source.dart';
import 'package:test_flutter/features/signUp_signIn/Data/dataSources/user_remote_data_source.dart';



class MockLocalDataSource extends Mock implements UserLocalDataSource{}
class MockRemoteDataSource extends Mock implements UserRemoteDataSource{}
class MockNetworkInfo extends Mock implements NetworkInfo{}

void main(){
   MockLocalDataSource mockLocalDataSource;
   MockRemoteDataSource mockRemoteDataSource;
   MockNetworkInfo networkInfo ;
   UserRepository repository;

  setUp((){
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = UserRepository(  localDataSource:mockLocalDataSource,
                                  remoteDataSource:mockRemoteDataSource,  networkInfo:networkInfo);

  });

    void runTestsOnline(Function body){
    group('should test when device is online',(){
    setUp((){
     when(networkInfo.isConnected).thenAnswer((_) async => true );
      });
      
      body();
    });

  }
    void runTestsOffline(Function body){
    group('should test when device is offline',(){
    setUp((){
     when(networkInfo.isConnected).thenAnswer((_) async => false );
      });
      body();
    });

  }
    final tUserModel = UserModel(
      id:'0',name:"test user",imageUrl: "assets/images/gondola.jpg"
  );
List<UserModel> tUsers = [tUserModel,tUserModel,tUserModel];
  group('getUser', () {

    test('should check if the device is online', () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true );
      //act
      repository.getUser();
      //assert
      verify(networkInfo.isConnected);
    });

     runTestsOnline(() {

      test('and return remote data when the call to remote endpoint is successful', ()async {
        //arrange
          when(mockRemoteDataSource.getUser())
          .thenAnswer((_)async => tUserModel);
        //act
         final result = await repository.getUser();
        //assert
        expect(result, equals(Right(tUserModel)));
      });
        test('and cache data locally when the call to remote endpoint is successful', ()async {
        //arrange
          when(mockRemoteDataSource.getUser())
          .thenAnswer((_)async => tUserModel);
         await mockLocalDataSource.cacheUser(tUserModel);
        //assert
       verify(mockLocalDataSource.cacheUser(tUserModel));

      });
      test('and return server failure when the call to remote endpointis unsuccessful', ()async {
        //arrange
          when(mockRemoteDataSource.getUser())
          .thenThrow(ServerException());
        //act
         final result = await repository.getUser();
        //assert
        expect(result, equals(Left(ServerFailure())));
        verifyZeroInteractions(mockLocalDataSource);
      });     
    });

    runTestsOffline(() {
      test('and  return the recently cached data when the cached data is present',()async{
        //arrange
        when(mockLocalDataSource.getUser())
        .thenAnswer((_)async => tUserModel);
        //act
         final result = await repository.getUser();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getUser());
        expect(result, Right(tUserModel));
      });
      test('and throw CacheException when the recently cached data  is not present',()async{
        //arrange
        when(mockLocalDataSource.getUser())
        .thenThrow(CacheException());
        //act
         final result = await repository.getUser();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getUser());
        expect(result,Left(CacheFailure()));  

      });
    });
  });


  group('getUsers', () {
    List<String> userIds = ['1','2','3'];
    test('should check if the device is online', () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true );
      //act
      repository.getUsers(userIds);
      //assert
      verify(networkInfo.isConnected);
    });

     runTestsOnline(() {

      test('and return remote data when the call to remote endpoint is successful', ()async {
        //arrange
          when(mockRemoteDataSource.getUsers(userIds))
          .thenAnswer((_)async => tUsers);
        //act
         final result = await repository.getUsers(userIds);
        //assert
        expect(result, equals(Right(tUsers)));
      });
        test('and cache data locally when the call to remote endpoint is successful', ()async {
        //arrange
          when(mockRemoteDataSource.getUsers(userIds))
          .thenAnswer((_)async => tUsers);
         await mockLocalDataSource.cacheUsers(tUsers);
        //assert
       verify(mockLocalDataSource.cacheUsers(tUsers));

      });
      test('and return server failure when the call to remote endpointis unsuccessful', ()async {
        //arrange
          when(mockRemoteDataSource.getUsers(userIds))
          .thenThrow(ServerException());
        //act
         final result = await repository.getUsers(userIds);
        //assert
        expect(result, equals(Left(ServerFailure())));
        verifyZeroInteractions(mockLocalDataSource);
      });     
    });

    runTestsOffline(() {
      test('and  return the recently cached data when the cached data is present',()async{
        //arrange
        when(mockLocalDataSource.getUsers())
        .thenAnswer((_)async => tUsers);
        //act
         final result = await repository.getUsers(userIds);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getUsers());
        expect(result, Right(tUsers));
      });
      test('and throw CacheException when the recently cached data  is not present',()async{
        //arrange
        when(mockLocalDataSource.getUsers())
        .thenThrow(CacheException());
        //act
         final result = await repository.getUsers(userIds);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getUsers());
        expect(result,Left(CacheFailure()));  

      });
    });
  });
}