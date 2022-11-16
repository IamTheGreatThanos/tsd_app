import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class SaveMoveProductsToCache extends UseCase<String, SaveMoveProductsToCacheParams> {
  final MoveDataRepository _moveDataRepository;

  SaveMoveProductsToCache(this._moveDataRepository);
  @override
  Future<Either<Failure, String>> call(SaveMoveProductsToCacheParams params) {
    return _moveDataRepository.saveMoveProductsToCache(
      products: params.products,
      moveOrderId: params.moveOrderId,
    );
  }
}

class SaveMoveProductsToCacheParams {
  final int moveOrderId;
  final List<ProductDTO> products;

  SaveMoveProductsToCacheParams({
    required this.moveOrderId,
    required this.products,
  });
}
