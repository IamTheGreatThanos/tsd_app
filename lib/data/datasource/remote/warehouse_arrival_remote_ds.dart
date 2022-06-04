import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';

abstract class WarehouseArrivalRemoteDS {
  Future<List<WarehouseOrderDTO>> getWarehouseArrivalOrders({
    required String accessToken,
  });

    Future<List<WarehouseOrderDTO>> getWarehouseArrivalHistory({
    required String accessToken,
  });

}

class WarehouseArrivalRemoteDSImpl extends WarehouseArrivalRemoteDS {
  final Dio dio;
  WarehouseArrivalRemoteDSImpl(this.dio);
  @override
  Future<List<WarehouseOrderDTO>> getWarehouseArrivalOrders({
    required String accessToken,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get('$SERVER_/api/arrival-warehouse');
      log('##### getWarehouseArrivalOrders api:: ${response.statusCode}');

      return compute<List, List<WarehouseOrderDTO>>(
        (List list) {   
          return list
              .map((e) => WarehouseOrderDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        response.data as List<dynamic> ,
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
  Future<List<WarehouseOrderDTO>> getWarehouseArrivalHistory({required String accessToken}) async {
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
        response.data as List<dynamic>,
      );
    } on DioError catch (e) {
      log('##### getWarehouseArrivalHistory api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
