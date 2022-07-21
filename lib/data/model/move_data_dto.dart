// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'move_data_dto.freezed.dart';
part 'move_data_dto.g.dart';

@freezed
class MoveDataDTO with _$MoveDataDTO {
  const factory MoveDataDTO({
    required int id,
    @JsonKey(name: 'sender_id') int? senderId,
    @JsonKey(name: 'recipient_id') int? recipientId,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    int? status,
    String? date,
    String? comment,
    int? send,
    int? accept,
  }) = _MoveDataDTO;

  factory MoveDataDTO.fromJson(Map<String, dynamic> json) =>
      _$MoveDataDTOFromJson(json);
}
