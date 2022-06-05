import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/auth_repository.dart';

class GetOrganizations extends UseCaseOnly<List<CounteragentDTO>> {
  final AuthRepository _authRepository;
  GetOrganizations(this._authRepository);
  @override
  Future<Either<Failure, List<CounteragentDTO>>> call() {
    return _authRepository.getOrganizations();
  }
}
