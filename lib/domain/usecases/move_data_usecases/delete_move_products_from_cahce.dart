import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class DeleteMoveProductsFromCache extends UseCase<String,int> {
  final MoveDataRepository _moveDataRepository;

  DeleteMoveProductsFromCache(this._moveDataRepository);
  @override
  Future<Either<Failure, String>> call(int params) {
    return _moveDataRepository.deleteMoveProductsFromCache(moveOrderId: params);
  }
}
