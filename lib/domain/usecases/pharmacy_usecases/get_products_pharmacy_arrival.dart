import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class GetProductsPharmacyArrival extends UseCase<List<ProductDTO>, int> {
  final PharmacyRepository _pharmacyRepository;
  GetProductsPharmacyArrival(
    this._pharmacyRepository,
  );
  @override
  Future<Either<Failure, List<ProductDTO>>> call(int params) {
    return _pharmacyRepository.getProductsPharmacyArrival(orderId: params);
  }
}
