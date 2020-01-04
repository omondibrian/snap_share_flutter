 
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/core/usecases/usecase.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';
import 'package:test_flutter/features/Chats/Domain/entities/chats.dart';
import 'package:meta/meta.dart';

 /*
  *@fileOverView get specific chart usecase that provides the presentation layer with 
  *charts data between the current user and the specified contact
  *@author Brian Omondi Awuor email:OmondiBrian392@gmail.com
  */
class GetSpecificChart implements Usecase<List<Chats>,Params> {
   final ChatsRepository repository ;

  GetSpecificChart(this.repository);
  @override
  Future<Either<Failure,List<Chats>>> call(Params params)async {
    return await repository.getSpecificChats(params.id);
  }
   
 }

 class Params extends Equatable {
   final String id;

  Params({ @required this.id}):super([id]);
   
 }