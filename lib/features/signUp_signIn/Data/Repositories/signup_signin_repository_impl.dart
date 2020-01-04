import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/errors/exceptions.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/core/network/network_info.dart';
import 'package:test_flutter/features/signUp_signIn/Data/dataSources/user_local_data_source.dart';
import 'package:test_flutter/features/signUp_signIn/Data/dataSources/user_remote_data_source.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/entities/Users.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/repositories/SignUp_sigIn_Repository.dart';
import 'package:meta/meta.dart';
class UserRepository implements SignUpSignInRepository{
  final UserRemoteDataSource remoteDataSource;
  final  UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
 
  UserRepository({@required this.remoteDataSource, @required this.localDataSource, @required this.networkInfo});
  @override
  Future<Either<Failure, User>> getUser()async {
  if( await networkInfo.isConnected){
      try {
        final user = await remoteDataSource.getUser();
        await localDataSource.getUser();
        return Right( user);     
      } on ServerException{
        return Left(ServerFailure());
      }
    }else{
     try{
     final cachedUser = await localDataSource.getUser();
     return Right(cachedUser);
     }on CacheException{
       return Left(CacheFailure());
     }
   }
  }

  @override
  Future<Either<Failure, List<User>>> getUsers(List<String> userIds) async{
if( await networkInfo.isConnected){
      try {
        final users = await remoteDataSource.getUsers(userIds);
        await localDataSource.getUsers();
        return Right( users);     
      } on ServerException{
        return Left(ServerFailure());
      }
    }else{
     try{
     final cachedUser = await localDataSource.getUsers();
     return Right(cachedUser);
     }on CacheException{
       return Left(CacheFailure());
     }
   }
  }

  @override
  List get props => null;

  @override
  Future<Either<Failure, Auth>> signUp() {
    // TODO: implement signUp
    return null;
  }

}