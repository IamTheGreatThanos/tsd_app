import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/platform/network_info.dart';
import 'package:pharmacy_arrival/data/datasource/local/auth_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/local/refund_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/products_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/refund_remote_ds.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/domain/repositories/refund_repository.dart';
//TODO Репо для возврата
class RefundRepositoryImpl extends RefundRepository {
  final AuthLocalDS authLocalDS;
  final RefundLocalDS refundLocalDS;
  final RefundRemoteDS refundRemoteDS;
  final ProductsRemoteDS productsRemoteDS;
  final NetworkInfo networkInfo;

  RefundRepositoryImpl(
    this.authLocalDS,
    this.refundLocalDS,
    this.refundRemoteDS,
    this.productsRemoteDS,
    this.networkInfo,
  );
  @override
  Future<Either<Failure, RefundDataDTO>> createRefundOrder({
    required int counteragentId,
    required int fromCounteragentId,
    required int organizationId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final RefundDataDTO refundDataDTO =
            await refundRemoteDS.createRefundOrder(
          accessToken: user.accessToken!,
          counteragentId: counteragentId,
          fromCounteragentId: fromCounteragentId,
          organizationId: organizationId,
        );
        return Right(refundDataDTO);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteRefundOrderFromCache() async {
    try {
      await refundLocalDS.deleteRefundOrderFromCache();
      return const Right("Deleted Refund Order From Cache Successfully");
    } on CacheException {
      return Left(
        CacheFailure(message: 'Delete Reduns Order failed from cahce'),
      );
    }
  }

  @override
  Future<Either<Failure, RefundDataDTO>> getRefundOrderFromCache() async {
    try {
      final RefundDataDTO result =
          await refundLocalDS.getRefundOrderFromCache();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure(message: 'Запрашиваемый объект нет в кэше'));
    }
  }

  @override
  Future<Either<Failure, String>> saveRefundOrderToCache({
    required RefundDataDTO refundDataDTO,
  }) async {
    try {
      await refundLocalDS.saveRefundOrderToCache(
        refundDataDTO: refundDataDTO,
      );
      return const Right('Refund Order Succesfully saved to cache');
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteRefundProductsFromCache() async {
    try {
      await refundLocalDS.deleteRefundProductsFromCache();
      return const Right(
        "Deleted RefundOrder Products From Cache Successfully",
      );
    } on CacheException {
      return Left(
        CacheFailure(message: 'Delete RefundOrder Products failed from cahce'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductDTO>>> getRefundProductsFromCache() async {
    try {
      final List<ProductDTO> result =
          await refundLocalDS.getRefundProductsFromCache();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure(message: 'Запрашиваемый продукты нет в кэше'));
    }
  }

  @override
  Future<Either<Failure, String>> saveRefundProductsToCache({
    required List<ProductDTO> products,
  }) async {
    try {
      await refundLocalDS.saveRefundProductsToCache(products: products);
      return const Right('RefundOrder Products Succesfully saved to cache');
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductDTO>>> getProductsRefund({
    required int refundOrderId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<ProductDTO> products =
            await productsRemoteDS.getProductsRefund(
          accessToken: user.accessToken!,
          refundOrderId: refundOrderId,
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
  Future<Either<Failure, ProductDTO>> addRefundDataProduct({
    required int refundOrderId,
    required ProductDTO addingProduct,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final ProductDTO product = await productsRemoteDS.addRefundDataProduct(
          accessToken: user.accessToken!,
          refundOrderId: refundOrderId,
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
  Future<Either<Failure, RefundDataDTO>> updateRefundOrderStatus({
    required int refundOrderId,
    required int status,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final RefundDataDTO moveDataDTO =
            await refundRemoteDS.updateRefundOrderStatus(
          accessToken: user.accessToken!,
          refundOrderId: refundOrderId,
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
  Future<Either<Failure, List<RefundDataDTO>>> getRefundHistory() async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final history = await refundRemoteDS.getRefundHistory(
          accessToken: user.accessToken!,
        );
        return Right(history);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }
}
