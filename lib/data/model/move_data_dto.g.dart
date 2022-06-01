// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoveDataDTO _$$_MoveDataDTOFromJson(Map<String, dynamic> json) =>
    _$_MoveDataDTO(
      id: json['id'] as int,
      senderId: json['sender_id'] as int?,
      recipientId: json['recipient_id'] as int?,
      organizationId: json['organization_id'] as int?,
      movingType: json['moving_type'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$_MoveDataDTOToJson(_$_MoveDataDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'recipient_id': instance.recipientId,
      'organization_id': instance.organizationId,
      'moving_type': instance.movingType,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
