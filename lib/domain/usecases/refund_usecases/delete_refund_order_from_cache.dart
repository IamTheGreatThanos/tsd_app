import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';

class DeleteRefundOrderFromCache extends UseCaseOnly<String> {
  final RefundRepository _refundRepository;
  DeleteRefundOrderFromCache(this._refundRepository);

  @override
  Future<Either<Failure, String>> call() {
    return _refundRepository.deleteRefundOrderFromCache();
  }
}
