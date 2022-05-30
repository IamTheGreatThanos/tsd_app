import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';

abstract class PharmacyArrivalRemoteDS {
  Future<List<PharmacyOrderDTO>> getPharmacyArrivalOrders({
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
  });
}

class PharmacyArrivalRemoteDSImpl extends PharmacyArrivalRemoteDS {
  final Dio dio;

  PharmacyArrivalRemoteDSImpl(this.dio);

  @override
  Future<List<PharmacyOrderDTO>> getPharmacyArrivalOrders({
    required String accessToken,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get('$SERVER_/api/arrival-pharmacy');
      log('##### getWarehouseArrivalOrders api:: ${response.statusCode}');

      return compute<List, List<PharmacyOrderDTO>>(
        (List list) {
          return list
              .map((e) => PharmacyOrderDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        response.data as List<dynamic>,
      );
    } on DioError catch (e) {
      log('##### getWarehouseArrivalOrders api error::: ${e.response}, ${e.error}');
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
  Future<PharmacyOrderDTO> updatePharmacyStatusOfOrder(
      {required String accessToken,
      required int orderId,
      required int status}) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio.patch(
        '$SERVER_/api/arrival-pharmacy/$orderId',
        data: {
          'status': status,
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
}
