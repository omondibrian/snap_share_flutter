import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/core/usecases/usecase.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';

class DeleteSpecificChat implements Usecase<bool,Params> {
  final ChatsRepository repository;

  DeleteSpecificChat(this.repository);
  @override
  Future<Either<Failure, bool>> call( Params params) async {
    return await repository.deleteSpecificChat(params.id);
  }
  
}
class Params extends Equatable{
  final String id;

  Params(this.id);

  @override
  List<Object> get props => [id];
}