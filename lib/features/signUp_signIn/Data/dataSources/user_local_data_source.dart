import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter/core/errors/exceptions.dart';
import 'package:test_flutter/features/signUp_signIn/Data/Models/user_model.dart';
import 'package:meta/meta.dart';
abstract class UserLocalDataSource {
  ///fetch user details from the cache memory throws a [CacheException]if not found
  Future<UserModel> getUser();
    ///fetch users details from the cache memory throws a [CacheException]if not found
  Future<List<UserModel>> getUsers();
    ///caches user details to the cache memory 
  Future<void> cacheUser(UserModel userToCache);
      ///caches user details to the cache memory 
  Future<void> cacheUsers(List<UserModel> userToCache);
}
const USER_INFO = 'USER_INFO';
const USERS_INFO = 'USERS_INFO';
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

UserLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<UserModel> getUser() {
   final jsonString = sharedPreferences.getString(USER_INFO);
   if(jsonString != null){
    return Future.value(parseUser(jsonString));
   }else{
     throw CacheException();
   }
  }

  @override
  Future<List<UserModel>> getUsers() {
   final jsonString = sharedPreferences.getString(USERS_INFO);
   if(jsonString != null){
    return Future.value(parseUsers(jsonString));
   }else{
     throw CacheException();
   }
  }

  @override
  Future<void> cacheUser(UserModel userToCache) {
    return sharedPreferences.setString(USER_INFO,jsonEncode(userToCache.toJson()));
    
  }

  @override
  Future<void> cacheUsers(List<UserModel> userToCache) {
    List users = userToCache.map((user){
        return user.toJson();
    }).toList();
     return sharedPreferences.setString(USERS_INFO,jsonEncode(users));
 
  }
  
}