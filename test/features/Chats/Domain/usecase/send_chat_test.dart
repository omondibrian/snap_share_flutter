
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/features/Chats/Data/models/chats_model.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/send_chat.dart';

class MockChatsRepository extends Mock implements ChatsRepository {}

void main() {
  SendChart useCase ;
  MockChatsRepository mockChatsRepository;
  setUp((){
    mockChatsRepository = MockChatsRepository();
    useCase = SendChart(mockChatsRepository);
  });

   final  ChatsModel tchat =  new ChatsModel(
     id: '1',   isLiked: true,text: "testing",time: "12:00 am",unread: false,senderId: 0
   );
     test('Should send the specified conversation from the user and the specified Recepient', 
  () async {
    //stub
    when(mockChatsRepository.sendChat(tchat))
    .thenAnswer((_) async => Right(true));
    //act
    final result = await useCase(Params(tchat));
    //assert
    expect(result,Right(true));
    verify(mockChatsRepository.sendChat(tchat));
    verifyNoMoreInteractions(mockChatsRepository);
  });
}