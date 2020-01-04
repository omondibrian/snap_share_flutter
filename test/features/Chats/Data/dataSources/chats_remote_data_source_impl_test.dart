import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as Http;
import 'package:test_flutter/core/errors/exceptions.dart';
import 'package:test_flutter/features/Chats/Data/dataSources/chats_remote_data_source.dart';
import 'package:test_flutter/features/Chats/Data/models/chats_model.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture_reader.dart';
class MockHttpClient extends Mock implements Http.Client{}

void main (){


  ChatsRemoteDataSourceImpl datasource;
  MockHttpClient mockHttpClient;


void isTruewhenCalled(MockHttpClient mockHttpClient) {
  when(mockHttpClient.get(any,headers:anyNamed('headers')))
  .thenAnswer(((_)async =>Http.Response('true',200)));
}


  setUp((){
    mockHttpClient = MockHttpClient();
    datasource = ChatsRemoteDataSourceImpl(httpClient:mockHttpClient);
  });


  final tChatModel = parseChats(fixture('final.json'));


  void setUpmockHttpClientSucess_200(MockHttpClient mockHttpClient) {
      //arrange
  when(mockHttpClient.get(any,headers:anyNamed('headers')))
  .thenAnswer(((_)async =>Http.Response(fixture('final.json'),200)));
}

void setUpmockHttpClientException(MockHttpClient mockHttpClient) {
     //arrange
  when(mockHttpClient.get(any,headers:anyNamed('headers')))
  .thenAnswer(((_)async =>Http.Response('error',404)));
}
  group('getAllChats', () {
    final String token ='vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
   
    test('''should perform a GET request returnig all the users chats 
            from the backend api and the AUTH_TOKEN header set''', ()async {
      //arrange
      setUpmockHttpClientSucess_200(mockHttpClient);
      //act
      datasource.getAllChats();
      //assert
      verify(mockHttpClient.get("http://localhost:4000/api/chats",
      headers: {
        'AUTH_TOKEN':token
      }
      ));

    });

    test('should return a list of chatsModel when the response code is 200', () async{
        //arrange
        setUpmockHttpClientSucess_200(mockHttpClient);
      //act
      final result = await datasource.getAllChats();
      //assert
      expect(result,equals(tChatModel));

    });
    test('should throw a server exception when the response code is 404 or any other code', () async{
         //arrange
      setUpmockHttpClientException(mockHttpClient);
        // act
      // final call = await datasource.getAllChats();
        //assert
      expect(() => datasource.getAllChats(),throwsA(TypeMatcher<ServerException>() ));
    });

  });

   group('getSpecificChats', () {
    final String token ='vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
    final String id = '1';
    test('''should perform a GET request returnig all the chats betweeen the user 
            and the specified receipient
            from the backend api and the AUTH_TOKEN header set''', ()async {
      //arrange
      setUpmockHttpClientSucess_200(mockHttpClient);
      //act
      datasource.getSpecificChats(id);
      //assert
      verify(mockHttpClient.get("http://localhost:4000/api/chats/$id",
      headers: {
        'AUTH_TOKEN':token
      }
      ));

    });

    test('should return a list of chatsModel when the response code is 200', () async{
        //arrange
        setUpmockHttpClientSucess_200(mockHttpClient);
      //act
      final result = await datasource.getSpecificChats(id);
      //assert
      expect(result,equals(tChatModel));

    });
    test('should throw a server exception when the response code is 404 or any other code', () async{
         //arrange
      setUpmockHttpClientException(mockHttpClient);
        // act
      // final call = await datasource.getAllChats();
        //assert
      expect(() => datasource.getSpecificChats(id),throwsA(TypeMatcher<ServerException>() ));
    });

  });

   group('clearConversation', () {
    final String token ='vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
    final String id = '1';
    test('''should perform a GET request returnig all the chats betweeen the user 
            and the specified receipient
            from the backend api and the AUTH_TOKEN header set''', ()async {
      //arrange
      isTruewhenCalled(mockHttpClient);
      //act
      datasource.clearConversation(id);
      //assert
      verify(mockHttpClient.get("http://localhost:4000/api/chats/conv/$id",
      headers: {
        'AUTH_TOKEN':token
      }
      ));

    });

    test('should return a list of chatsModel when the response code is 200', () async{
      //arrange
      isTruewhenCalled(mockHttpClient);
      //act
      final result = await datasource.clearConversation(id);
      //assert
      expect(result,equals(isTrue));

    });
    test('should throw a server exception when the response code is 404 or any other code', () async{
         //arrange
      setUpmockHttpClientException(mockHttpClient);
        // act
      // final call = await datasource.getAllChats();
        //assert
      expect(() => datasource.clearConversation(id),throwsA(TypeMatcher<ServerException>() ));
    });

  });


   group('deleteSpecificChat', () {
    final String token ='vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
    final String id = '1';
    test('''should perform a delete request returnig true on sucessfull deletion
            from the backend api and check if the AUTH_TOKEN header set''', ()async {
      //arrange
        when(mockHttpClient.delete(any,headers:anyNamed('headers')))
        .thenAnswer(((_)async =>Http.Response('true',200)));
      //act
      datasource.deleteSpecificChat(id);
      //assert
      verify(mockHttpClient.delete("http://localhost:4000/api/chats/:id",
      headers: {
        'AUTH_TOKEN':token
      }
      ));

    });

    test('should return true when the response code is 200', () async{
      //arrange
      //arrange
        when(mockHttpClient.delete(any,headers:anyNamed('headers')))
        .thenAnswer(((_)async =>Http.Response('true',200)));
      //act
      final result = await datasource.deleteSpecificChat(id);
      //assert
      expect(result,equals(isTrue));

    });
    test('should throw a server exception when the response code is 404 or any other code', () async{
     //arrange
      when(mockHttpClient.delete(any,headers:anyNamed('headers')))
      .thenAnswer(((_)async =>Http.Response('error',404)));
        // act
      // final call = await datasource.getAllChats();
        //assert
      expect(() => datasource.deleteSpecificChat(id),throwsA(TypeMatcher<ServerException>() ));
    });

  });

   group('likeSpecificChat', () {
    final String token ='vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
    final String id = '1';
    test('''should perform a post request returnig true when the chat is liked
            from the backend api and check if the AUTH_TOKEN header set''', ()async {
      //arrange
        when(mockHttpClient.post(any,headers:anyNamed('headers')))
        .thenAnswer(((_)async =>Http.Response('true',200)));
      //act
      datasource.likeSpecificChat(id);
      //assert
      verify(mockHttpClient.post("http://localhost:4000/api/chats/:id",
      headers: {
        'AUTH_TOKEN':token
      }
      ));

    });

    test('should return true when the response code is 200', () async{
      //arrange
        when(mockHttpClient.post(any,headers:anyNamed('headers')))
        .thenAnswer(((_)async =>Http.Response('true',200)));
      //act
      final result = await datasource.likeSpecificChat(id);
      //assert
      expect(result,equals(isTrue));

    });
    test('should throw a server exception when the response code is 404 or any other code', () async{
     //arrange
      when(mockHttpClient.post(any,headers:anyNamed('headers')))
      .thenAnswer(((_)async =>Http.Response('error',404)));
        // act
      // final call = await datasource.getAllChats();
        //assert
      expect(() => datasource.likeSpecificChat(id),throwsA(TypeMatcher<ServerException>() ));
    });

  });


   group('markChatAsRead', () {
    final String token ='vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
    final String id = '1';
    test('''should perform a post request returnig true when the chat is read
            from the backend api and check if the AUTH_TOKEN header set''', ()async {
      //arrange
        when(mockHttpClient.post(any,headers:anyNamed('headers')))
        .thenAnswer(((_)async =>Http.Response('true',200)));
      //act
      datasource.markChatAsRead(id);
      //assert
      verify(mockHttpClient.post("http://localhost:4000/api/chats/read/:id",
      headers: {
        'AUTH_TOKEN':token
      }
      ));

    });

    test('should return true when the response code is 200', () async{
      //arrange
        when(mockHttpClient.post(any,headers:anyNamed('headers')))
        .thenAnswer(((_)async =>Http.Response('true',200)));
      //act
      final result = await datasource.markChatAsRead(id);
      //assert
      expect(result,equals(isTrue));

    });
    test('should throw a server exception when the response code is 404 or any other code', () async{
     //arrange
      when(mockHttpClient.post(any,headers:anyNamed('headers')))
      .thenAnswer(((_)async =>Http.Response('error',404)));
        // act
      // final call = await datasource.getAllChats();
        //assert
      expect(() => datasource.markChatAsRead(id),throwsA(TypeMatcher<ServerException>() ));
    });

  });


group('sendChat', () {
    final String token ='vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
    final chat = ChatsModel(
   id: '1',   isLiked: true,text: "testing",time: "12:00 am",unread: false,senderId: 0
  );
    test('''should perform a post request returnig true when the chat is sucessfully sent
            to the backend api and check if the AUTH_TOKEN header set''', ()async {
      //arrange
        when(mockHttpClient.post("http://localhost:4000/api/chats",headers:anyNamed('headers'),body: anything))
        .thenAnswer(((_)async =>Http.Response('1',200)));
      //act
      datasource.sendChat(chat);
      //assert
      verify(mockHttpClient.post("http://localhost:4000/api/chats",
      headers: {
        'AUTH_TOKEN':token
      },
      body: chat.toJson()
      ));

    });

    test('should return true when the response code is 200', () async{
      //arrange
        when(mockHttpClient.post("http://localhost:4000/api/chats",headers:anyNamed('headers'),body: anything))
        .thenAnswer(((_)async =>Http.Response('1',200)));
      //act
      final result = await datasource.sendChat(chat);
      //assert
      expect(result,equals(isTrue));

    });
    test('should throw a server exception when the response code is 404 or any other code', () async{
     //arrange
      when(mockHttpClient.post(any,headers:anyNamed('headers'),body: anything))
      .thenAnswer(((_)async =>Http.Response('error',404)));
        // act
      // final call = await datasource.getAllChats();
        //assert
      expect(() => datasource.sendChat(chat),throwsA(TypeMatcher<ServerException>() ));
    });

  });
}



