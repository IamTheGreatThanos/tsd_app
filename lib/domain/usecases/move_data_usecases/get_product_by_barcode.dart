import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class GetProductByBarcode extends UseCase<ProductDTO, String> {
  final MoveDataRepository _moveDataRepository;
  GetProductByBarcode(this._moveDataRepository);

  @override
  Future<Either<Failure, ProductDTO>> call(String params) {
    return _moveDataRepository.getProductByBarcode(barcode: params);
  }
}
