import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/core/util/input_converter.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/clear_conversation.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/delete_specific_chat.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/get_Specific_Chart.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/get_all_charts.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/like_specific_chat.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/send_chat.dart';
import 'package:test_flutter/features/Chats/Presentation/bloc/bloc.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/useCases/get_users.dart';

class MockGetUsers extends Mock implements GetUsers{}
class MockGetAllCharts extends Mock implements GetAllCharts{}
class MockGetSpecificChart extends Mock implements GetSpecificChart {}
class MockClearConversation extends Mock implements ClearConversation {}
class MockDeleteSpecificChat extends Mock implements  DeleteSpecificChat{}
class MockLikeSpecificChat extends Mock implements LikeSpecificChat{}
class MockSendChart extends Mock implements SendChart {}
class MockInputConverter extends Mock implements InputConverter{}

void main(){
  MockGetUsers getUsers;
  MockGetAllCharts getAllCharts;
  MockGetSpecificChart getSpecificChart;
  MockClearConversation clearConversation;
  MockDeleteSpecificChat deleteSpecificChat;
  MockLikeSpecificChat likeSpecificChat;
  MockSendChart sendChart;
  MockInputConverter inputConverter;
  ChatsBloc bloc;

  setUp((){
    getUsers = MockGetUsers();
    getAllCharts = MockGetAllCharts();
    getSpecificChart = MockGetSpecificChart();
    clearConversation = MockClearConversation();
    deleteSpecificChat = MockDeleteSpecificChat();
    likeSpecificChat = MockLikeSpecificChat();
    sendChart = MockSendChart();
    inputConverter = MockInputConverter();
    bloc = ChatsBloc(
    getUsers: getUsers,getAllCharts: getAllCharts,getSpecificChart: getSpecificChart,
    clearConversation: clearConversation,deleteSpecificChat: deleteSpecificChat, 
    likeSpecificChat: likeSpecificChat,sendChart: sendChart,inputConverter: inputConverter
    );
  });

  test('initial state should be empty', () {
    expect(bloc.initialState, equals(Empty()));
  });


}