
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';
import 'package:test_flutter/features/Chats/Domain/entities/chats.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/get_Specific_Chart.dart';

class MockChatsRepository extends Mock implements ChatsRepository {}
void main(){
  GetSpecificChart useCase ;
  MockChatsRepository mockChatsRepository;
  //runs before all tests
  setUp((){
     mockChatsRepository = MockChatsRepository();
     useCase = GetSpecificChart(mockChatsRepository);
  });
  final String tId = '1';
  // final sender = User( id: 1, imageUrl: "assets/images/newyork.jpg",name: "test user");
  final  List<Chats> tCharts = [Chats(id:'1',isLiked: true,text: "hi from test",time: '11:24 am',unread: true,senderId: 0)];
  //actual test
  test('Should get specific chats based on the id passed', () async {
    //create my stubs
  when(mockChatsRepository.getSpecificChats(tId))
    .thenAnswer((_) async => Right(tCharts));
   //act
    final result = await useCase(Params(id: tId));
     //assert
    expect(result,Right(tCharts));
    verify(mockChatsRepository.getSpecificChats(tId));
    verifyNoMoreInteractions(mockChatsRepository);
  });
   
}