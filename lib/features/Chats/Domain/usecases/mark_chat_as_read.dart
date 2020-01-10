
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/core/usecases/usecase.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';

class MarkChatAsRead implements Usecase<bool,Params> {
  final ChatsRepository repository;

  MarkChatAsRead(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) {
   
    return repository.markChatAsRead(params.id);
  }
}
class Params extends Equatable {
  final String id;

  Params(this.id):super();

  @override
  List<Object> get props => [id];
}