// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refund_data_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RefundDataDTO _$RefundDataDTOFromJson(Map<String, dynamic> json) {
  return _RefundDataDTO.fromJson(json);
}

/// @nodoc
mixin _$RefundDataDTO {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id')
  int? get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_counteragent_id')
  int? get fromCounteragentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'organization_id')
  int? get organizationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'counteragent_id')
  int? get counteragentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RefundDataDTOCopyWith<RefundDataDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefundDataDTOCopyWith<$Res> {
  factory $RefundDataDTOCopyWith(
          RefundDataDTO value, $Res Function(RefundDataDTO) then) =
      _$RefundDataDTOCopyWithImpl<$Res, RefundDataDTO>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'sender_id') int? senderId,
      @JsonKey(name: 'from_counteragent_id') int? fromCounteragentId,
      @JsonKey(name: 'organization_id') int? organizationId,
      @JsonKey(name: 'counteragent_id') int? counteragentId,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      int? status});
}

/// @nodoc
class _$RefundDataDTOCopyWithImpl<$Res, $Val extends RefundDataDTO>
    implements $RefundDataDTOCopyWith<$Res> {
  _$RefundDataDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = freezed,
    Object? fromCounteragentId = freezed,
    Object? organizationId = freezed,
    Object? counteragentId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      fromCounteragentId: freezed == fromCounteragentId
          ? _value.fromCounteragentId
          : fromCounteragentId // ignore: cast_nullable_to_non_nullable
              as int?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as int?,
      counteragentId: freezed == counteragentId
          ? _value.counteragentId
          : counteragentId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RefundDataDTOCopyWith<$Res>
    implements $RefundDataDTOCopyWith<$Res> {
  factory _$$_RefundDataDTOCopyWith(
          _$_RefundDataDTO value, $Res Function(_$_RefundDataDTO) then) =
      __$$_RefundDataDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'sender_id') int? senderId,
      @JsonKey(name: 'from_counteragent_id') int? fromCounteragentId,
      @JsonKey(name: 'organization_id') int? organizationId,
      @JsonKey(name: 'counteragent_id') int? counteragentId,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      int? status});
}

/// @nodoc
class __$$_RefundDataDTOCopyWithImpl<$Res>
    extends _$RefundDataDTOCopyWithImpl<$Res, _$_RefundDataDTO>
    implements _$$_RefundDataDTOCopyWith<$Res> {
  __$$_RefundDataDTOCopyWithImpl(
      _$_RefundDataDTO _value, $Res Function(_$_RefundDataDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = freezed,
    Object? fromCounteragentId = freezed,
    Object? organizationId = freezed,
    Object? counteragentId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_RefundDataDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      fromCounteragentId: freezed == fromCounteragentId
          ? _value.fromCounteragentId
          : fromCounteragentId // ignore: cast_nullable_to_non_nullable
              as int?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as int?,
      counteragentId: freezed == counteragentId
          ? _value.counteragentId
          : counteragentId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RefundDataDTO implements _RefundDataDTO {
  const _$_RefundDataDTO(
      {required this.id,
      @JsonKey(name: 'sender_id') this.senderId,
      @JsonKey(name: 'from_counteragent_id') this.fromCounteragentId,
      @JsonKey(name: 'organization_id') this.organizationId,
      @JsonKey(name: 'counteragent_id') this.counteragentId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.status});

  factory _$_RefundDataDTO.fromJson(Map<String, dynamic> json) =>
      _$$_RefundDataDTOFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'sender_id')
  final int? senderId;
  @override
  @JsonKey(name: 'from_counteragent_id')
  final int? fromCounteragentId;
  @override
  @JsonKey(name: 'organization_id')
  final int? organizationId;
  @override
  @JsonKey(name: 'counteragent_id')
  final int? counteragentId;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  final int? status;

  @override
  String toString() {
    return 'RefundDataDTO(id: $id, senderId: $senderId, fromCounteragentId: $fromCounteragentId, organizationId: $organizationId, counteragentId: $counteragentId, createdAt: $createdAt, updatedAt: $updatedAt, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RefundDataDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.fromCounteragentId, fromCounteragentId) ||
                other.fromCounteragentId == fromCounteragentId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.counteragentId, counteragentId) ||
                other.counteragentId == counteragentId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, senderId, fromCounteragentId,
      organizationId, counteragentId, createdAt, updatedAt, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RefundDataDTOCopyWith<_$_RefundDataDTO> get copyWith =>
      __$$_RefundDataDTOCopyWithImpl<_$_RefundDataDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RefundDataDTOToJson(
      this,
    );
  }
}

abstract class _RefundDataDTO implements RefundDataDTO {
  const factory _RefundDataDTO(
      {required final int id,
      @JsonKey(name: 'sender_id') final int? senderId,
      @JsonKey(name: 'from_counteragent_id') final int? fromCounteragentId,
      @JsonKey(name: 'organization_id') final int? organizationId,
      @JsonKey(name: 'counteragent_id') final int? counteragentId,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final int? status}) = _$_RefundDataDTO;

  factory _RefundDataDTO.fromJson(Map<String, dynamic> json) =
      _$_RefundDataDTO.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'sender_id')
  int? get senderId;
  @override
  @JsonKey(name: 'from_counteragent_id')
  int? get fromCounteragentId;
  @override
  @JsonKey(name: 'organization_id')
  int? get organizationId;
  @override
  @JsonKey(name: 'counteragent_id')
  int? get counteragentId;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  int? get status;
  @override
  @JsonKey(ignore: true)
  _$$_RefundDataDTOCopyWith<_$_RefundDataDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
