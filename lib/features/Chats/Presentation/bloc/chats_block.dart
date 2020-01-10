
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:test_flutter/core/util/input_converter.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/clear_conversation.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/delete_specific_chat.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/get_Specific_Chart.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/get_all_charts.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/like_specific_chat.dart';
import 'package:test_flutter/features/Chats/Domain/usecases/send_chat.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/useCases/get_users.dart';
import 'bloc.dart';
import 'package:meta/meta.dart';
class ChatsBloc extends Bloc<ChatsEvents,ChatsState>{
  final GetAllCharts getAllCharts;
  final GetSpecificChart getSpecificChart;
  final ClearConversation clearConversation;
  final DeleteSpecificChat deleteSpecificChat;
  final LikeSpecificChat likeSpecificChat;
  final SendChart sendChart;
  final InputConverter inputConverter;
  final GetUsers getUsers;
  ChatsBloc({   @required this.getAllCharts,      @required this.getSpecificChart, 
              @required this.clearConversation, @required this.deleteSpecificChat,
            @required this.likeSpecificChat, @required this.sendChart ,
          @required this.inputConverter,  @required this.getUsers
            })
            :assert(getAllCharts != null),
             assert(getSpecificChart != null),
             assert(clearConversation != null),
             assert(deleteSpecificChat != null),
             assert(likeSpecificChat != null),
             assert(sendChart != null),
             assert(inputConverter != null);

  @override
  ChatsState get initialState => Empty();

  @override
  Stream<ChatsState> mapEventToState(ChatsEvents event) {
    // TODO: implement mapEventToState
    return null;
  }
}