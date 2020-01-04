import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/features/Chats/Data/models/chats_model.dart';
import 'package:test_flutter/features/Chats/Domain/entities/chats.dart';


  
  ///@fileOverView describes the contract between the repository in the domain layer
  ///with the actual concrete implementation in the data layer
  ///@author Brian Omondi Awuor email:OmondiBrian392@gmail.com
  
abstract class ChatsRepository  extends Equatable{
  
   ///@description fetch all user chats 
   ///@returns Either<Failure,List<Chats>> i.e a list of charts if sucessfull or a failure type
   
  Future<Either<Failure,List<Chats>>> getAllChats();
   
    ///@description fetch's conversation between the user and the specified contact
    ///@params {String} id this is the specified contact chat that is used to fetch
    ///the chats
    ///@returns Either<Failure,List<Chats>> i.e a list of charts if sucessfull or a failure type
    
  Future<Either<Failure,List<Chats>>> getSpecificChats(String id);
   
    ///@description Deletes conversation between the user and the specified contact
    ///@params {String} id this is the specified contact chat that is used to delete
    ///the chats
    ///@returns Either<Failure,bool> i.e a true if sucessfull or a failure type
    
  Future<Either<Failure,bool>> clearConversation(String id);

   
    ///@description deletes a specific chat between the user and the specified contact
    ///@params {String} id this is the specified contact chat that is used to delete
    ///the chat
    ///@returns Either<Failure,bool> i.e a true if sucessfull or a failure type
    
  Future<Either<Failure,bool>> deleteSpecificChat(String id);

    
    ///@description marks a specific chat as liked by the current user
    ///@params {String} id this is the specified contact chat that is used to delete
    ///the chat
    ///@returns Either<Failure,bool> i.e a true if sucessfull or a failure type
    
  Future<Either<Failure,bool>> likeSpecificChat(String id); 
     
    ///@description marks a chat when it is read by the user
    ///@params {String} id this is the specified contact chat that is used to delete
    ///the chat
    ///@returns Either<Failure,bool> i.e a true if sucessfull or a failure type
    
  Future<Either<Failure,bool>> markChatAsRead(String id);
    ///@description sends the chat from the user to the specific recepient
    ///@params [Chats chat] this is the specified contact chat that is used to delete
    ///the chat
    ///@returns Either<Failure,bool> i.e a true if sucessfull or a failure type
  Future<Either<Failure,bool>> sendChat(ChatsModel chat);
}