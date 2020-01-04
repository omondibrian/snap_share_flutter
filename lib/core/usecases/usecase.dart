import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter/core/errors/failures.dart';

abstract class Usecase<Type,Params> {
  Future<Either<Failure,Type>> call(Params params);
}
class Noparams extends Equatable{}