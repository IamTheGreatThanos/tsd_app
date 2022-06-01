import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';

abstract class MoveDataRemoteDS {
  Future<MoveDataDTO> createMovingOrder({
    required String accessToken,
    required int senderId,
    required int recipientId,
    required int organizationId,
    required int movingType,
  });
}

class MoveDataRemoteDSImpl extends MoveDataRemoteDS {
  final Dio dio;
  MoveDataRemoteDSImpl(this.dio);

  @override
  Future<MoveDataDTO> createMovingOrder({
    required String accessToken,
    required int senderId,
    required int recipientId,
    required int organizationId,
    required int movingType,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio.post(
        '$SERVER_/api/moving',
        data: {
          'sender_id': senderId,
          'recipient_id': recipientId,
          'organization_id': organizationId,
          'moving_type': movingType,
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
}
