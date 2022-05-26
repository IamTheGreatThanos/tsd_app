import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_info.dart';
import 'package:pharmacy_arrival/data/datasource/local/auth_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/pharmacy_arrival_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/products_remote_ds.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class PharmacyRepositoryImpl extends PharmacyRepository {
  final PharmacyArrivalRemoteDS arrivalRemoteDS;
  final AuthLocalDS authLocalDS;
  final NetworkInfo networkInfo;
  final ProductsRemoteDS productsRemoteDS;
  PharmacyRepositoryImpl({
    required this.arrivalRemoteDS,
    required this.authLocalDS,
    required this.networkInfo,
    required this.productsRemoteDS,
  });

  @override
  Future<Either<Failure, List<PharmacyOrderDTO>>>
      getPharmacyArrivalOrders() async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<PharmacyOrderDTO> warehouseOrders = await arrivalRemoteDS
            .getPharmacyArrivalOrders(accessToken: user.accessToken!);
        return Right(warehouseOrders);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нету интернета!'));
    }
  }

  @override
  Future<Either<Failure, List<ProductDTO>>> getProductsPharmacyArrival(
      {required int orderId}) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<ProductDTO> products =
            await productsRemoteDS.getProductsPharmacyArrival(
          accessToken: user.accessToken!,
          orderId: orderId,
        );
        return Right(products);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нету интернета!'));
    }
  }
}
