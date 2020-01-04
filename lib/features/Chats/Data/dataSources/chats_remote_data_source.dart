import 'package:test_flutter/core/errors/exceptions.dart';
import 'package:test_flutter/features/Chats/Data/models/chats_model.dart';
import 'package:http/http.dart' as Http;
import 'package:meta/meta.dart';
abstract class ChatsRemoteDataSource{

    ///call the server endpoints and throws a [serverException]
   ///@description fetch all user chats 
   ///@returns Either<Failure,List<Chats>> i.e a list of charts if sucessfull or a failure type
   
  Future<List<ChatsModel>> getAllChats();
    ///call the server endpoints and throws a [serverException]
    ///@description fetch's conversation between the user and the specified contact
    ///@params [string] id this is the specified contact chat that is used to fetch
    ///the chats
    ///@returns [ListChats>>] i.e a list of charts if sucessfull or a failure type
    
  Future<List<ChatsModel>>getSpecificChats(String id);
  ///call the server endpoints and throws a [serverException]
    ///@description Deletes conversation between the user and the specified contact
    ///@params [string] id this is the specified contact chat that is used to delete
    ///the chats
    ///@returns [bool] i.e a true if sucessfull or a failure type
    
  Future<bool> clearConversation(String id);

  ///call the server endpoints and throws a [serverException]
    ///@description deletes a specific chat between the user and the specified contact
    ///@params [string] id this is the specified contact chat that is used to delete
    ///the chat
    ///@returns [bool] i.e a true if sucessfull or a failure type
    
  Future<bool> deleteSpecificChat(String id);

  ///call the server endpoints and throws a [serverException]
    ///@description marks a specific chat as liked by the current user
    ///@params [string] id this is the specified contact chat that is used to delete
    ///the chat
    ///@returns [bool ]i.e a true if sucessfull or a failure type
    
  Future<bool> likeSpecificChat(String id); 
    ///call the server endpoints and throws a [serverException]
    ///@description marks a chat when it is read by the user
    ///@params [string] id this is the specified contact chat that is used to delete
    ///the chat
    ///@returns [bool ]i.e a true if sucessfull or a failure type
    
  Future<bool> markChatAsRead(String id);
     ///call the server endpoints and throws a [serverException]
    ///@description send chat from the user to the specified receipient
    ///@params [Chats chat] id this is the specified contact chat that is used to delete
    ///the chat
    ///@returns [bool ]i.e a true if sucessfull or a failure type
    
    Future<bool> sendChat(ChatsModel chat);
}



class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource{
  final Http.Client httpClient;

  ChatsRemoteDataSourceImpl({@required this.httpClient});
  
    Future<List<ChatsModel>> _getChatsFromUrl(String url) async {
     String token = 'vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
       final response = await httpClient.get(url,
      headers: {
        'AUTH_TOKEN':token
      },
    
      );
      if(response.statusCode == 200){
        return parseChats(response.body);
      }else{
        throw ServerException();
      }
  }

   @override
  Future<List<ChatsModel>> getAllChats() async{
    return await _getChatsFromUrl("http://localhost:4000/api/chats");
  }

    @override
  Future<List<ChatsModel>> getSpecificChats(String id)async {
    return await _getChatsFromUrl("http://localhost:4000/api/chats/$id");
  }
  
  @override
  Future<bool> clearConversation(String id) async{
        String token = 'vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
              final response = await httpClient.get("http://localhost:4000/api/chats/conv/$id",
              headers: {
                'AUTH_TOKEN':token
              },
            
              );
              if(response.statusCode == 200){
                return true;
              }else{
                throw ServerException();
              }
  }

  @override
  Future<bool> deleteSpecificChat(String id) async {
      String token = 'vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
          final response = await httpClient.delete("http://localhost:4000/api/chats/:id",
          headers: {
            'AUTH_TOKEN':token
          },
        
          );
          if(response.statusCode == 200){
            return true;
          }else{
            throw ServerException();
          }
  }

  @override
  Future<bool> likeSpecificChat(String id) async{
      String token = 'vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
          final response = await httpClient.post("http://localhost:4000/api/chats/:id",
          headers: {
            'AUTH_TOKEN':token
          },
        
          );
          if(response.statusCode == 200){
            return true;
          }else{
            throw ServerException();
          }
  }

  @override
  Future<bool> markChatAsRead(String id)async {
      String token = 'vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
          final response = await httpClient.post("http://localhost:4000/api/chats/read/:id",
          headers: {
            'AUTH_TOKEN':token
          },
        
          );
          if(response.statusCode == 200){
            return true;
          }else{
            throw ServerException();
          }
  }

  @override
  Future<bool> sendChat(ChatsModel chat) async{
      String token = 'vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
          final response = await httpClient.post("http://localhost:4000/api/chats",
          headers: {
            'AUTH_TOKEN':token
          },
          body: chat.toJson()
          );
          if(response.statusCode == 200){
            return true;
          }else{
            throw ServerException();
          }
  }
  
}