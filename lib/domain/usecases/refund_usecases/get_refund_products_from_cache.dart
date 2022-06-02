import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';

class GetRefundProductsFromCache extends UseCaseOnly<List<ProductDTO>> {
  final RefundRepository _refundRepository;
  GetRefundProductsFromCache(this._refundRepository);

  @override
  Future<Either<Failure, List<ProductDTO>>> call() {
    return _refundRepository.getRefundProductsFromCache();
  }
}
