import 'package:test_flutter/core/errors/exceptions.dart';
import 'package:test_flutter/features/signUp_signIn/Data/Models/user_model.dart';
import 'package:http/http.dart' as Http;
import 'package:meta/meta.dart';
abstract class UserRemoteDataSource {
  ///fetch user details from the cache memory throws a [CacheException]if not found
  Future<UserModel> getUser();
    ///fetch's a list of users details to the cache memory 
  Future<List<UserModel>> getUsers(List<String> userIds);
  
}




class UserRemoteDataSourceImpl implements UserRemoteDataSource{
  final Http.Client  httpClient;

  UserRemoteDataSourceImpl({@required this.httpClient});
  @override
  Future<UserModel> getUser()async {
     String token = 'vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
       final response = await httpClient.get("http://localhost:4000/api/user",
      headers: {
        'AUTH_TOKEN':token
      },
    
      );
      if(response.statusCode == 200){
        return parseUser(response.body);
      }else{
        throw ServerException();
      }
  }
  

  @override
  Future<List<UserModel>> getUsers(List<String> userIds) async{
     String token = 'vbjgoigkgnfj.kgndklgjgnttit.gjkgknn';
       final response = await httpClient.get("http://localhost:4000/api/user/$userIds",
      headers: {
        'AUTH_TOKEN':token
      },
    
      );
      if(response.statusCode == 200){
        return parseUsers(response.body);
      }else{
        throw ServerException();
      }
  }
}