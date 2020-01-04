

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/mark_chat_as_read.dart';

class MockChatRepository extends Mock implements ChatsRepository{}

void main(){
  MarkChatAsRead useCase;
  MockChatRepository mockChatRepository;

  setUp((){
     mockChatRepository = MockChatRepository();
     useCase = MarkChatAsRead(mockChatRepository);
  });
  final id = '1';
  test('Should return true when a chat is liked', () async{
    when(mockChatRepository.markChatAsRead(id))
    .thenAnswer((_) async => Right(true));
    //act
    final result = await useCase(Params(id));
    //assert
    expect(result,Right(true));
    verify(mockChatRepository.markChatAsRead(id));
    verifyNoMoreInteractions(mockChatRepository);
  });
}