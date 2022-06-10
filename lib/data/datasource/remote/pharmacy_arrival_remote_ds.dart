import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';

abstract class PharmacyArrivalRemoteDS {
  Future<List<PharmacyOrderDTO>> getPharmacyArrivalOrders({
    required String accessToken,
    required int page,
    required int status,
  });

  Future<List<PharmacyOrderDTO>> getPharmacyArrivalHistory({
    required String accessToken,
  });

  Future<ProductDTO> updatePharmacyProductById({
    required String accessToken,
    required int productId,
    String? status,
    int? scanCount,
    int? defective,
    int? surplus,
    int? underachievement,
    int? reSorting,
  });

  Future<PharmacyOrderDTO> updatePharmacyStatusOfOrder({
    required String accessToken,
    required int orderId,
    required int status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? recipientId,
  });

  Future<List<PharmacyOrderDTO>> getOrderByNumber({
    required String accessToken,
    required String number,
    required int status,
  });
}

class PharmacyArrivalRemoteDSImpl extends PharmacyArrivalRemoteDS {
  final Dio dio;

  PharmacyArrivalRemoteDSImpl(this.dio);

  @override
  Future<List<PharmacyOrderDTO>> getPharmacyArrivalOrders({
    required String accessToken,
    required int page,
    required int status,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio
          .get('$SERVER_/api/arrival-pharmacy?page=$page&status=$status');
      log('##### getPharmacyArrivalOrders api:: ${response.statusCode}');

      return compute<List, List<PharmacyOrderDTO>>(
        (List list) {
          return list
              .map((e) => PharmacyOrderDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
      );
    } on DioError catch (e) {
      log('##### getPharmacyArrivalOrders api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<ProductDTO> updatePharmacyProductById({
    required String accessToken,
    required int productId,
    String? status,
    int? scanCount,
    int? defective,
    int? surplus,
    int? underachievement,
    int? reSorting,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio.patch(
        '$SERVER_/api/arrival-pharmacy-product/$productId',
        data: {
          if (status != null) 'status': status,
          if (scanCount != null) 'scan_count': scanCount,
          if (defective != null) 'defective': defective,
          if (surplus != null) 'surplus': surplus,
          if (underachievement != null) 'underachievement': underachievement,
          if (reSorting != null) 're_sorting': reSorting,
        },
      );

      log("##### updatePharmacyProductById api:: ${response.statusCode},${response.data}");
      return ProductDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('$e');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<PharmacyOrderDTO> updatePharmacyStatusOfOrder({
    required String accessToken,
    required int orderId,
    required int status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? recipientId,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio.patch(
        '$SERVER_/api/arrival-pharmacy/$orderId',
        data: {
          'status': status,
          if (incomingNumber != null) 'incoming_number': incomingNumber,
          if (incomingDate != null) 'incoming_date': incomingDate,
          if (bin != null) 'bin': bin,
          if (invoiceDate != null) 'invoice_date': invoiceDate,
          if (recipientId != null) 'recipient_id': recipientId,
        },
      );

      log("##### updatePharmacyStatusOfOrder api:: ${response.statusCode},${response.data}");
      return PharmacyOrderDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('$e');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<List<PharmacyOrderDTO>> getPharmacyArrivalHistory({
    required String accessToken,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get('$SERVER_/api/arrival-pharmacy/history');
      log('##### getPharmacyArrivalHistory api:: ${response.statusCode}');

      return compute<List, List<PharmacyOrderDTO>>(
        (List list) {
          return list
              .map((e) => PharmacyOrderDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
      );
    } on DioError catch (e) {
      log('##### getPharmacyArrivalHistory api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<List<PharmacyOrderDTO>> getOrderByNumber({
    required String accessToken,
    required String number,
    required int status,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio
          .get('$SERVER_/api/arrival-pharmacy?number=$number&status=$status');
      log('##### getOrderByNumber api:: ${response.statusCode}');

      return compute<List, List<PharmacyOrderDTO>>(
        (List list) {
          return list
              .map((e) => PharmacyOrderDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
      );
    } on DioError catch (e) {
      log('##### getOrderByNumber api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
