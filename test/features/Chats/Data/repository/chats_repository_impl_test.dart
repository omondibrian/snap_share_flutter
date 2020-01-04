
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/core/errors/exceptions.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/core/network/network_info.dart';

import 'package:test_flutter/features/Chats/Data/Repositories/chats_repository_impl.dart';
import 'package:test_flutter/features/Chats/Data/dataSources/chats_local_data_source.dart';
import 'package:test_flutter/features/Chats/Data/dataSources/chats_remote_data_source.dart';
import 'package:test_flutter/features/Chats/Data/models/chats_model.dart';
import 'package:test_flutter/features/Chats/Domain/entities/chats.dart';

class MockRemoteDataSource extends Mock implements ChatsRemoteDataSource {}

class MockLocalDataSource extends Mock implements ChatsLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ChatsRepositoryimpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ChatsRepositoryimpl(
      remoteDataSource:mockRemoteDataSource,
      localDataSource:mockLocalDataSource,
      networkInfo:mockNetworkInfo
    );
  });
    final tChatModel1 = ChatsModel(
    id:"1" , isLiked: true,text: "testing",time: "12:00 am",unread: false,senderId: 0
  );
      final tChatModel2 = ChatsModel(
     id:'2', isLiked: true,text: "testing",time: "12:00 am",unread: false,senderId: 1
  );
      final tChatModel3 = ChatsModel(
      id:'3',isLiked: true,text: "testing",time: "12:00 am",unread: false,senderId: 1
  );
  final List<ChatsModel> allChatsModel = [tChatModel1,tChatModel2,tChatModel3];
   final List<ChatsModel> specificChatsModel = [tChatModel2,tChatModel3];
  final List<Chats> allChats = allChatsModel;
   final List<Chats> specificChats = specificChatsModel;
  void runTestsOnline(Function body){
    group('should test when device is online',(){
    setUp((){
     when(mockNetworkInfo.isConnected).thenAnswer((_) async => true );
      });
      
      body();
    });

  }
    void runTestsOffline(Function body){
    group('should test when device is offline',(){
    setUp((){
     when(mockNetworkInfo.isConnected).thenAnswer((_) async => false );
      });
      body();
    });

  }
  group('getChats', () {
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true );
      //act
      repository.getAllChats();
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {

      test('should return remote data when the call to remote data is successful', ()async {
        //arrange
          when(mockRemoteDataSource.getAllChats())
          .thenAnswer((_)async => allChatsModel);
        //act
         final result = await repository.getAllChats();
        //assert
        expect(result, equals(Right(allChats)));
      });
        test('should cache data locally when the call to remote data is successful', ()async {
        //arrange
          when(mockRemoteDataSource.getAllChats())
          .thenAnswer((_)async => allChatsModel);
         await mockLocalDataSource.cacheCharts(allChatsModel);
        //assert
       verify(mockLocalDataSource.cacheCharts(allChatsModel));

      });
      test('should return server failure when the call to remote data is unsuccessful', ()async {
        //arrange
          when(mockRemoteDataSource.getAllChats())
          .thenThrow(ServerException());
        //act
         final result = await repository.getAllChats();
        //assert
        expect(result, equals(Left(ServerFailure())));
        verifyZeroInteractions(mockLocalDataSource);
      });     
    });

    runTestsOffline(() {
      test('should  return the recently cached data when the cached data is present',()async{
        //arrange
        when(mockLocalDataSource.getAllCachedChats())
        .thenAnswer((_)async => allChatsModel);
        //act
         final result = await repository.getAllChats();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAllCachedChats());
        expect(result, Right(allChats));
      });
      test('should throw CacheException when the recently cached data  is not present',()async{
        //arrange
        when(mockLocalDataSource.getAllCachedChats())
        .thenThrow(CacheException());
        //act
         final result = await repository.getAllChats();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAllCachedChats());
        expect(result,Left(CacheFailure()));  

    });
  });
  });

group('getSpecificChats', () {
  final id = '1';
    test('when the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true );
      //act
      repository.getSpecificChats(id);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {

      test('should return remote data when the call to remote data is successful', ()async {
        //arrange
          when(mockRemoteDataSource.getSpecificChats(id))
          .thenAnswer((_)async => specificChatsModel);
        //act
         final result = await repository.getSpecificChats(id);
        //assert
        expect(result, equals(Right(specificChats)));
      });
      test('should return server failure when the call to remote data is unsuccessful', ()async {
        //arrange
          when(mockRemoteDataSource.getSpecificChats(id))
          .thenThrow(ServerException());
        //act
         final result = await repository.getSpecificChats(id);
        //assert
        expect(result, equals(Left(ServerFailure())));
        verifyZeroInteractions(mockLocalDataSource);
      });     
    });

    runTestsOffline(() {
      test('should return specific chats from the cached Chats when the device is offline',()async{
        //arrange
        when(mockLocalDataSource.getSpecificChatsFromCache(id))
        .thenAnswer((_)async => specificChatsModel);
        //act
         final result = await repository.getSpecificChats(id);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getSpecificChatsFromCache(id));
        expect(result, Right(specificChats));
      });
      test('should throw CacheException when the recently cached data  is not present',()async{
        //arrange
        when(mockLocalDataSource.getSpecificChatsFromCache(id))
        .thenThrow(CacheException());
        //act
         final result = await repository.getSpecificChats(id);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getSpecificChatsFromCache(id));
        expect(result,Left(CacheFailure()));  

    });
  });
  });
group('likeSpecificChat',(){
  final id = '1';
 test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true );
      //act
      repository.likeSpecificChat(id);
      //assert
      verify(mockNetworkInfo.isConnected);
    });
      runTestsOnline((){
        test('Should returns true when specific chat is liked', () async{
        //arrange
        when(mockRemoteDataSource.likeSpecificChat(id)).thenAnswer((_) async => true );
        //act
        final result = await repository.likeSpecificChat(id);
        //assert
        verify(mockRemoteDataSource.likeSpecificChat(id));
        expect(result,Right(true));  
      });
      test('should return server failure when the call to remote data is unsuccessful', ()async {
          //arrange
            when(mockRemoteDataSource.likeSpecificChat(id))
            .thenThrow(ServerException());
          //act
          final result = await repository.likeSpecificChat(id);
          //assert
          expect(result, equals(Left(ServerFailure())));
          verifyZeroInteractions(mockLocalDataSource);
        }); 
    });
    runTestsOffline((){
  test('should return server failure when the call to remote data is unsuccessful', ()async {
          //arrange
            when(mockRemoteDataSource.likeSpecificChat(id))
            .thenThrow(ServerException());
          //act
          final result = await repository.likeSpecificChat(id);
          //assert
          expect(result, equals(Left(ServerFailure())));
          verifyZeroInteractions(mockLocalDataSource);
        });
    });
});
group('markChatASRead',(){
  final id = '1';
    test('should check if the device is online', () async {
          //arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true );
          //act
          repository.markChatAsRead(id);
          //assert
          verify(mockNetworkInfo.isConnected);
        });
    runTestsOnline((){
     test('Should returns true when specific chat is read', () async{
        //arrange
        when(mockRemoteDataSource.markChatAsRead(id)).thenAnswer((_) async => true );
        //act
        final result = await repository.markChatAsRead(id);
        //assert
        verify(mockRemoteDataSource.markChatAsRead(id));
        expect(result,Right(true));
  });
  test('should return server failure when the call to remote data is unsuccessful', ()async {
          //arrange
            when(mockRemoteDataSource.markChatAsRead(id))
            .thenThrow(ServerException());
          //act
          final result = await repository.markChatAsRead(id);
          //assert
          expect(result, equals(Left(ServerFailure())));
          verifyZeroInteractions(mockLocalDataSource);
        });

    });
    runTestsOffline((){
  test('should return server failure when the call to remote data is unsuccessful', ()async {
          //arrange
            when(mockRemoteDataSource.likeSpecificChat(id))
            .thenThrow(ServerException());
          //act
          final result = await repository.likeSpecificChat(id);
          //assert
          expect(result, equals(Left(ServerFailure())));
          verifyZeroInteractions(mockLocalDataSource);
        });
    });
});
group('deleteSpecificChat',(){
  final id = '1';
    test('should check if the device is online', () async {
          //arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true );
          //act
          repository.markChatAsRead(id);
          //assert
          verify(mockNetworkInfo.isConnected);
        });
    
        runTestsOnline((){
     test('Should returns true when specific chat is deleted successfully', () async{
        //arrange
        when(mockRemoteDataSource.deleteSpecificChat(id)).thenAnswer((_) async => true );
        //act
        final result = await repository.deleteSpecificChat(id);
        //assert
        verify(mockRemoteDataSource.deleteSpecificChat(id));
        expect(result,Right(true));
  });
      test('should return server failure when the call to remote data is unsuccessful', ()async {
          //arrange
            when(mockRemoteDataSource.deleteSpecificChat(id))
            .thenThrow(ServerException());
          //act
          final result = await repository.deleteSpecificChat(id);
          //assert
          expect(result, equals(Left(ServerFailure())));
          verifyZeroInteractions(mockLocalDataSource);
        });

    });

      runTestsOffline((){
  test('should return server failure when the call to remote data is unsuccessful', ()async {
          //arrange
            when(mockRemoteDataSource.deleteSpecificChat(id))
            .thenThrow(ServerException());
          //act
          final result = await repository.deleteSpecificChat(id);
          //assert
          expect(result, equals(Left(ServerFailure())));
          verifyZeroInteractions(mockLocalDataSource);
        });
    });
});

group('clearConversation',(){
  final id = '1';
    test('should check if the device is online', () async {
          //arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true );
          //act
          repository.clearConversation(id);
          //assert
          verify(mockNetworkInfo.isConnected);
        });
    
        runTestsOnline((){
     test('Should returns true when specific conversation is deleted successfully', () async{
        //arrange
        when(mockRemoteDataSource.clearConversation(id)).thenAnswer((_) async => true );
        //act
        final result = await repository.clearConversation(id);
        //assert
        verify(mockLocalDataSource.clearSpecificConversation(id));
        verify(mockRemoteDataSource.clearConversation(id));
        expect(result,Right(true));
  });
  test('should return server failure when the call to remote data is unsuccessful', ()async {
          //arrange
            when(mockRemoteDataSource.clearConversation(id))
            .thenThrow(ServerException());
          //act
          final result = await repository.clearConversation(id);
          //assert
          expect(result, equals(Left(ServerFailure())));
          verifyZeroInteractions(mockLocalDataSource);
        });

    });

      runTestsOffline((){
  test('should clear the conversation from the local chat and store the id in cache to be sent to the server when network connectivity is regained', ()async {
        //arrange
        when(mockLocalDataSource.clearSpecificConversation(id))
        .thenThrow(CacheException());
        //act
         final result = await repository.clearConversation(id);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.clearSpecificConversation(id));
        expect(result,Left(CacheFailure()));  

        });

    });
});

group('sendChart',(){
  final  ChatsModel chat =  new ChatsModel(
     id: '1',   isLiked: true,text: "testing",time: "12:00 am",unread: false,senderId: 0
   );
    test('should check if the device is online', () async {
          //arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true );
          //act
          repository.sendChat(chat);
          //assert
          verify(mockNetworkInfo.isConnected);
        });
    
        runTestsOnline((){
     test('Should returns true when specific chat is sent successfully', () async{
        //arrange
        when(mockRemoteDataSource.sendChat(chat)).thenAnswer((_) async => true );
        //act
        final result = await repository.sendChat(chat);
        //assert
        verify(mockRemoteDataSource.sendChat(chat));
        expect(result,Right(true));
  });
      test('should return server failure when the call to remote data is unsuccessful', ()async {
          //arrange
            when(mockRemoteDataSource.sendChat(chat))
            .thenThrow(ServerException());
          //act
          final result = await repository.sendChat(chat);
          //assert
          expect(result, equals(Left(ServerFailure())));
          verifyZeroInteractions(mockLocalDataSource);
        });

    });
    runTestsOffline((){
      test('should return server failure when the call to remote data is unsuccessful', ()async {
              //arrange
                when(mockRemoteDataSource.sendChat(chat))
                .thenThrow(ServerException());
              //act
              final result = await repository.sendChat(chat);
              //assert
              expect(result, equals(Left(ServerFailure())));
              verifyZeroInteractions(mockLocalDataSource);
            });
    });
});


}