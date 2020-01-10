
import 'dart:convert' as json;

import 'package:test_flutter/features/signUp_signIn/Domain/entities/Users.dart';
import 'package:meta/meta.dart';
class UserModel extends User {
  UserModel({
    @required String id,
    @required String imageUrl, 
    @required String name,
  }):super(id:id,imageUrl:imageUrl,name:name);
    factory UserModel.fromJson(Map<String,dynamic> json){
        return UserModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
    );
  }

    Map<String,dynamic> toJson(){
    return {
        'id':id,
        'imageUrl':imageUrl,
        'name':name,
    };
  }


}

///parse a json list and return a   List<UserModel> 
  List<UserModel> parseUsers(String jsonString){
    final parsed = json.jsonDecode(jsonString);
    final userList = parsed.map((parsedUser){    
       final user = UserModel.fromJson(parsedUser);
       return user;
    });
    final userModelList = List<UserModel> .from(userList);
    return userModelList;
  }


  ///parse a json object and return UserModel
  UserModel parseUser(String jsonString){
    final parsed = json.jsonDecode(jsonString);
    UserModel userModel = UserModel.fromJson(parsed);
    return userModel;
  }