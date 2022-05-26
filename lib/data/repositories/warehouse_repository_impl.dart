import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/platform/network_info.dart';
import 'package:pharmacy_arrival/data/datasource/local/auth_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/warehouse_arrival_remote_ds.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/warehouse_repository.dart';

class WarehouseRepositoryImpl extends WarehouseRepository {
  final WarehouseArrivalRemoteDS warehouseArrivalRemoteDS;
  final AuthLocalDS authLocalDS;
  final NetworkInfo networkInfo;
  WarehouseRepositoryImpl({
    required this.authLocalDS,
    required this.networkInfo,
    required this.warehouseArrivalRemoteDS,
  });
  @override
  Future<Either<Failure, List<WarehouseOrderDTO>>>
      getWarehouseArrivalOrders() async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<WarehouseOrderDTO> warehouseOrders =
            await warehouseArrivalRemoteDS.getWarehouseArrivalOrders(
                accessToken: user.accessToken!);
        return Right(warehouseOrders);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нету интернета!'));
    }
  }
}
