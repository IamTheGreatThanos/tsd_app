import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';

class SaveRefundProductsToCache extends UseCase<String, List<ProductDTO>> {
  final RefundRepository _refundRepository;

  SaveRefundProductsToCache(this._refundRepository);
  @override
  Future<Either<Failure, String>> call(List<ProductDTO> params) {
    return _refundRepository.saveRefundProductsToCache(products: params);
  }
}
