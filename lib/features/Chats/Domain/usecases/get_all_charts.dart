import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/errors/failures.dart';
import 'package:test_flutter/core/usecases/usecase.dart';
import 'package:test_flutter/features/Chats/Domain/Repository/chats_repository.dart';
import 'package:test_flutter/features/Chats/Domain/entities/chats.dart';

 /*
  *@fileOverView get all chart usecase that provides the presentation layer with all charts data
  *@author Brian Omondi Awuor email:OmondiBrian392@gmail.com
  */
class GetAllCharts implements Usecase<List<Chats>,Noparams>{
  final ChatsRepository repository ;

  GetAllCharts(this.repository);

  @override
  Future<Either<Failure, List<Chats>>> call(Noparams params)  async{
    
    return await repository.getAllChats();
  } 
}
