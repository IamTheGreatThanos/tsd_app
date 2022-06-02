// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'refund_data_dto.freezed.dart';
part 'refund_data_dto.g.dart';

@freezed
class RefundDataDTO with _$RefundDataDTO {
  const factory RefundDataDTO({
    required int id,
    @JsonKey(name:'sender_id') int? senderId,
    @JsonKey(name: 'from_counteragent_id') int? fromCounteragentId,
    @JsonKey(name: 'organization_id') int? organizationId,
    @JsonKey(name: 'counteragent_id') int? counteragentId,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    int? status,
    
  }) = _RefundDataDTO;

  factory RefundDataDTO.fromJson(Map<String, dynamic> json) => _$RefundDataDTOFromJson(json);
}
