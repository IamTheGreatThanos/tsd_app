import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';

abstract class AcceptContainersRemoteDs {
  Future<List<ProductDTO>> getContaiersByAng({
    required String accessToken,
    required String number,
  });

  Future<ProductDTO> updateContainer({
    required String accessToken,
    required String name,
    required int status,
  });
}

class AcceptContainersRemoteDsImpl extends AcceptContainersRemoteDs {
  final Dio dio;

  AcceptContainersRemoteDsImpl(this.dio);

  @override
  Future<List<ProductDTO>> getContaiersByAng({
    required String accessToken,
    required String number,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.post(
        '$SERVER_/api/arrival-pharmacy/getcontainerbyang',
        data: {
          "number": number,
        },
      );
      log('##### getContainersByAng api:: ${response.statusCode}');

      return compute<List, List<ProductDTO>>(
        (List list) {
          return list
              .map((e) => ProductDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        response.data as List,
      );

      // final List<ProductDTO> prods = response.data

      // return prods.map((e) => e.copyWith(orderID: orderId)).toList();
    } on DioError catch (e) {
      log('##### getContainersByAng api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<ProductDTO> updateContainer({
    required String accessToken,
    required String name,
    required int status,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.post(
        '$SERVER_/api/arrival-pharmacy/setcontainer',
        data: {"name": name, "status": status},
      );
      log('##### updateContainer api:: ${response.statusCode}');

      return ProductDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('##### updateContainer api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
