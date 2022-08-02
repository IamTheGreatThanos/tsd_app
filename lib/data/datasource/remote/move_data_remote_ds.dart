import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';

abstract class MoveDataRemoteDS {
  Future<List<MoveDataDTO>> getMovingOrders({
    required String accessToken,
    int? page,
    int? status,
    int? senderId,
    int? recipientId,
    int? accept,
    int? send,
    String? date,
    int? sortType,
  });

  Future<MoveDataDTO> createMovingOrder({
    required String accessToken,
    int? senderId,
    int? recipientId,
    int? organizationId,
    int? movingType,
  });

  Future<List<ProductDTO>> getProductByBarcode({
    required String accessToken,
    required String barcode,
  });

  Future<List<MoveDataDTO>> getMovingHistory({
    required String accessToken,
  });

  Future<MoveDataDTO> updateMovingOrderStatus({
    required String accessToken,
    required int moveOrderId,
    int? status,
    int? send,
    int? accept,
    String? date,
    String? comment,
  });
}

class MoveDataRemoteDSImpl extends MoveDataRemoteDS {
  final Dio dio;
  MoveDataRemoteDSImpl(this.dio);

  @override
  Future<MoveDataDTO> createMovingOrder({
    required String accessToken,
    int? senderId,
    int? recipientId,
    int? organizationId,
    int? movingType,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio.post(
        '$SERVER_/api/moving',
        data: {
          if (senderId != null) 'sender_id': senderId,
          if (recipientId != null) 'recipient_id': recipientId,
          if (organizationId != null) 'organization_id': organizationId,
          if (movingType != null) 'moving_type': movingType,
        },
      );

      log("##### createMovingOrder api:: ${response.statusCode},${response.data}");
      return MoveDataDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('$e');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<List<ProductDTO>> getProductByBarcode({
    required String accessToken,
    required String barcode,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio.get(
        '$SERVER_/api/product?barcode=$barcode',
      );
      log("##### getProductByBarcode api:: ${response.statusCode},${response.data}");
      return compute<List, List<ProductDTO>>(
        (List list) {
          return list
              .map((e) => ProductDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        response.data as List<dynamic>,
      );
    } on DioError catch (e) {
      log('$e');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<MoveDataDTO> updateMovingOrderStatus({
    required String accessToken,
    required int moveOrderId,
    int? status,
    int? send,
    int? accept,
    String? date,
    String? comment,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio.patch(
        '$SERVER_/api/moving/$moveOrderId',
        data: {
          if (status != null) 'status': status,
          if (send != null) 'send': send,
          if (accept != null) 'accept': accept,
          if (date != null) 'date': date,
          if (comment != null) 'comment': comment,
        },
      );

      log("##### updateMovingOrderStatus api:: ${response.statusCode},${response.data}");
      return MoveDataDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('$e');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<List<MoveDataDTO>> getMovingHistory({
    required String accessToken,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get('$SERVER_/api/moving/history');
      log('##### getMovingHistory api:: ${response.statusCode}');

      return compute<List, List<MoveDataDTO>>(
        (List list) {
          return list
              .map((e) => MoveDataDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
      );
    } on DioError catch (e) {
      log('##### getMovingHistory api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<List<MoveDataDTO>> getMovingOrders({
    required String accessToken,
    int? page,
    int? status,
    int? senderId,
    int? recipientId,
    int? accept,
    int? send,
    String? date,
    int? sortType,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    String sort = "";
    if (sortType == 0) {
      sort = 'created_at_desc';
    } else {
      sort = 'created_at_asc';
    }
    try {
      final response = await dio.get(
        '$SERVER_/api/moving',
        queryParameters: {
          if (page != null) "page": page,
          if (status != null) "status": status,
          if (senderId != null) "sender_id": senderId,
          if (recipientId != null) "recipient_id": recipientId,
          if (senderId != null) "sender_id": senderId,
          if (accept != null) "accept": accept,
          if (send != null) "send": send,
          if (date != null) "date": date,
          if (sortType != null) "sort": sort,
        },
      );
      log('##### getMovingOrders api:: ${response.statusCode}');

      return compute<List, List<MoveDataDTO>>(
        (List list) {
          return list
              .map((e) => MoveDataDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
      );
    } on DioError catch (e) {
      log('##### getMovingOrders api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
