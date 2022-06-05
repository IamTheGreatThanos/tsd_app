import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class SavePharmacySelectedProduct extends UseCase<String, ProductDTO> {
  final PharmacyRepository _pharmacyRepository;
  SavePharmacySelectedProduct(this._pharmacyRepository);

  @override
  Future<Either<Failure, String>> call(ProductDTO params) async {
    return _pharmacyRepository.savePharmacySelectedProductToCahce(
      selectedProduct: params,
    );
  }
}
