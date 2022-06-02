import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';

class UpdateRefundOrderStatus
    extends UseCase<RefundDataDTO, UpdateRefundOrderStatusParams> {
  final RefundRepository _refundRepository;

  UpdateRefundOrderStatus(this._refundRepository);

  @override
  Future<Either<Failure, RefundDataDTO>> call(
    UpdateRefundOrderStatusParams params,
  ) {
    return _refundRepository.updateRefundOrderStatus(
      refundOrderId: params.refundOrderId,
      status: params.status,
    );
  }
}

class UpdateRefundOrderStatusParams {
  final int refundOrderId;
  final int status;

  UpdateRefundOrderStatusParams({
    required this.refundOrderId,
    required this.status,
  });
}
