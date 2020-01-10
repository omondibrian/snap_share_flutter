import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/core/usecases/usecase.dart';
import 'package:test_flutter/features/Chats/Data/models/chats_model.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';

class SendChart implements Usecase<bool,Params> {
  final ChatsRepository repository ;

  SendChart(this.repository);

 
  @override
  Future<Either<Failure, bool>> call(Params params) async{
    return await repository.sendChat(params.chat);
  }
  
}
class Params extends Equatable {
  final ChatsModel chat;

  Params(this.chat);
  @override
  List<Object> get props => [chat];

}