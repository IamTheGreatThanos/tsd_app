import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';

abstract class ProductsRemoteDS {
  Future<List<ProductDTO>> getProductsPharmacyArrival({
    required String accessToken,
    required int orderId,
  });
}

class ProductsRemoteDSImpl extends ProductsRemoteDS {
  final Dio dio;

  ProductsRemoteDSImpl(this.dio);

  @override
  Future<List<ProductDTO>> getProductsPharmacyArrival({
    required String accessToken,
    required int orderId,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response =
          await dio.get('$SERVER_/api/arrival-pharmacy-product/$orderId');
      log('##### getProductsPharmacyArrival api:: ${response.statusCode}');

      return compute<List, List<ProductDTO>>(
        (List list) {
          return list
              .map((e) => ProductDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        response.data as List<dynamic>,
      );
    } on DioError catch (e) {
      log('##### getProductsPharmacyArrival api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
