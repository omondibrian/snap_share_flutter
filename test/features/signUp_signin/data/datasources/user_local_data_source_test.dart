
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter/core/errors/exceptions.dart';
import 'package:test_flutter/features/signUp_signIn/Data/Models/user_model.dart';
import 'package:test_flutter/features/signUp_signIn/Data/dataSources/user_local_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'package:matcher/matcher.dart';
class MockSharedPreferences extends Mock implements SharedPreferences{}

void main(){
  UserLocalDataSourceImpl dataSource;
  MockSharedPreferences sharedPreferences;
  setUp((){
    sharedPreferences = MockSharedPreferences();
    dataSource = UserLocalDataSourceImpl(sharedPreferences:sharedPreferences);
  });
    final tUser = parseUser(fixture('user.json'));
    final tUsers = parseUsers(fixture('users.json'));
  group('getUser', () {
    test('should return user data if it exist\'s in the cache', ()async {
      
      //arrange
      when(sharedPreferences.getString(any))
      .thenReturn(fixture('user.json'));
      //act
      final result  = await dataSource.getUser();
      //assert
      verify(sharedPreferences.getString('USER_INFO'));
      expect(result, tUser);
    });
    test('should throw CACHEDEXCEPTION  if user data does not exist\'s in the cache', ()async {
      
      //arrange
      when(sharedPreferences.getString(any))
      .thenReturn(null);
      //act
      final call  = dataSource.getUser;
      //assert

      expect(()=>call(), throwsA(TypeMatcher<CacheException>()));
    });
  });


 group('getUsers', () {
    test('should return user data if it exist\'s in the cache', ()async {
      
      //arrange
      when(sharedPreferences.getString(any))
      .thenReturn(fixture('users.json'));
      //act
      final result  = await dataSource.getUsers();
      //assert
      verify(sharedPreferences.getString('USERS_INFO'));
      expect(result, tUsers);
    });
    test('should throw CACHEDEXCEPTION  if user data does not exist\'s in the cache', ()async {
      
      //arrange
      when(sharedPreferences.getString(any))
      .thenReturn(null);
      //act
      final call  = dataSource.getUsers;
      //assert

      expect(()=>call(), throwsA(TypeMatcher<CacheException>()));
    });
  });
  group('cacheUser', () {
    final user = UserModel(id: '0',name: 'test user',imageUrl: 'assets/images/gondola.jpg');
    test('should call shared preferences to cache the data', () {
      //act
      dataSource.cacheUser(user);
      //assert
      final expectedJsonString = jsonEncode(user);
      verify(sharedPreferences.setString('USER_INFO', expectedJsonString));
    });
  });


  group('cacheUsers', () {
    final user = UserModel(id: '0',name: 'test user',imageUrl: 'assets/images/gondola.jpg');
    final List<UserModel> usersToCache = [user,user,user];
    test('should call shared preferences to cache the data', () {
      //act
      dataSource.cacheUsers(usersToCache);
      //assert
      final expectedJsonString = jsonEncode(usersToCache);
      verify(sharedPreferences.setString('USERS_INFO', expectedJsonString));
    });
  });
}