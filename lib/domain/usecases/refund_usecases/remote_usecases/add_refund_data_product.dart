import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';

class AddRefundDataProduct
    extends UseCase<ProductDTO, AddRefundDataProductParams> {
  final RefundRepository _refundRepository;

  AddRefundDataProduct(this._refundRepository);
  @override
  Future<Either<Failure, ProductDTO>> call(AddRefundDataProductParams params) {
    return _refundRepository.addRefundDataProduct(
      refundOrderId: params.refundOrderId,
      addingProduct: params.addingProduct,
    );
  }
}

class AddRefundDataProductParams {
  final int refundOrderId;
  final ProductDTO addingProduct;

  AddRefundDataProductParams(this.refundOrderId, this.addingProduct);
}
