import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class GetPharmacySelectedProduct extends UseCase<ProductDTO,int> {
  final PharmacyRepository _pharmacyRepository;

  GetPharmacySelectedProduct(this._pharmacyRepository);

  @override
  Future<Either<Failure, ProductDTO>> call(int param) async {
    return _pharmacyRepository.getPharmacySelectedProductFromCahce(orderId: param);
  }
}
