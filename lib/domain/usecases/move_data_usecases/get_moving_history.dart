import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class GetMovingHistory extends UseCaseOnly<List<MoveDataDTO>> {
  final MoveDataRepository _moveDataRepository;

  GetMovingHistory(this._moveDataRepository);

  @override
  Future<Either<Failure, List<MoveDataDTO>>> call() {
    return _moveDataRepository.getMovingHistory();
  }
}
