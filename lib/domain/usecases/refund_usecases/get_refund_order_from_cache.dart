import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';

class GetRefundOrderFromCache extends UseCaseOnly<RefundDataDTO> {
  final RefundRepository _refundRepository;

  GetRefundOrderFromCache(this._refundRepository);
  @override
  Future<Either<Failure, RefundDataDTO>> call() {
    return _refundRepository.getRefundOrderFromCache();
  }
}
