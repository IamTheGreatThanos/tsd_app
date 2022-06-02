import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';

class CreateRefundOrder
    extends UseCase<RefundDataDTO, CreateRefundOrderParams> {
  final RefundRepository _refundRepository;

  CreateRefundOrder(this._refundRepository);

  @override
  Future<Either<Failure, RefundDataDTO>> call(CreateRefundOrderParams params) {
    return _refundRepository.createRefundOrder(
      counteragentId: params.counteragentId,
      fromCounteragentId: params.fromCounteragentId,
      organizationId: params.organizationId,
    );
  }
}

class CreateRefundOrderParams {
  final int counteragentId;
  final int fromCounteragentId;
  final int organizationId;

  CreateRefundOrderParams(
    this.counteragentId,
    this.fromCounteragentId,
    this.organizationId,
  );
}
