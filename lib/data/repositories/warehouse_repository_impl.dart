import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/platform/network_info.dart';
import 'package:pharmacy_arrival/data/datasource/local/auth_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/warehouse_arrival_remote_ds.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/warehouse_repository.dart';
//TODO Репо для приход на склад
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
  Future<Either<Failure, List<WarehouseOrderDTO>>> getWarehouseArrivalOrders({
    required int page,
    required int status,
    String? searchText,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<WarehouseOrderDTO> warehouseOrders =
            await warehouseArrivalRemoteDS.getWarehouseArrivalOrders(
          accessToken: user.accessToken!,
          page: page,
          status: status,
          searchText: searchText,
        );
        return Right(warehouseOrders);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, List<WarehouseOrderDTO>>>
      getWarehouseArrivalHistory() async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<WarehouseOrderDTO> historyOrders =
            await warehouseArrivalRemoteDS.getWarehouseArrivalHistory(
          accessToken: user.accessToken!,
        );
        return Right(historyOrders);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, WarehouseOrderDTO>> updateWarehouseStatusOfOrder({
    required int orderId,
    required int status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? counteragentId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final WarehouseOrderDTO order =
            await warehouseArrivalRemoteDS.updateWarehouseStatusOfOrder(
          accessToken: user.accessToken!,
          orderId: orderId,
          status: status,
          incomingNumber: incomingNumber,
          incomingDate: incomingDate,
          bin: bin,
          invoiceDate: invoiceDate,
          counteragentId: counteragentId,
        );
        return Right(order);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }
}
