import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/platform/network_info.dart';
import 'package:pharmacy_arrival/data/datasource/local/auth_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/local/products_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/pharmacy_arrival_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/products_remote_ds.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

//TODO Репо для приход аптека
class PharmacyRepositoryImpl extends PharmacyRepository {
  final PharmacyArrivalRemoteDS arrivalRemoteDS;
  final AuthLocalDS authLocalDS;
  final NetworkInfo networkInfo;
  final ProductsRemoteDS productsRemoteDS;
  final ProductsLocalDS productsLoacalDS;
  PharmacyRepositoryImpl({
    required this.arrivalRemoteDS,
    required this.authLocalDS,
    required this.networkInfo,
    required this.productsRemoteDS,
    required this.productsLoacalDS,
  });

  @override
  Future<Either<Failure, List<PharmacyOrderDTO>>> getPharmacyArrivalOrders({
    required int page,
    required int status,
    String? incomingDate,
    String? incomingNumber,
    int? refundStatus,
    String? number,
    int? senderId,
    String? departureDate,
    int? sortType,
    String? amountStart,
    String? amountEnd,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<PharmacyOrderDTO> warehouseOrders =
            await arrivalRemoteDS.getPharmacyArrivalOrders(
          number: number,
          refundStatus: refundStatus,
          incomingDate: incomingDate,
          incomingNumber: incomingNumber,
          accessToken: user.accessToken!,
          page: page,
          status: status,
          senderId: senderId,
          departureDate: departureDate,
          sortType: sortType,
          amountEnd: amountEnd,
          amountStart: amountStart,
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
  Future<Either<Failure, List<ProductDTO>>> getProductsPharmacyArrival({
    required int orderId,
    String? search,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<ProductDTO> products =
            await productsRemoteDS.getProductsPharmacyArrival(
          accessToken: user.accessToken!,
          orderId: orderId,
          search: search,
        );
        final List<ProductDTO> newProduct =
            products.map((e) => e.copyWith(orderID: orderId)).toList();

        return Right(newProduct);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, ProductDTO>> updatePharmacyProductById({
    required int productId,
    String? status,
    double? scanCount,
    int? defective,
    int? surplus,
    int? underachievement,
    int? reSorting,
    int? overdue,
    int? netovar,
    int? refund,
    int? srok,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final ProductDTO product =
            await arrivalRemoteDS.updatePharmacyProductById(
          accessToken: user.accessToken!,
          productId: productId,
          status: status,
          scanCount: scanCount,
          defective: defective,
          surplus: surplus,
          underachievement: underachievement,
          reSorting: reSorting,
          overdue: overdue,
          netovar: netovar,
          refund: refund,
          srok: srok,
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
  Future<Either<Failure, ProductDTO>> getPharmacySelectedProductFromCahce({
    required int orderId,
  }) async {
    try {
      final ProductDTO selectedProduct = await productsLoacalDS
          .getPharmacySelectedProductFromCahce(orderId: orderId);
      return Right(selectedProduct);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> savePharmacySelectedProductToCahce({
    required ProductDTO selectedProduct,
  }) async {
    try {
      await productsLoacalDS.setPharmacySelectedProductToCahce(
        selectedProduct: selectedProduct,
      );
      return const Right('Selected Product Succesfully saved to cache');
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, PharmacyOrderDTO>> updatePharmacyStatusOfOrder({
    required int orderId,
    int? status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? recipientId,
    File? signature,
    int? totalStatus,
    int? refundStatus,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final PharmacyOrderDTO order =
            await arrivalRemoteDS.updatePharmacyStatusOfOrder(
          accessToken: user.accessToken!,
          orderId: orderId,
          status: status,
          incomingNumber: incomingNumber,
          incomingDate: incomingDate,
          bin: bin,
          invoiceDate: invoiceDate,
          recipientId: recipientId,
          signature: signature,
          totalStatus: totalStatus,
          refundStatus: refundStatus,
        );
        return Right(order);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, List<PharmacyOrderDTO>>> getPharmacyArrivalHistory({
    String? number,
    int? senderId,
    int? recipientId,
    int? refundStatus,
    int? page,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<PharmacyOrderDTO> historyOrders =
            await arrivalRemoteDS.getPharmacyArrivalHistory(
          accessToken: user.accessToken!,
          number: number,
          senderId: senderId,
          recipientId: recipientId,
          refundStatus: refundStatus,
          page: page,
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
  Future<Either<Failure, PharmacyOrderDTO>> getOrderByNumber({
    required String number,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<PharmacyOrderDTO> numberOrders =
            await arrivalRemoteDS.getOrderByNumber(
          accessToken: user.accessToken!,
          number: number,
          status: 1,
        );
        if (numberOrders.isEmpty) {
          return Left(
            ServerFailure(message: 'Нету такого заказа в поступлений!'),
          );
        } else {
          if (numberOrders.first.status == 2) {
            return Left(
              ServerFailure(message: 'Данный заказ уже активен!'),
            );
          } else if (numberOrders.first.status == 3) {
            return Left(
              ServerFailure(message: 'Данный заказ уже завершенный!'),
            );
          } else {
            return Right(numberOrders.first);
          }
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, List<PharmacyOrderDTO>>> getOrdersBySearch({
    required String number,
    required int status,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<PharmacyOrderDTO> numberOrders =
            await arrivalRemoteDS.getOrderByNumber(
          accessToken: user.accessToken!,
          number: number,
          status: status,
        );

        return Right(numberOrders);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, String>> sendSignature({
    required int orderId,
    required File signature,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final String result = await arrivalRemoteDS.sendSignature(
          accessToken: user.accessToken!,
          orderId: orderId,
          signature: signature,
        );

        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, List<PharmacyOrderDTO>>> getRefundOrderByIncoming({
    String? incomingNumber,
    String? incomingDate,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await authLocalDS.getUserFromCache();
        final List<PharmacyOrderDTO> historyOrders =
            await arrivalRemoteDS.getRefundOrderByIncoming(
          accessToken: user.accessToken!,
          incomingDate: incomingDate,
          incomingNumber: incomingNumber,
        );
        final List<PharmacyOrderDTO> orders = [];
        for (final PharmacyOrderDTO order in historyOrders) {
          if (order.status == 3) {
            orders.add(order);
          }
        }
        if (orders.isEmpty) {
          return Left(ServerFailure(message: 'Нет такого заказа!'));
        } else {
          if (orders.first.refundStatus != 0) {
            return Left(
                ServerFailure(message: 'Для этого заказа возврат уже создан!'));
          } else {
            return Right(orders);
          }
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }
}
