// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'move_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MoveState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialState,
    required TResult Function() loadingState,
    required TResult Function(
            MoveDataDTO moveDataDTO, List<ProductDTO> products)
        activeState,
    required TResult Function() passiveState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(MoveDataDTO moveDataDTO, List<ProductDTO> products)?
        activeState,
    TResult Function()? passiveState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(MoveDataDTO moveDataDTO, List<ProductDTO> products)?
        activeState,
    TResult Function()? passiveState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initialState,
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_ActiveState value) activeState,
    required TResult Function(_PassiveState value) passiveState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_ActiveState value)? activeState,
    TResult Function(_PassiveState value)? passiveState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_ActiveState value)? activeState,
    TResult Function(_PassiveState value)? passiveState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoveStateCopyWith<$Res> {
  factory $MoveStateCopyWith(MoveState value, $Res Function(MoveState) then) =
      _$MoveStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$MoveStateCopyWithImpl<$Res> implements $MoveStateCopyWith<$Res> {
  _$MoveStateCopyWithImpl(this._value, this._then);

  final MoveState _value;
  // ignore: unused_field
  final $Res Function(MoveState) _then;
}

/// @nodoc
abstract class _$$_InitialStateCopyWith<$Res> {
  factory _$$_InitialStateCopyWith(
          _$_InitialState value, $Res Function(_$_InitialState) then) =
      __$$_InitialStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialStateCopyWithImpl<$Res> extends _$MoveStateCopyWithImpl<$Res>
    implements _$$_InitialStateCopyWith<$Res> {
  __$$_InitialStateCopyWithImpl(
      _$_InitialState _value, $Res Function(_$_InitialState) _then)
      : super(_value, (v) => _then(v as _$_InitialState));

  @override
  _$_InitialState get _value => super._value as _$_InitialState;
}

/// @nodoc

class _$_InitialState implements _InitialState {
  const _$_InitialState();

  @override
  String toString() {
    return 'MoveState.initialState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_InitialState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialState,
    required TResult Function() loadingState,
    required TResult Function(
            MoveDataDTO moveDataDTO, List<ProductDTO> products)
        activeState,
    required TResult Function() passiveState,
  }) {
    return initialState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(MoveDataDTO moveDataDTO, List<ProductDTO> products)?
        activeState,
    TResult Function()? passiveState,
  }) {
    return initialState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(MoveDataDTO moveDataDTO, List<ProductDTO> products)?
        activeState,
    TResult Function()? passiveState,
    required TResult orElse(),
  }) {
    if (initialState != null) {
      return initialState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initialState,
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_ActiveState value) activeState,
    required TResult Function(_PassiveState value) passiveState,
  }) {
    return initialState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_ActiveState value)? activeState,
    TResult Function(_PassiveState value)? passiveState,
  }) {
    return initialState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_ActiveState value)? activeState,
    TResult Function(_PassiveState value)? passiveState,
    required TResult orElse(),
  }) {
    if (initialState != null) {
      return initialState(this);
    }
    return orElse();
  }
}

abstract class _InitialState implements MoveState {
  const factory _InitialState() = _$_InitialState;
}

/// @nodoc
abstract class _$$_LoadingStateCopyWith<$Res> {
  factory _$$_LoadingStateCopyWith(
          _$_LoadingState value, $Res Function(_$_LoadingState) then) =
      __$$_LoadingStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingStateCopyWithImpl<$Res> extends _$MoveStateCopyWithImpl<$Res>
    implements _$$_LoadingStateCopyWith<$Res> {
  __$$_LoadingStateCopyWithImpl(
      _$_LoadingState _value, $Res Function(_$_LoadingState) _then)
      : super(_value, (v) => _then(v as _$_LoadingState));

  @override
  _$_LoadingState get _value => super._value as _$_LoadingState;
}

/// @nodoc

class _$_LoadingState implements _LoadingState {
  const _$_LoadingState();

  @override
  String toString() {
    return 'MoveState.loadingState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_LoadingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialState,
    required TResult Function() loadingState,
    required TResult Function(
            MoveDataDTO moveDataDTO, List<ProductDTO> products)
        activeState,
    required TResult Function() passiveState,
  }) {
    return loadingState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(MoveDataDTO moveDataDTO, List<ProductDTO> products)?
        activeState,
    TResult Function()? passiveState,
  }) {
    return loadingState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(MoveDataDTO moveDataDTO, List<ProductDTO> products)?
        activeState,
    TResult Function()? passiveState,
    required TResult orElse(),
  }) {
    if (loadingState != null) {
      return loadingState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initialState,
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_ActiveState value) activeState,
    required TResult Function(_PassiveState value) passiveState,
  }) {
    return loadingState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_ActiveState value)? activeState,
    TResult Function(_PassiveState value)? passiveState,
  }) {
    return loadingState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_ActiveState value)? activeState,
    TResult Function(_PassiveState value)? passiveState,
    required TResult orElse(),
  }) {
    if (loadingState != null) {
      return loadingState(this);
    }
    return orElse();
  }
}

abstract class _LoadingState implements MoveState {
  const factory _LoadingState() = _$_LoadingState;
}

/// @nodoc
abstract class _$$_ActiveStateCopyWith<$Res> {
  factory _$$_ActiveStateCopyWith(
          _$_ActiveState value, $Res Function(_$_ActiveState) then) =
      __$$_ActiveStateCopyWithImpl<$Res>;
  $Res call({MoveDataDTO moveDataDTO, List<ProductDTO> products});

  $MoveDataDTOCopyWith<$Res> get moveDataDTO;
}

/// @nodoc
class __$$_ActiveStateCopyWithImpl<$Res> extends _$MoveStateCopyWithImpl<$Res>
    implements _$$_ActiveStateCopyWith<$Res> {
  __$$_ActiveStateCopyWithImpl(
      _$_ActiveState _value, $Res Function(_$_ActiveState) _then)
      : super(_value, (v) => _then(v as _$_ActiveState));

  @override
  _$_ActiveState get _value => super._value as _$_ActiveState;

  @override
  $Res call({
    Object? moveDataDTO = freezed,
    Object? products = freezed,
  }) {
    return _then(_$_ActiveState(
      moveDataDTO: moveDataDTO == freezed
          ? _value.moveDataDTO
          : moveDataDTO // ignore: cast_nullable_to_non_nullable
              as MoveDataDTO,
      products: products == freezed
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductDTO>,
    ));
  }

  @override
  $MoveDataDTOCopyWith<$Res> get moveDataDTO {
    return $MoveDataDTOCopyWith<$Res>(_value.moveDataDTO, (value) {
      return _then(_value.copyWith(moveDataDTO: value));
    });
  }
}

/// @nodoc

class _$_ActiveState implements _ActiveState {
  const _$_ActiveState(
      {required this.moveDataDTO, required final List<ProductDTO> products})
      : _products = products;

  @override
  final MoveDataDTO moveDataDTO;
  final List<ProductDTO> _products;
  @override
  List<ProductDTO> get products {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'MoveState.activeState(moveDataDTO: $moveDataDTO, products: $products)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActiveState &&
            const DeepCollectionEquality()
                .equals(other.moveDataDTO, moveDataDTO) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(moveDataDTO),
      const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  _$$_ActiveStateCopyWith<_$_ActiveState> get copyWith =>
      __$$_ActiveStateCopyWithImpl<_$_ActiveState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialState,
    required TResult Function() loadingState,
    required TResult Function(
            MoveDataDTO moveDataDTO, List<ProductDTO> products)
        activeState,
    required TResult Function() passiveState,
  }) {
    return activeState(moveDataDTO, products);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(MoveDataDTO moveDataDTO, List<ProductDTO> products)?
        activeState,
    TResult Function()? passiveState,
  }) {
    return activeState?.call(moveDataDTO, products);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(MoveDataDTO moveDataDTO, List<ProductDTO> products)?
        activeState,
    TResult Function()? passiveState,
    required TResult orElse(),
  }) {
    if (activeState != null) {
      return activeState(moveDataDTO, products);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initialState,
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_ActiveState value) activeState,
    required TResult Function(_PassiveState value) passiveState,
  }) {
    return activeState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_ActiveState value)? activeState,
    TResult Function(_PassiveState value)? passiveState,
  }) {
    return activeState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_ActiveState value)? activeState,
    TResult Function(_PassiveState value)? passiveState,
    required TResult orElse(),
  }) {
    if (activeState != null) {
      return activeState(this);
    }
    return orElse();
  }
}

abstract class _ActiveState implements MoveState {
  const factory _ActiveState(
      {required final MoveDataDTO moveDataDTO,
      required final List<ProductDTO> products}) = _$_ActiveState;

  MoveDataDTO get moveDataDTO;
  List<ProductDTO> get products;
  @JsonKey(ignore: true)
  _$$_ActiveStateCopyWith<_$_ActiveState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_PassiveStateCopyWith<$Res> {
  factory _$$_PassiveStateCopyWith(
          _$_PassiveState value, $Res Function(_$_PassiveState) then) =
      __$$_PassiveStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_PassiveStateCopyWithImpl<$Res> extends _$MoveStateCopyWithImpl<$Res>
    implements _$$_PassiveStateCopyWith<$Res> {
  __$$_PassiveStateCopyWithImpl(
      _$_PassiveState _value, $Res Function(_$_PassiveState) _then)
      : super(_value, (v) => _then(v as _$_PassiveState));

  @override
  _$_PassiveState get _value => super._value as _$_PassiveState;
}

/// @nodoc

class _$_PassiveState implements _PassiveState {
  const _$_PassiveState();

  @override
  String toString() {
    return 'MoveState.passiveState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_PassiveState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialState,
    required TResult Function() loadingState,
    required TResult Function(
            MoveDataDTO moveDataDTO, List<ProductDTO> products)
        activeState,
    required TResult Function() passiveState,
  }) {
    return passiveState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(MoveDataDTO moveDataDTO, List<ProductDTO> products)?
        activeState,
    TResult Function()? passiveState,
  }) {
    return passiveState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(MoveDataDTO moveDataDTO, List<ProductDTO> products)?
        activeState,
    TResult Function()? passiveState,
    required TResult orElse(),
  }) {
    if (passiveState != null) {
      return passiveState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initialState,
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_ActiveState value) activeState,
    required TResult Function(_PassiveState value) passiveState,
  }) {
    return passiveState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_ActiveState value)? activeState,
    TResult Function(_PassiveState value)? passiveState,
  }) {
    return passiveState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_ActiveState value)? activeState,
    TResult Function(_PassiveState value)? passiveState,
    required TResult orElse(),
  }) {
    if (passiveState != null) {
      return passiveState(this);
    }
    return orElse();
  }
}

abstract class _PassiveState implements MoveState {
  const factory _PassiveState() = _$_PassiveState;
}
