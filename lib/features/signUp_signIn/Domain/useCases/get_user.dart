import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/core/usecases/usecase.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/entities/Users.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/repositories/SignUp_sigIn_Repository.dart';
import 'package:meta/meta.dart';
class GetUser extends Equatable implements Usecase<User,Noparams> {
  final SignUpSignInRepository repository ;

  GetUser({@required this.repository});

  @override
  Future<Either<Failure, User>> call(Noparams params) async{
        return await repository.getUser();
  }



  
}
