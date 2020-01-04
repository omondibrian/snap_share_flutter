
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/core/usecases/usecase.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/entities/Users.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/repositories/SignUp_sigIn_Repository.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/useCases/get_user.dart';

class MockSignUpSignInRepository extends Mock implements SignUpSignInRepository{}
void main(){
  GetUser usecase;

  MockSignUpSignInRepository repository;
  setUp((){
    repository = MockSignUpSignInRepository();
    usecase = GetUser(repository:repository);
  });
   final User tUser = User(id:'0',name:"test user",imageUrl:"assets/images/gondola.jpg");
  test('Should return the current loged in user', () async {
    //arrange
    when(repository.getUser()).thenAnswer((_)async=> Right(tUser));
    //act
    final result =  await usecase(Noparams());
    //assert
    expect(result, Right(tUser));
  });

}