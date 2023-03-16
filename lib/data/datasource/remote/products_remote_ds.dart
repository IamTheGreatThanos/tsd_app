import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
//TODO Продукты ДС
abstract class ProductsRemoteDS {
  Future<List<ProductDTO>> getProductsPharmacyArrival({
    required String accessToken,
    required int orderId,
    String? search,
  });

  Future<List<ProductDTO>> getProductsMoveData({
    required String accessToken,
    required int moveOrderId,
  });

  Future<List<ProductDTO>> getProductsRefund({
    required String accessToken,
    required int refundOrderId,
  });

  Future<ProductDTO> addMoveDataProduct({
    required String accessToken,
    required int moveOrderId,
    required ProductDTO addingProduct,
  });

  Future<ProductDTO> updateMoveDataProduct({
    required String accessToken,
    required ProductDTO updatingProduct,
  });
  Future<ProductDTO> addRefundDataProduct({
    required String accessToken,
    required int refundOrderId,
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
    String? search,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get(
        '$SERVER_/api/arrival-pharmacy-product/$orderId',
        queryParameters: {
          if (search != null && search.isNotEmpty) "search": search,
        },
      );
      log('##### getProductsPharmacyArrival api:: ${response.statusCode}');

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

  @override
  Future<List<ProductDTO>> getProductsRefund({
    required String accessToken,
    required int refundOrderId,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response =
          await dio.get('$SERVER_/api/refund-product/$refundOrderId');
      log('##### getProductsRefund api:: ${response.statusCode}');

      return compute<List, List<ProductDTO>>(
        (List list) {
          return list
              .map((e) => ProductDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        response.data as List<dynamic>,
      );
    } on DioError catch (e) {
      log('##### getProductsRefund api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<ProductDTO> addRefundDataProduct({
    required String accessToken,
    required int refundOrderId,
    required ProductDTO addingProduct,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.post(
        '$SERVER_/api/refund-product/$refundOrderId',
        data: {
          "name": addingProduct.name,
          "image": addingProduct.image,
          "barcode": addingProduct.barcode,
          "total_count": addingProduct.totalCount,
          "producer": addingProduct.producer,
          "series": addingProduct.series,
        },
      );
      log('##### addRefundDataProduct api:: ${response.statusCode}');

      return ProductDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('##### addRefundDataProduct api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<ProductDTO> updateMoveDataProduct({
    required String accessToken,
    required ProductDTO updatingProduct,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.patch(
        '$SERVER_/api/moving-product/${updatingProduct.id}',
        data: {
          if (updatingProduct.totalCount != null)
            "total_count": updatingProduct.totalCount,
          if (updatingProduct.scanCount != null)
            "scan_count": updatingProduct.scanCount,
          if (updatingProduct.defective != null)
            "defective": updatingProduct.defective,
          if (updatingProduct.surplus != null)
            "surplus": updatingProduct.surplus,
          if (updatingProduct.underachievement != null)
            "underachievement": updatingProduct.underachievement,
          if (updatingProduct.reSorting != null)
            "re_sorting": updatingProduct.reSorting,
          if (updatingProduct.overdue != null)
            "overdue": updatingProduct.overdue,
          if (updatingProduct.netovar != null)
            "netovar": updatingProduct.netovar,
          if (updatingProduct.status != null) "status": updatingProduct.status,
        },
      );
      log('##### updateMoveDataProduct api:: ${response.statusCode}');

      return ProductDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('##### updateMoveDataProduct api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
