import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';

class GetProductsRefund extends UseCase<List<ProductDTO>, int> {
  final RefundRepository _refundRepository;
  GetProductsRefund(this._refundRepository);

  @override
  Future<Either<Failure, List<ProductDTO>>> call(int params) {
    return _refundRepository.getProductsRefund(refundOrderId: params);
  }
}
