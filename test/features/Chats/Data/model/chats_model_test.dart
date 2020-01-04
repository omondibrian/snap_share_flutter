
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/features/Chats/Data/models/chats_model.dart';
import 'package:test_flutter/features/Chats/Domain/entities/chats.dart';


import '../../../../fixtures/fixture_reader.dart';





void main(){
  // final sender = User(id:0,name:"test user",imageUrl:"assets/images/gondola.jpg");
  final tChatModel = ChatsModel(
   id: '1',   isLiked: true,text: "testing",time: "12:00 am",unread: false,senderId: 0
  );
         
  test('Should be a sub-class of chats-entity', ()async {
    expect(tChatModel, isA<Chats>());
  });
  group('from json function', (){
     test('Should return a valid model when passed in the json file', () async{
       final Map<String,dynamic> jsonMap = json.decode(fixture('test.json'));
       final result = ChatsModel.fromJson(jsonMap);
       print(result.text);
       expect(result, tChatModel);
     });
  });
  group('toJson', (){
  test('should return a JSON map containing the proper data',(){
      
        //arrange 
        final expectedMap = {
        "text": "testing",
        "isLiked": true,
        "time": "12:00 am",
        "unread": false,
        "senderId":0
        };
        //act
        final result = tChatModel.toJson();
        //assert
        expect(result,expectedMap);
      
  });
});
group('parseChats',(){
test('should return valid json', () {

  //act
  final parsed = fixture('final.json');          
  //assert
  expect(parseChats(parsed).first,tChatModel);
});

});
group('parseChat',(){
  test('should return a valid chatModel', () {
    // arrange
    final tChat ='''{ 
      "text": "testing",
      "isLiked": true,
      "time": "12:00 am",
      "unread": false,
      "senderId":0
    }''';
    //assert
    expect(parseChat(tChat).senderId,0);
  });
});
}  
