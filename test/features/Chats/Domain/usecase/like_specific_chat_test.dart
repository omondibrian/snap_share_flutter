

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/like_specific_chat.dart';

class MockChatRepository extends Mock implements ChatsRepository{}

void main(){
  LikeSpecificChat useCase;
  MockChatRepository mockChatRepository;

  setUp((){
     mockChatRepository = MockChatRepository();
     useCase = LikeSpecificChat(mockChatRepository);
  });
  final id = '1';
  test('Should return true when a chat is liked', () async{
    when(mockChatRepository.likeSpecificChat(any))
    .thenAnswer((_) async => Right(true));
    //act
    final result = await useCase(Params(id));
    //assert
    expect(result,Right(true));
    verify(mockChatRepository.likeSpecificChat(id));
    verifyNoMoreInteractions(mockChatRepository);
  });
}