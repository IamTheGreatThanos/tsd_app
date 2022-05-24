import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseOnly<Type> {
  Future<Either<Failure, Type>> call();
}
