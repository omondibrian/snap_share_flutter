
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/entities/Users.dart';

abstract class SignUpSignInRepository extends Equatable {
  ///creates a new user account
  Future<Either<Failure,Auth>> signUp();
  ///fetchs the user's data
  Future<Either<Failure,User>> getUser();
  ///fetchs a list of user's
  Future<Either<Failure,List<User>>> getUsers(List<String> userIds);
}
