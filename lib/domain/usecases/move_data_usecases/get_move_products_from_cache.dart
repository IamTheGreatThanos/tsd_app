import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class GetMoveProductsFromCache extends UseCaseOnly<List<ProductDTO>> {
  final MoveDataRepository _moveDataRepository;
  GetMoveProductsFromCache(this._moveDataRepository);

  @override
  Future<Either<Failure, List<ProductDTO>>> call() {
    return _moveDataRepository.getMoveProductsFromCache();
  }
}
