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
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      status: json['status'] as int?,
      date: json['date'] as String?,
      comment: json['comment'] as String?,
      send: json['send'] as int?,
      accept: json['accept'] as int?,
    );

Map<String, dynamic> _$$_MoveDataDTOToJson(_$_MoveDataDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'recipient_id': instance.recipientId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'status': instance.status,
      'date': instance.date,
      'comment': instance.comment,
      'send': instance.send,
      'accept': instance.accept,
    };
