import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/core/usecases/usecase.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/features/Chats/Domain/entities/chats.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/get_all_charts.dart';

class MockChatsRepository extends Mock implements ChatsRepository {}

void main() {
  GetAllCharts useCase ;
  MockChatsRepository mockChatsRepository;
  setUp((){
    mockChatsRepository = MockChatsRepository();
    useCase = GetAllCharts(mockChatsRepository);
  });

   
  //  final sender = User( id: 1, imageUrl: "assets/images/newyork.jpg",name: "test user");
    final  List<Chats> tCharts = [Chats(id:'1',isLiked: true,text: "hi from test",time: '11:24 am',unread: true,senderId: 0)];
  test('Should get all user charts ', 
  () async {
    //stub
    when(mockChatsRepository.getAllChats())
    .thenAnswer((_) async => Right(tCharts));
    //act
    final result = await useCase(Noparams());
    //assert
    expect(result,Right(tCharts));
    verify(mockChatsRepository.getAllChats());
    verifyNoMoreInteractions(mockChatsRepository);
  });
}