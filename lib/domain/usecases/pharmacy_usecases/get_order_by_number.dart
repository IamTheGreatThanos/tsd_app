import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class GetOrderByNumber extends UseCase<PharmacyOrderDTO, String> {
  final PharmacyRepository _pharmacyRepository;
  GetOrderByNumber(this._pharmacyRepository);

  @override
  Future<Either<Failure, PharmacyOrderDTO>> call(String params) {
    return _pharmacyRepository.getOrderByNumber(number: params);
  }
}
