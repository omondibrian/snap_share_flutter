
import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/errors/exceptions.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/core/network/network_info.dart';
import 'package:test_flutter/features/Chats/Data/dataSources/chats_local_data_source.dart';
import 'package:test_flutter/features/Chats/Data/dataSources/chats_remote_data_source.dart';
import 'package:test_flutter/features/Chats/Data/models/chats_model.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';
import 'package:test_flutter/features/Chats/Domain/entities/chats.dart';
import 'package:meta/meta.dart';
class ChatsRepositoryimpl implements ChatsRepository{
  final ChatsRemoteDataSource remoteDataSource;
  final ChatsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ChatsRepositoryimpl({
    @required this.remoteDataSource, 
    @required this.localDataSource, 
    @required this.networkInfo
    });
  @override
  Future<Either<Failure, bool>> clearConversation(String id) async {
      if( await networkInfo.isConnected){
      try {
        final isConversationCleared = await remoteDataSource.clearConversation(id);
        await localDataSource.clearSpecificConversation(id);
        return Right( isConversationCleared);     
      } on ServerException{
        return Left(ServerFailure());
      }
    }else{
     try{
     final cachedChats = await localDataSource.clearSpecificConversation(id);
     return Right(cachedChats);
     }on CacheException{
       return Left(CacheFailure());
     }
   }
  }

  @override
  Future<Either<Failure, bool>> deleteSpecificChat(String id) async{ 
   
    
    if( await networkInfo.isConnected){
      try {
        final isDeleted = await remoteDataSource.deleteSpecificChat(id);
        return Right( isDeleted);     
      } on ServerException{
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, List<Chats>>> getAllChats() async{
 if( await networkInfo.isConnected){
      try {
        final chatsToCache = await remoteDataSource.getAllChats();
        localDataSource.cacheCharts(chatsToCache);
        return Right( chatsToCache);     
      } on ServerException{
        return Left(ServerFailure());
      }
   }else{
     try{
     final cachedChats = await localDataSource.getAllCachedChats();
     return Right(cachedChats);
     }on CacheException{
       return Left(CacheFailure());
     }
   }
  }

  @override
  Future<Either<Failure, List<Chats>>> getSpecificChats(String id) async{
    if( await networkInfo.isConnected){
      try {
        final chatsToCache = await remoteDataSource.getSpecificChats(id);
        return Right( chatsToCache);     
      } on ServerException{
        return Left(ServerFailure());
      }
   }else{
     try{
     final cachedChats = await localDataSource.getSpecificChatsFromCache(id);
     return Right(cachedChats);
     }on CacheException{
       return Left(CacheFailure());
     }
   }
    
  }

  @override
  Future<Either<Failure, bool>> likeSpecificChat(String id)async {

    if (await networkInfo.isConnected ){
      try{
      final result = await remoteDataSource.likeSpecificChat(id);
      return Right(result);
      }on ServerException{
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
    
    }
  

  @override
  Future<Either<Failure, bool>> markChatAsRead(String id) async{

    if(await networkInfo.isConnected){
      try{
          final result =  await remoteDataSource.markChatAsRead(id);
        return Right(result);
      }on ServerException{
        return Left(ServerFailure());
      } 
  }
   return Left(ServerFailure());
  }
  @override
  
  List get props => null;

  @override
  Future<Either<Failure, bool>> sendChat(ChatsModel chat) async{
 if(await networkInfo.isConnected){
      try{
          final result =  await remoteDataSource.sendChat(chat);
        return Right(result);
      }on ServerException{
        return Left(ServerFailure());
      } 
  }
   return Left(ServerFailure());
  }


  }
