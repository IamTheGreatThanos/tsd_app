// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'move_data_dto.freezed.dart';
part 'move_data_dto.g.dart';

@freezed
class MoveDataDTO with _$MoveDataDTO {
  const factory MoveDataDTO({
    required int id,
    @JsonKey(name:'sender_id') int? senderId,
    @JsonKey(name: 'recipient_id') int? recipientId,
    @JsonKey(name: 'organization_id') int? organizationId,
    @JsonKey(name: 'moving_type') int? movingType,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    int? status,
    
  }) = _MoveDataDTO;

  factory MoveDataDTO.fromJson(Map<String, dynamic> json) => _$MoveDataDTOFromJson(json);
}
