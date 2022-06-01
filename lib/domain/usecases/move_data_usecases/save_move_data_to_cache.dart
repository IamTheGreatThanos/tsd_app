import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class SaveMoveDataToCache extends UseCase<String, MoveDataDTO> {
  final MoveDataRepository _moveDataRepository;

  SaveMoveDataToCache(this._moveDataRepository);
  @override
  Future<Either<Failure, String>> call(MoveDataDTO params) {
    return _moveDataRepository.saveMoveDataToCache(moveDataDTO: params);
  }
}
