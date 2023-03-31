// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_order_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WarehouseOrderDTO _$WarehouseOrderDTOFromJson(Map<String, dynamic> json) {
  return _WarehouseOrderDTO.fromJson(json);
}

/// @nodoc
mixin _$WarehouseOrderDTO {
  int get id => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  String? get number => throw _privateConstructorUsedError;
  @JsonKey(name: 'counteragent_id')
  int? get counteragentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  int? get container => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;
  CounteragentDTO? get counteragent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseOrderDTOCopyWith<WarehouseOrderDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseOrderDTOCopyWith<$Res> {
  factory $WarehouseOrderDTOCopyWith(
          WarehouseOrderDTO value, $Res Function(WarehouseOrderDTO) then) =
      _$WarehouseOrderDTOCopyWithImpl<$Res, WarehouseOrderDTO>;
  @useResult
  $Res call(
      {int id,
      int? status,
      String? number,
      @JsonKey(name: 'counteragent_id') int? counteragentId,
      @JsonKey(name: 'user_id') int? userId,
      int? container,
      @JsonKey(name: 'created_at') String? createdAt,
      String? provider,
      CounteragentDTO? counteragent});

  $CounteragentDTOCopyWith<$Res>? get counteragent;
}

/// @nodoc
class _$WarehouseOrderDTOCopyWithImpl<$Res, $Val extends WarehouseOrderDTO>
    implements $WarehouseOrderDTOCopyWith<$Res> {
  _$WarehouseOrderDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = freezed,
    Object? number = freezed,
    Object? counteragentId = freezed,
    Object? userId = freezed,
    Object? container = freezed,
    Object? createdAt = freezed,
    Object? provider = freezed,
    Object? counteragent = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      counteragentId: freezed == counteragentId
          ? _value.counteragentId
          : counteragentId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      container: freezed == container
          ? _value.container
          : container // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      counteragent: freezed == counteragent
          ? _value.counteragent
          : counteragent // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CounteragentDTOCopyWith<$Res>? get counteragent {
    if (_value.counteragent == null) {
      return null;
    }

    return $CounteragentDTOCopyWith<$Res>(_value.counteragent!, (value) {
      return _then(_value.copyWith(counteragent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WarehouseOrderDTOCopyWith<$Res>
    implements $WarehouseOrderDTOCopyWith<$Res> {
  factory _$$_WarehouseOrderDTOCopyWith(_$_WarehouseOrderDTO value,
          $Res Function(_$_WarehouseOrderDTO) then) =
      __$$_WarehouseOrderDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? status,
      String? number,
      @JsonKey(name: 'counteragent_id') int? counteragentId,
      @JsonKey(name: 'user_id') int? userId,
      int? container,
      @JsonKey(name: 'created_at') String? createdAt,
      String? provider,
      CounteragentDTO? counteragent});

  @override
  $CounteragentDTOCopyWith<$Res>? get counteragent;
}

/// @nodoc
class __$$_WarehouseOrderDTOCopyWithImpl<$Res>
    extends _$WarehouseOrderDTOCopyWithImpl<$Res, _$_WarehouseOrderDTO>
    implements _$$_WarehouseOrderDTOCopyWith<$Res> {
  __$$_WarehouseOrderDTOCopyWithImpl(
      _$_WarehouseOrderDTO _value, $Res Function(_$_WarehouseOrderDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = freezed,
    Object? number = freezed,
    Object? counteragentId = freezed,
    Object? userId = freezed,
    Object? container = freezed,
    Object? createdAt = freezed,
    Object? provider = freezed,
    Object? counteragent = freezed,
  }) {
    return _then(_$_WarehouseOrderDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      counteragentId: freezed == counteragentId
          ? _value.counteragentId
          : counteragentId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      container: freezed == container
          ? _value.container
          : container // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      counteragent: freezed == counteragent
          ? _value.counteragent
          : counteragent // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WarehouseOrderDTO implements _WarehouseOrderDTO {
  const _$_WarehouseOrderDTO(
      {required this.id,
      this.status,
      this.number,
      @JsonKey(name: 'counteragent_id') this.counteragentId,
      @JsonKey(name: 'user_id') this.userId,
      this.container,
      @JsonKey(name: 'created_at') this.createdAt,
      this.provider,
      this.counteragent});

  factory _$_WarehouseOrderDTO.fromJson(Map<String, dynamic> json) =>
      _$$_WarehouseOrderDTOFromJson(json);

  @override
  final int id;
  @override
  final int? status;
  @override
  final String? number;
  @override
  @JsonKey(name: 'counteragent_id')
  final int? counteragentId;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  final int? container;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  final String? provider;
  @override
  final CounteragentDTO? counteragent;

  @override
  String toString() {
    return 'WarehouseOrderDTO(id: $id, status: $status, number: $number, counteragentId: $counteragentId, userId: $userId, container: $container, createdAt: $createdAt, provider: $provider, counteragent: $counteragent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WarehouseOrderDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.counteragentId, counteragentId) ||
                other.counteragentId == counteragentId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.container, container) ||
                other.container == container) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.counteragent, counteragent) ||
                other.counteragent == counteragent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, status, number,
      counteragentId, userId, container, createdAt, provider, counteragent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WarehouseOrderDTOCopyWith<_$_WarehouseOrderDTO> get copyWith =>
      __$$_WarehouseOrderDTOCopyWithImpl<_$_WarehouseOrderDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WarehouseOrderDTOToJson(
      this,
    );
  }
}

abstract class _WarehouseOrderDTO implements WarehouseOrderDTO {
  const factory _WarehouseOrderDTO(
      {required final int id,
      final int? status,
      final String? number,
      @JsonKey(name: 'counteragent_id') final int? counteragentId,
      @JsonKey(name: 'user_id') final int? userId,
      final int? container,
      @JsonKey(name: 'created_at') final String? createdAt,
      final String? provider,
      final CounteragentDTO? counteragent}) = _$_WarehouseOrderDTO;

  factory _WarehouseOrderDTO.fromJson(Map<String, dynamic> json) =
      _$_WarehouseOrderDTO.fromJson;

  @override
  int get id;
  @override
  int? get status;
  @override
  String? get number;
  @override
  @JsonKey(name: 'counteragent_id')
  int? get counteragentId;
  @override
  @JsonKey(name: 'user_id')
  int? get userId;
  @override
  int? get container;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  String? get provider;
  @override
  CounteragentDTO? get counteragent;
  @override
  @JsonKey(ignore: true)
  _$$_WarehouseOrderDTOCopyWith<_$_WarehouseOrderDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
