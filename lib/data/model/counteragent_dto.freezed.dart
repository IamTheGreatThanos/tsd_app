// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'counteragent_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CounteragentDTO _$CounteragentDTOFromJson(Map<String, dynamic> json) {
  return _CounteragentDTO.fromJson(json);
}

/// @nodoc
mixin _$CounteragentDTO {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CounteragentDTOCopyWith<CounteragentDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounteragentDTOCopyWith<$Res> {
  factory $CounteragentDTOCopyWith(
          CounteragentDTO value, $Res Function(CounteragentDTO) then) =
      _$CounteragentDTOCopyWithImpl<$Res, CounteragentDTO>;
  @useResult
  $Res call({int id, String? name});
}

/// @nodoc
class _$CounteragentDTOCopyWithImpl<$Res, $Val extends CounteragentDTO>
    implements $CounteragentDTOCopyWith<$Res> {
  _$CounteragentDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CounteragentDTOCopyWith<$Res>
    implements $CounteragentDTOCopyWith<$Res> {
  factory _$$_CounteragentDTOCopyWith(
          _$_CounteragentDTO value, $Res Function(_$_CounteragentDTO) then) =
      __$$_CounteragentDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? name});
}

/// @nodoc
class __$$_CounteragentDTOCopyWithImpl<$Res>
    extends _$CounteragentDTOCopyWithImpl<$Res, _$_CounteragentDTO>
    implements _$$_CounteragentDTOCopyWith<$Res> {
  __$$_CounteragentDTOCopyWithImpl(
      _$_CounteragentDTO _value, $Res Function(_$_CounteragentDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
  }) {
    return _then(_$_CounteragentDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CounteragentDTO implements _CounteragentDTO {
  const _$_CounteragentDTO({required this.id, this.name});

  factory _$_CounteragentDTO.fromJson(Map<String, dynamic> json) =>
      _$$_CounteragentDTOFromJson(json);

  @override
  final int id;
  @override
  final String? name;

  @override
  String toString() {
    return 'CounteragentDTO(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CounteragentDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CounteragentDTOCopyWith<_$_CounteragentDTO> get copyWith =>
      __$$_CounteragentDTOCopyWithImpl<_$_CounteragentDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CounteragentDTOToJson(
      this,
    );
  }
}

abstract class _CounteragentDTO implements CounteragentDTO {
  const factory _CounteragentDTO({required final int id, final String? name}) =
      _$_CounteragentDTO;

  factory _CounteragentDTO.fromJson(Map<String, dynamic> json) =
      _$_CounteragentDTO.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_CounteragentDTOCopyWith<_$_CounteragentDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
