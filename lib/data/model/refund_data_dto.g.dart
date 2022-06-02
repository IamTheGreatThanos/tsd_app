// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RefundDataDTO _$$_RefundDataDTOFromJson(Map<String, dynamic> json) =>
    _$_RefundDataDTO(
      id: json['id'] as int,
      senderId: json['sender_id'] as int?,
      fromCounteragentId: json['from_counteragent_id'] as int?,
      organizationId: json['organization_id'] as int?,
      counteragentId: json['counteragent_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$$_RefundDataDTOToJson(_$_RefundDataDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'from_counteragent_id': instance.fromCounteragentId,
      'organization_id': instance.organizationId,
      'counteragent_id': instance.counteragentId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'status': instance.status,
    };
