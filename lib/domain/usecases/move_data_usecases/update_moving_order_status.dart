import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class UpdateMovingOrderStatus
    extends UseCase<MoveDataDTO, UpdateMovingOrderStatusParams> {
  final MoveDataRepository _moveDataRepository;

  UpdateMovingOrderStatus(this._moveDataRepository);

  @override
  Future<Either<Failure, MoveDataDTO>> call(
    UpdateMovingOrderStatusParams params,
  ) {
    return _moveDataRepository.updateMovingOrderStatus(
      moveOrderId: params.moveOrderId,
      status: params.status,
      send: params.send,
      accept: params.accept,
      date: params.date,
      comment: params.comment,
    );
  }
}

class UpdateMovingOrderStatusParams {
  final int moveOrderId;
  final int? status;
  final int? send;
  final int? accept;
  final String? date;
  final String? comment;

  UpdateMovingOrderStatusParams({
    required this.moveOrderId,
    this.status,
    this.send,
    this.accept,
    this.date,
    this.comment,
  });
}
