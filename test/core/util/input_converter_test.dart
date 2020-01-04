
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/core/util/input_converter.dart';
import 'package:test_flutter/features/Chats/Data/models/chats_model.dart';

void main(){
  InputConverter inputConverter;
  setUp((){
    inputConverter = InputConverter();
  });
  group('StringToModel', () {
    
       final tChatModel = ChatsModel(
   id: '1',   isLiked: false,text: "test chat",time: "12:00 am",unread: false,senderId: 0
  );
    test('should return chatsModel object when a String is passed', () async{
      //arrange
      final text = 'test chat';
      //act
      final result = inputConverter.stringToModel(text);
      //assert
      expect(result, Right(tChatModel));
    });
    test('should return a failure when the input is empty', () {
      //arrange
      final text = '';
      //act
      final result = inputConverter.stringToModel(text);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
    
  });
}