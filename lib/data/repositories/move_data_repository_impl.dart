import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/platform/network_info.dart';
import 'package:pharmacy_arrival/data/datasource/local/auth_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/local/move_data_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/move_data_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/products_remote_ds.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

class MoveDataRepositoryImpl extends MoveDataRepository {
  final AuthLocalDS authLocalDS;
  final MoveDataRemoteDS _moveDataRemoteDS;
  final MoveDataLocalDS _moveDataLocalDS;
  final ProductsRemoteDS _productsRemoteDS;
  final NetworkInfo networkInfo;
  MoveDataRepositoryImpl(
    this._moveDataLocalDS,
    this._moveDataRemoteDS,
    this.networkInfo,
    this.authLocalDS,
    this._productsRemoteDS,
  );
  @override
  Future<Either<Failure, String>> deleteMoveDataFromCache() async {
    try {
      await _moveDataLocalDS.deleteMoveDataFromCache();
      return const Right("Deleted Move Data From Cache Successfully");
    } on CacheException {
      return Left(CacheFailure(message: 'Delete Move Data failed from cahce'));
    }
  }

  @override
  Future<Either<Failure, MoveDataDTO>> getMoveDataFromCache() async {
    try {
      final MoveDataDTO result = await _moveDataLocalDS.getMoveDataFromCache();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure(message: 'Запрашиваемый объект нет в кэше'));
    }
  }

  @override
  Future<Either<Failure, String>> saveMoveDataToCache({
    required MoveDataDTO moveDataDTO,
  }) async {
    try {
      await _moveDataLocalDS.saveMoveDataToCache(
        moveDataDTO: moveDataDTO,
      );
      return const Right('MoveData Order Succesfully saved to cache');
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteMoveProductsFromCache() async {
    try {
      await _moveDataLocalDS.deleteMoveProductsFromCache();
      return const Right("Deleted Move Products From Cache Successfully");
    } on CacheException {
      return Left(
        CacheFailure(message: 'Delete Move Products failed from cahce'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductDTO>>> getMoveProductsFromCache() async {
    try {
      final List<ProductDTO> result =
          await _moveDataLocalDS.getMoveProductsFromCache();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure(message: 'Запрашиваемый продукты нет в кэше'));
    }
  }

  @override
  Future<Either<Failure, String>> saveMoveProductsToCache({
    required List<ProductDTO> products,
  }) async {
    try {
      await _moveDataLocalDS.saveMoveProductsToCache(products: products);
      return const Right('MoveData Products Succesfully saved to cache');
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MoveDataDTO>> createMovingOrder({
    int? senderId,
    int? recipientId,
    int? organizationId,
    int? movingType,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final MoveDataDTO moveDataDTO =
            await _moveDataRemoteDS.createMovingOrder(
          accessToken: user.accessToken!,
          senderId: senderId,
          recipientId: recipientId,
          organizationId: organizationId,
          movingType: movingType,
        );
        return Right(moveDataDTO);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, List<ProductDTO>>> getProductsMoveData({
    required int moveOrderId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<ProductDTO> products =
            await _productsRemoteDS.getProductsMoveData(
          accessToken: user.accessToken!,
          moveOrderId: moveOrderId,
        );
        return Right(products);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, ProductDTO>> addMoveDataProduct({
    required int moveOrderId,
    required ProductDTO addingProduct,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final ProductDTO product = await _productsRemoteDS.addMoveDataProduct(
          accessToken: user.accessToken!,
          moveOrderId: moveOrderId,
          addingProduct: addingProduct,
        );
        return Right(product);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, ProductDTO>> getProductByBarcode({
    required String barcode,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<ProductDTO> products =
            await _moveDataRemoteDS.getProductByBarcode(
          accessToken: user.accessToken!,
          barcode: barcode,
        );
        if (products.isEmpty) {
          return Left(
            ServerFailure(
              message: 'Нет такого товара из поступления в аптеку',
            ),
          );
        } else {
          return Right(products.first);
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, MoveDataDTO>> updateMovingOrderStatus({
    required int moveOrderId,
    required int status,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final MoveDataDTO moveDataDTO =
            await _moveDataRemoteDS.updateMovingOrderStatus(
          accessToken: user.accessToken!,
          moveOrderId: moveOrderId,
          status: status,
        );
        return Right(moveDataDTO);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, List<MoveDataDTO>>> getMovingHistory() async {
    if (await networkInfo.isConnected) {
      final User user = await authLocalDS.getUserFromCache();
      final List<MoveDataDTO> history = await _moveDataRemoteDS
          .getMovingHistory(accessToken: user.accessToken!);
      return Right(history);
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }
}
