import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';

abstract class PharmacyArrivalRemoteDS {
  Future<List<PharmacyOrderDTO>> getPharmacyArrivalOrders({
    required String accessToken,
  });
}

class PharmacyArrivalRemoteDSImpl extends PharmacyArrivalRemoteDS {
  final Dio dio;

  PharmacyArrivalRemoteDSImpl(this.dio);

  @override
  Future<List<PharmacyOrderDTO>> getPharmacyArrivalOrders(
      {required String accessToken}) async {
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
}
