import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/core/usecases/usecase.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/entities/Users.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/repositories/SignUp_sigIn_Repository.dart';
import 'package:meta/meta.dart';
class GetUsers implements Usecase<List<User>,Params> {
  final SignUpSignInRepository repository;

  GetUsers({@required this.repository});
  @override
  Future<Either<Failure, List<User>>> call(Params params) async{
    
    return await repository.getUsers(params.userIds);
  }
  
}

class Params extends Equatable{
  final List<String> userIds;

  Params(this.userIds);

  @override
  List<Object> get props => [userIds];
}