import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class GetOrdersBySearch extends UseCase<List<PharmacyOrderDTO>, String> {
  final PharmacyRepository _pharmacyRepository;
  GetOrdersBySearch(this._pharmacyRepository);
  @override
  Future<Either<Failure, List<PharmacyOrderDTO>>> call(String params) {
    return _pharmacyRepository.getOrdersBySearch(number: params);
  }
}
