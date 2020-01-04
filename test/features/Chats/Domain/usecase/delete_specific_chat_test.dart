
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/delete_specific_chat.dart';


class MockChatRepository extends Mock implements ChatsRepository{}
void main(){
  DeleteSpecificChat useCase;
  MockChatRepository mockChatRepository;
  setUp((){
   mockChatRepository = MockChatRepository();
  useCase = DeleteSpecificChat(mockChatRepository);
  });
  final String id ='1';
  test('should delete the chat with the id passed', ()async {
    ///stubs
    when(mockChatRepository.deleteSpecificChat(id))
    .thenAnswer((_)async => Right(true));
    //act
    final results = await useCase(Params(id));
    //assert
    expect(results,Right(true));
    verify(mockChatRepository.deleteSpecificChat(id));
    verifyNoMoreInteractions(mockChatRepository);
  });
}