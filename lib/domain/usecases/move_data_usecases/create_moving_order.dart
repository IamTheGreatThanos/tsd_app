import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class CreateMovingOrder extends UseCase<MoveDataDTO, CreateMovingOrderParams> {
  final MoveDataRepository _moveDataRepository;

  CreateMovingOrder(this._moveDataRepository);

  @override
  Future<Either<Failure, MoveDataDTO>> call(CreateMovingOrderParams params) {
    return _moveDataRepository.createMovingOrder(
      senderId: params.senderId,
      recipientId: params.recipientId,
      organizationId: params.organizationId,
      movingType: params.movingType,
    );
  }
}

class CreateMovingOrderParams {
  final int? senderId;
  final int? recipientId;
  final int? organizationId;
  final int? movingType;

  CreateMovingOrderParams({
    this.senderId,
    this.recipientId,
    this.organizationId,
    this.movingType,
  });
}
