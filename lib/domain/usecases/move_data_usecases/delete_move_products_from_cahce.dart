import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class DeleteMoveProductsFromCache extends UseCaseOnly<String> {
  final MoveDataRepository _moveDataRepository;

  DeleteMoveProductsFromCache(this._moveDataRepository);
  @override
  Future<Either<Failure, String>> call() {
    return _moveDataRepository.deleteMoveProductsFromCache();
  }
}
