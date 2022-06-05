import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';

class GetRefundHistory extends UseCaseOnly<List<RefundDataDTO>> {
  final RefundRepository _refundRepository;

  GetRefundHistory(this._refundRepository);
  @override
  Future<Either<Failure, List<RefundDataDTO>>> call() {
    return _refundRepository.getRefundHistory();
  }
}
