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

  Future<List<ProductDTO>> getProductsMoveData({
    required String accessToken,
    required int moveOrderId,
  });

  Future<ProductDTO> addMoveDataProduct({
    required String accessToken,
    required int moveOrderId,
    required ProductDTO addingProduct,
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

  @override
  Future<List<ProductDTO>> getProductsMoveData({
    required String accessToken,
    required int moveOrderId,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response =
          await dio.get('$SERVER_/api/moving-product/$moveOrderId');
      log('##### getProductsMoveData api:: ${response.statusCode}');

      return compute<List, List<ProductDTO>>(
        (List list) {
          return list
              .map((e) => ProductDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        response.data as List<dynamic>,
      );
    } on DioError catch (e) {
      log('##### getProductsMoveData api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<ProductDTO> addMoveDataProduct({
    required String accessToken,
    required ProductDTO addingProduct,
    required int moveOrderId,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.post(
        '$SERVER_/api/moving-product/$moveOrderId',
        data: {
          "name": addingProduct.name,
          "image": addingProduct.image,
          "barcode": addingProduct.barcode,
          "total_count": addingProduct.totalCount,
          "producer": addingProduct.producer,
          "series": addingProduct.series,
        },
      );
      log('##### addMoveDataProduct api:: ${response.statusCode}');

      return ProductDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('##### addMoveDataProduct api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
