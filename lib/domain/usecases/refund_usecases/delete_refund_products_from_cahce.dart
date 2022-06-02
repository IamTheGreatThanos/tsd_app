import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';

class DeleteRefundProductsFromCache extends UseCaseOnly<String> {
  final RefundRepository refundRepository;

  DeleteRefundProductsFromCache(this.refundRepository);
  @override
  Future<Either<Failure, String>> call() {
    return refundRepository.deleteRefundProductsFromCache();
  }
}
