import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';

abstract class RefundRemoteDS {
  Future<RefundDataDTO> createRefundOrder({
    required String accessToken,
    required int counteragentId,
    required int fromCounteragentId,
    required int organizationId,
  });

  Future<RefundDataDTO> updateRefundOrderStatus({
    required String accessToken,
    required int refundOrderId,
    required int status,
  });

  Future<List<RefundDataDTO>> getRefundHistory({
    required String accessToken,
  });
}

class RefundRemoteDSImpl extends RefundRemoteDS {
  final Dio dio;

  RefundRemoteDSImpl(this.dio);

  @override
  Future<RefundDataDTO> createRefundOrder(
      {required String accessToken,
      required int counteragentId,
      required int fromCounteragentId,
      required int organizationId,}) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio.post(
        '$SERVER_/api/refund',
        data: {
          'counteragent_id': counteragentId,
          'from_counteragent_id': fromCounteragentId,
          'organization_id': organizationId,
        },
      );

      log("##### createRefundOrder api:: ${response.statusCode},${response.data}");
      return RefundDataDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('$e');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<RefundDataDTO> updateRefundOrderStatus(
      {required String accessToken,
      required int refundOrderId,
      required int status,}) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio.patch(
        '$SERVER_/api/refund/$refundOrderId',
        data: {
          'status': status,
        },
      );

      log("##### updateMovingOrderStatus api:: ${response.statusCode},${response.data}");
      return RefundDataDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('$e');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<List<RefundDataDTO>> getRefundHistory(
      {required String accessToken,}) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get('$SERVER_/api/refund/history');
      log('##### getRefundHistory api:: ${response.statusCode}');

      return compute<List, List<RefundDataDTO>>(
        (List list) {
          return list
              .map((e) => RefundDataDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
      );
    } on DioError catch (e) {
      log('##### getRefundHistory api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
