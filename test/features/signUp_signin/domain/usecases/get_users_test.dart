import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:test_flutter/features/signUp_signIn/Domain/entities/Users.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/repositories/SignUp_sigIn_Repository.dart';

import 'package:test_flutter/features/signUp_signIn/Domain/useCases/get_users.dart';

class MockSignUpSignInRepository extends Mock implements SignUpSignInRepository{}
void main(){
  GetUsers usecase;

  MockSignUpSignInRepository repository;
  setUp((){
    repository = MockSignUpSignInRepository();
    usecase = GetUsers(repository:repository);
  });
   final User tUser = User(id:'0',name:"test user",imageUrl:"assets/images/gondola.jpg");
   final List<User> users = [tUser,tUser];
  test('Should return the current loged in user', () async {
    //arrange
    when(repository.getUsers(any)).thenAnswer((_)async => Right(users));
    //act
    final result =  await usecase(Params(['1','2']));
    //assert
    expect(result, Right(users));
  });

}