import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/features/Chats/Data/models/chats_model.dart';

class InputConverter{
  Either<Failure,ChatsModel> stringToModel(String text){
    if(text.isNotEmpty){
    final chat = ChatsModel(
      id: '1',
      text: text,
      senderId: 0,
      time: '12:00 am',
      isLiked:false,
      unread: true
    );
    return Right(chat);
    }else{
      return Left(InvalidInputFailure());
    }
  }
}
class InvalidInputFailure extends Failure{
  @override
  // TODO: implement props
  List<Object> get props => null;
}