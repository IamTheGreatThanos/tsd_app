import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class SaveMoveProductsToCache extends UseCase<String, List<ProductDTO>> {
  final MoveDataRepository _moveDataRepository;

  SaveMoveProductsToCache(this._moveDataRepository);
  @override
  Future<Either<Failure, String>> call(List<ProductDTO> params) {
    return _moveDataRepository.saveMoveProductsToCache(products: params);
  }
}
