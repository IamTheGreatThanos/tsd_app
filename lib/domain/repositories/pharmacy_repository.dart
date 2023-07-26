import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';

abstract class PharmacyRepository {
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
  });

  Future<Either<Failure, List<PharmacyOrderDTO>>> getPharmacyArrivalHistory({
    String? number,
    int? senderId,
    int? recipientId,
    int? refundStatus,
    int? page,
  });

  Future<Either<Failure, List<PharmacyOrderDTO>>> getRefundOrderByIncoming({
    String? incomingNumber,
    String? incomingDate,
  });

  Future<Either<Failure, List<ProductDTO>>> getProductsPharmacyArrival({
    required int orderId,
    String? search,
  });

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
  });

  Future<Either<Failure, ProductDTO>> getPharmacySelectedProductFromCahce({
    required int orderId,
  });

  Future<Either<Failure, String>> savePharmacySelectedProductToCahce({
    required ProductDTO selectedProduct,
  });

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
  });

  Future<Either<Failure, String>> sendSignature({
    required int orderId,
    required File signature,
  });

  Future<Either<Failure, PharmacyOrderDTO>> getOrderByNumber({
    required String number,
  });

  Future<Either<Failure, List<PharmacyOrderDTO>>> getOrdersBySearch({
    required String number,
    required int status,
  });
}
