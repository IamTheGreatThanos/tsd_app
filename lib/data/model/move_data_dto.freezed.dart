// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'move_data_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoveDataDTO _$MoveDataDTOFromJson(Map<String, dynamic> json) {
  return _MoveDataDTO.fromJson(json);
}

/// @nodoc
mixin _$MoveDataDTO {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id')
  int? get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'recipient_id')
  int? get recipientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'organization_id')
  int? get organizationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'moving_type')
  int? get movingType => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoveDataDTOCopyWith<MoveDataDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoveDataDTOCopyWith<$Res> {
  factory $MoveDataDTOCopyWith(
          MoveDataDTO value, $Res Function(MoveDataDTO) then) =
      _$MoveDataDTOCopyWithImpl<$Res>;
  $Res call(
      {int id,
      @JsonKey(name: 'sender_id') int? senderId,
      @JsonKey(name: 'recipient_id') int? recipientId,
      @JsonKey(name: 'organization_id') int? organizationId,
      @JsonKey(name: 'moving_type') int? movingType,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$MoveDataDTOCopyWithImpl<$Res> implements $MoveDataDTOCopyWith<$Res> {
  _$MoveDataDTOCopyWithImpl(this._value, this._then);

  final MoveDataDTO _value;
  // ignore: unused_field
  final $Res Function(MoveDataDTO) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? senderId = freezed,
    Object? recipientId = freezed,
    Object? organizationId = freezed,
    Object? movingType = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      senderId: senderId == freezed
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      recipientId: recipientId == freezed
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as int?,
      organizationId: organizationId == freezed
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as int?,
      movingType: movingType == freezed
          ? _value.movingType
          : movingType // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_MoveDataDTOCopyWith<$Res>
    implements $MoveDataDTOCopyWith<$Res> {
  factory _$$_MoveDataDTOCopyWith(
          _$_MoveDataDTO value, $Res Function(_$_MoveDataDTO) then) =
      __$$_MoveDataDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      @JsonKey(name: 'sender_id') int? senderId,
      @JsonKey(name: 'recipient_id') int? recipientId,
      @JsonKey(name: 'organization_id') int? organizationId,
      @JsonKey(name: 'moving_type') int? movingType,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$_MoveDataDTOCopyWithImpl<$Res> extends _$MoveDataDTOCopyWithImpl<$Res>
    implements _$$_MoveDataDTOCopyWith<$Res> {
  __$$_MoveDataDTOCopyWithImpl(
      _$_MoveDataDTO _value, $Res Function(_$_MoveDataDTO) _then)
      : super(_value, (v) => _then(v as _$_MoveDataDTO));

  @override
  _$_MoveDataDTO get _value => super._value as _$_MoveDataDTO;

  @override
  $Res call({
    Object? id = freezed,
    Object? senderId = freezed,
    Object? recipientId = freezed,
    Object? organizationId = freezed,
    Object? movingType = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_MoveDataDTO(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      senderId: senderId == freezed
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      recipientId: recipientId == freezed
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as int?,
      organizationId: organizationId == freezed
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as int?,
      movingType: movingType == freezed
          ? _value.movingType
          : movingType // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoveDataDTO implements _MoveDataDTO {
  const _$_MoveDataDTO(
      {required this.id,
      @JsonKey(name: 'sender_id') this.senderId,
      @JsonKey(name: 'recipient_id') this.recipientId,
      @JsonKey(name: 'organization_id') this.organizationId,
      @JsonKey(name: 'moving_type') this.movingType,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$_MoveDataDTO.fromJson(Map<String, dynamic> json) =>
      _$$_MoveDataDTOFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'sender_id')
  final int? senderId;
  @override
  @JsonKey(name: 'recipient_id')
  final int? recipientId;
  @override
  @JsonKey(name: 'organization_id')
  final int? organizationId;
  @override
  @JsonKey(name: 'moving_type')
  final int? movingType;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'MoveDataDTO(id: $id, senderId: $senderId, recipientId: $recipientId, organizationId: $organizationId, movingType: $movingType, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MoveDataDTO &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.senderId, senderId) &&
            const DeepCollectionEquality()
                .equals(other.recipientId, recipientId) &&
            const DeepCollectionEquality()
                .equals(other.organizationId, organizationId) &&
            const DeepCollectionEquality()
                .equals(other.movingType, movingType) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(senderId),
      const DeepCollectionEquality().hash(recipientId),
      const DeepCollectionEquality().hash(organizationId),
      const DeepCollectionEquality().hash(movingType),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_MoveDataDTOCopyWith<_$_MoveDataDTO> get copyWith =>
      __$$_MoveDataDTOCopyWithImpl<_$_MoveDataDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoveDataDTOToJson(this);
  }
}

abstract class _MoveDataDTO implements MoveDataDTO {
  const factory _MoveDataDTO(
      {required final int id,
      @JsonKey(name: 'sender_id') final int? senderId,
      @JsonKey(name: 'recipient_id') final int? recipientId,
      @JsonKey(name: 'organization_id') final int? organizationId,
      @JsonKey(name: 'moving_type') final int? movingType,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt}) = _$_MoveDataDTO;

  factory _MoveDataDTO.fromJson(Map<String, dynamic> json) =
      _$_MoveDataDTO.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'sender_id')
  int? get senderId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'recipient_id')
  int? get recipientId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'organization_id')
  int? get organizationId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'moving_type')
  int? get movingType => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MoveDataDTOCopyWith<_$_MoveDataDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
