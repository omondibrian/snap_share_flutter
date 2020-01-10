
import 'dart:convert'as json;

import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/features/signUp_signIn/Data/Models/user_model.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/entities/Users.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  final tUserModel = UserModel(
      id:'0',name:"test user",imageUrl: "assets/images/gondola.jpg"
  );
  test('Should be a sub-class of user-entity', ()async {
    expect(tUserModel, isA<User>());
  });
 group('from json function', (){
     test('Should return a valid model when passed in the json file', () async{
       final Map<String,dynamic> jsonMap = json.jsonDecode(fixture('user.json'));
       final result = UserModel.fromJson(jsonMap);
       expect(result, equals(tUserModel));
     });
  });
  group('toJson', (){
  final  tUserModel = UserModel(
      id:'0',name:"test user",imageUrl: "assets/images/gondola.jpg"
  );
  test('should return a JSON map containing the proper data',(){
      // final tuser = parseUser(fixture('user.json'));
        //arrange 
        final expectedMap = {
                "id": '0',
                "imageUrl": "assets/images/gondola.jpg",
                "name": "test user"
        };
        //act
        final result = tUserModel.toJson();
        //assert
        expect(result,expectedMap);
      
  });
});
group('parseUsers',(){
test('should return valid json', () {

  //act
  final parsed = fixture('users.json');          
  //assert
  expect(parseUsers(parsed).first,tUserModel);
});

});
group('parseUser',(){
  test('should return a valid chatModel', () {
    // arrange
    final tUser ='''{ 
                "id": "0",
                "imageUrl": "assets/images/gondola.jpg",
                "name": "test user"
    }''';
    //assert
    expect(parseUser(tUser).id,'0');
  });
});
}