import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';

abstract class WarehouseArrivalRemoteDS {
  Future<List<WarehouseOrderDTO>> getWarehouseArrivalOrders({
    required String accessToken,
    required int page,
    required int status,
    String? searchText,
  });

  Future<List<WarehouseOrderDTO>> getWarehouseArrivalHistory({
    required String accessToken,
  });

  Future<WarehouseOrderDTO> updateWarehouseStatusOfOrder({
    required String accessToken,
    required int orderId,
    required int status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? counteragentId,
  });
}

class WarehouseArrivalRemoteDSImpl extends WarehouseArrivalRemoteDS {
  final Dio dio;
  WarehouseArrivalRemoteDSImpl(this.dio);
  @override
  Future<List<WarehouseOrderDTO>> getWarehouseArrivalOrders({
    required String accessToken,
    required int page,
    required int status,
    String? searchText,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get(
        '$SERVER_/api/arrival-warehouse',
        queryParameters: {
          "page": page.toString(),
          "status": status.toString(),
          if (searchText != null && searchText.isNotEmpty) "number": searchText,
        },
      );
      log('##### getWarehouseArrivalOrders api:: ${response.statusCode}');

      return compute<List, List<WarehouseOrderDTO>>(
        (List list) {
          return list
              .map((e) => WarehouseOrderDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
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
  Future<List<WarehouseOrderDTO>> getWarehouseArrivalHistory({
    required String accessToken,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get('$SERVER_/api/arrival-warehouse/history');
      log('##### getWarehouseArrivalHistory api:: ${response.statusCode}');

      return compute<List, List<WarehouseOrderDTO>>(
        (List list) {
          return list
              .map((e) => WarehouseOrderDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
      );
    } on DioError catch (e) {
      log('##### getWarehouseArrivalHistory api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<WarehouseOrderDTO> updateWarehouseStatusOfOrder(
      {required String accessToken,
      required int orderId,
      required int status,
      String? incomingNumber,
      String? incomingDate,
      String? bin,
      String? invoiceDate,
      int? counteragentId,}) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final FormData formData = FormData.fromMap({
        "id": orderId,
        'status': status,
        if (incomingNumber != null) 'incoming_number': incomingNumber,
        if (incomingDate != null) 'incoming_date': incomingDate,
        if (bin != null) 'bin': bin,
        if (invoiceDate != null) 'invoice_date': invoiceDate,
        if (counteragentId != null) 'counteragent_id': counteragentId,
      });
      final response = await dio.post(
        '$SERVER_/api/arrival-warehouse/newupdate',
        data: formData,
      );

      log("##### updateWarehouseStatusOfOrder api:: ${response.statusCode},${response.data}");
      return WarehouseOrderDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('$e');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
