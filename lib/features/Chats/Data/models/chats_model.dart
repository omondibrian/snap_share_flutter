import 'package:meta/meta.dart';
import 'package:test_flutter/features/Chats/Domain/entities/chats.dart';
import 'dart:convert' as json;
class ChatsModel extends Chats {
  
  ChatsModel({
    @required String id,
    @required int senderId,
    @required  String text, 
    @required  bool isLiked, 
    @required  String time,
    @required bool unread,
     
  }):super(isLiked:isLiked,time:time,text:text,unread:unread,senderId:senderId,id:id);
 
  factory ChatsModel.fromJson(Map<String,dynamic> json){
        return ChatsModel(
      id: json['id'],
      senderId: json['senderId'],
      isLiked: json['isLiked'],
      text: json['text'],
      time: json['time'],
      unread:json['unread']
    );
  }
  Map<String,dynamic> toJson(){
    return {
        'senderId':senderId,
        'isLiked':isLiked,
        'text':text,
        'time':time,
        'unread':unread

    };
  }
}
///parse a json list and return a List<ChatsModel> 
  List<ChatsModel> parseChats(String jsonString){
    final parsed = json.jsonDecode(jsonString);
    final chatList = parsed.map((parsedChat){    
       final chat = ChatsModel.fromJson(parsedChat);
       return chat;
    });
    final chatModelList = List<ChatsModel> .from(chatList);
    return chatModelList;
  }
///parse a json object and return ChatsModel
  ChatsModel parseChat(String jsonString){
    final parsed = json.jsonDecode(jsonString);
    ChatsModel chatsModel = ChatsModel.fromJson(parsed);
    return chatsModel;
  }
