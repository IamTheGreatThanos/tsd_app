import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class AddMoveDataProduct extends UseCase<ProductDTO, AddMoveDataProductParams> {
  final MoveDataRepository _moveDataRepository;

  AddMoveDataProduct(this._moveDataRepository);
  @override
  Future<Either<Failure, ProductDTO>> call(AddMoveDataProductParams params) {
    return _moveDataRepository.addMoveDataProduct(
      moveOrderId: params.moveOrderId,
      addingProduct: params.addingProduct,
    );
  }
}

class AddMoveDataProductParams {
  final int moveOrderId;
  final ProductDTO addingProduct;

  AddMoveDataProductParams(this.moveOrderId, this.addingProduct);
}
