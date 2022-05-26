// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'counteragent_dto.freezed.dart';
part 'counteragent_dto.g.dart';

@freezed
class CounteragentDTO with _$CounteragentDTO {
  const factory CounteragentDTO({
    required int id,
    String? name,
  }) = _CounteragentDTO;

  factory CounteragentDTO.fromJson(Map<String, dynamic> json) => _$CounteragentDTOFromJson(json);
}
