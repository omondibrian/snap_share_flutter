import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/clear_conversation.dart';


class MockChatsRepository extends Mock implements ChatsRepository {}
void main() {
  ClearConversation useCase ;
  MockChatsRepository mockChatsRepository;
  setUp((){
    mockChatsRepository = MockChatsRepository();
    useCase = ClearConversation(mockChatsRepository);
  });

   final tId = "1" ;
     test('Should clear the specified conversation between the user and the current contact', 
  () async {
    //stub
    when(mockChatsRepository.clearConversation(tId))
    .thenAnswer((_) async => Right(true));
    //act
    final result = await useCase(Params(tId));
    //assert
    expect(result,Right(true));
    verify(mockChatsRepository.clearConversation(tId));
    verifyNoMoreInteractions(mockChatsRepository);
  });
}