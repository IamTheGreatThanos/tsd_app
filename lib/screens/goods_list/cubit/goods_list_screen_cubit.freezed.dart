// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods_list_screen_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GoodsListScreenState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialState,
    required TResult Function() loadingState,
    required TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)
        loadedState,
    required TResult Function(String message) successScannedState,
    required TResult Function(String message) errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialState,
    TResult? Function()? loadingState,
    TResult? Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult? Function(String message)? successScannedState,
    TResult? Function(String message)? errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult Function(String message)? successScannedState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initialState,
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_LoadedState value) loadedState,
    required TResult Function(_SuccessScannedState value) successScannedState,
    required TResult Function(_ErrorState value) errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialState value)? initialState,
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_LoadedState value)? loadedState,
    TResult? Function(_SuccessScannedState value)? successScannedState,
    TResult? Function(_ErrorState value)? errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_LoadedState value)? loadedState,
    TResult Function(_SuccessScannedState value)? successScannedState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoodsListScreenStateCopyWith<$Res> {
  factory $GoodsListScreenStateCopyWith(GoodsListScreenState value,
          $Res Function(GoodsListScreenState) then) =
      _$GoodsListScreenStateCopyWithImpl<$Res, GoodsListScreenState>;
}

/// @nodoc
class _$GoodsListScreenStateCopyWithImpl<$Res,
        $Val extends GoodsListScreenState>
    implements $GoodsListScreenStateCopyWith<$Res> {
  _$GoodsListScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialStateCopyWith<$Res> {
  factory _$$_InitialStateCopyWith(
          _$_InitialState value, $Res Function(_$_InitialState) then) =
      __$$_InitialStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialStateCopyWithImpl<$Res>
    extends _$GoodsListScreenStateCopyWithImpl<$Res, _$_InitialState>
    implements _$$_InitialStateCopyWith<$Res> {
  __$$_InitialStateCopyWithImpl(
      _$_InitialState _value, $Res Function(_$_InitialState) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_InitialState implements _InitialState {
  const _$_InitialState();

  @override
  String toString() {
    return 'GoodsListScreenState.initialState()';
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
    required TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)
        loadedState,
    required TResult Function(String message) successScannedState,
    required TResult Function(String message) errorState,
  }) {
    return initialState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialState,
    TResult? Function()? loadingState,
    TResult? Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult? Function(String message)? successScannedState,
    TResult? Function(String message)? errorState,
  }) {
    return initialState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult Function(String message)? successScannedState,
    TResult Function(String message)? errorState,
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
    required TResult Function(_LoadedState value) loadedState,
    required TResult Function(_SuccessScannedState value) successScannedState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return initialState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialState value)? initialState,
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_LoadedState value)? loadedState,
    TResult? Function(_SuccessScannedState value)? successScannedState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return initialState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_LoadedState value)? loadedState,
    TResult Function(_SuccessScannedState value)? successScannedState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (initialState != null) {
      return initialState(this);
    }
    return orElse();
  }
}

abstract class _InitialState implements GoodsListScreenState {
  const factory _InitialState() = _$_InitialState;
}

/// @nodoc
abstract class _$$_LoadingStateCopyWith<$Res> {
  factory _$$_LoadingStateCopyWith(
          _$_LoadingState value, $Res Function(_$_LoadingState) then) =
      __$$_LoadingStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingStateCopyWithImpl<$Res>
    extends _$GoodsListScreenStateCopyWithImpl<$Res, _$_LoadingState>
    implements _$$_LoadingStateCopyWith<$Res> {
  __$$_LoadingStateCopyWithImpl(
      _$_LoadingState _value, $Res Function(_$_LoadingState) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_LoadingState implements _LoadingState {
  const _$_LoadingState();

  @override
  String toString() {
    return 'GoodsListScreenState.loadingState()';
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
    required TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)
        loadedState,
    required TResult Function(String message) successScannedState,
    required TResult Function(String message) errorState,
  }) {
    return loadingState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialState,
    TResult? Function()? loadingState,
    TResult? Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult? Function(String message)? successScannedState,
    TResult? Function(String message)? errorState,
  }) {
    return loadingState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult Function(String message)? successScannedState,
    TResult Function(String message)? errorState,
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
    required TResult Function(_LoadedState value) loadedState,
    required TResult Function(_SuccessScannedState value) successScannedState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return loadingState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialState value)? initialState,
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_LoadedState value)? loadedState,
    TResult? Function(_SuccessScannedState value)? successScannedState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return loadingState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_LoadedState value)? loadedState,
    TResult Function(_SuccessScannedState value)? successScannedState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (loadingState != null) {
      return loadingState(this);
    }
    return orElse();
  }
}

abstract class _LoadingState implements GoodsListScreenState {
  const factory _LoadingState() = _$_LoadingState;
}

/// @nodoc
abstract class _$$_LoadedStateCopyWith<$Res> {
  factory _$$_LoadedStateCopyWith(
          _$_LoadedState value, $Res Function(_$_LoadedState) then) =
      __$$_LoadedStateCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<ProductDTO> scannedProducts,
      List<ProductDTO> unscannedProducts,
      ProductDTO selectedProduct});

  $ProductDTOCopyWith<$Res> get selectedProduct;
}

/// @nodoc
class __$$_LoadedStateCopyWithImpl<$Res>
    extends _$GoodsListScreenStateCopyWithImpl<$Res, _$_LoadedState>
    implements _$$_LoadedStateCopyWith<$Res> {
  __$$_LoadedStateCopyWithImpl(
      _$_LoadedState _value, $Res Function(_$_LoadedState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scannedProducts = null,
    Object? unscannedProducts = null,
    Object? selectedProduct = null,
  }) {
    return _then(_$_LoadedState(
      scannedProducts: null == scannedProducts
          ? _value._scannedProducts
          : scannedProducts // ignore: cast_nullable_to_non_nullable
              as List<ProductDTO>,
      unscannedProducts: null == unscannedProducts
          ? _value._unscannedProducts
          : unscannedProducts // ignore: cast_nullable_to_non_nullable
              as List<ProductDTO>,
      selectedProduct: null == selectedProduct
          ? _value.selectedProduct
          : selectedProduct // ignore: cast_nullable_to_non_nullable
              as ProductDTO,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductDTOCopyWith<$Res> get selectedProduct {
    return $ProductDTOCopyWith<$Res>(_value.selectedProduct, (value) {
      return _then(_value.copyWith(selectedProduct: value));
    });
  }
}

/// @nodoc

class _$_LoadedState implements _LoadedState {
  const _$_LoadedState(
      {required final List<ProductDTO> scannedProducts,
      required final List<ProductDTO> unscannedProducts,
      required this.selectedProduct})
      : _scannedProducts = scannedProducts,
        _unscannedProducts = unscannedProducts;

  final List<ProductDTO> _scannedProducts;
  @override
  List<ProductDTO> get scannedProducts {
    if (_scannedProducts is EqualUnmodifiableListView) return _scannedProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scannedProducts);
  }

  final List<ProductDTO> _unscannedProducts;
  @override
  List<ProductDTO> get unscannedProducts {
    if (_unscannedProducts is EqualUnmodifiableListView)
      return _unscannedProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unscannedProducts);
  }

  @override
  final ProductDTO selectedProduct;

  @override
  String toString() {
    return 'GoodsListScreenState.loadedState(scannedProducts: $scannedProducts, unscannedProducts: $unscannedProducts, selectedProduct: $selectedProduct)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoadedState &&
            const DeepCollectionEquality()
                .equals(other._scannedProducts, _scannedProducts) &&
            const DeepCollectionEquality()
                .equals(other._unscannedProducts, _unscannedProducts) &&
            (identical(other.selectedProduct, selectedProduct) ||
                other.selectedProduct == selectedProduct));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_scannedProducts),
      const DeepCollectionEquality().hash(_unscannedProducts),
      selectedProduct);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoadedStateCopyWith<_$_LoadedState> get copyWith =>
      __$$_LoadedStateCopyWithImpl<_$_LoadedState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialState,
    required TResult Function() loadingState,
    required TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)
        loadedState,
    required TResult Function(String message) successScannedState,
    required TResult Function(String message) errorState,
  }) {
    return loadedState(scannedProducts, unscannedProducts, selectedProduct);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialState,
    TResult? Function()? loadingState,
    TResult? Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult? Function(String message)? successScannedState,
    TResult? Function(String message)? errorState,
  }) {
    return loadedState?.call(
        scannedProducts, unscannedProducts, selectedProduct);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult Function(String message)? successScannedState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) {
    if (loadedState != null) {
      return loadedState(scannedProducts, unscannedProducts, selectedProduct);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initialState,
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_LoadedState value) loadedState,
    required TResult Function(_SuccessScannedState value) successScannedState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return loadedState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialState value)? initialState,
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_LoadedState value)? loadedState,
    TResult? Function(_SuccessScannedState value)? successScannedState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return loadedState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_LoadedState value)? loadedState,
    TResult Function(_SuccessScannedState value)? successScannedState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (loadedState != null) {
      return loadedState(this);
    }
    return orElse();
  }
}

abstract class _LoadedState implements GoodsListScreenState {
  const factory _LoadedState(
      {required final List<ProductDTO> scannedProducts,
      required final List<ProductDTO> unscannedProducts,
      required final ProductDTO selectedProduct}) = _$_LoadedState;

  List<ProductDTO> get scannedProducts;
  List<ProductDTO> get unscannedProducts;
  ProductDTO get selectedProduct;
  @JsonKey(ignore: true)
  _$$_LoadedStateCopyWith<_$_LoadedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SuccessScannedStateCopyWith<$Res> {
  factory _$$_SuccessScannedStateCopyWith(_$_SuccessScannedState value,
          $Res Function(_$_SuccessScannedState) then) =
      __$$_SuccessScannedStateCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_SuccessScannedStateCopyWithImpl<$Res>
    extends _$GoodsListScreenStateCopyWithImpl<$Res, _$_SuccessScannedState>
    implements _$$_SuccessScannedStateCopyWith<$Res> {
  __$$_SuccessScannedStateCopyWithImpl(_$_SuccessScannedState _value,
      $Res Function(_$_SuccessScannedState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_SuccessScannedState(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SuccessScannedState implements _SuccessScannedState {
  const _$_SuccessScannedState({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'GoodsListScreenState.successScannedState(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SuccessScannedState &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SuccessScannedStateCopyWith<_$_SuccessScannedState> get copyWith =>
      __$$_SuccessScannedStateCopyWithImpl<_$_SuccessScannedState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialState,
    required TResult Function() loadingState,
    required TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)
        loadedState,
    required TResult Function(String message) successScannedState,
    required TResult Function(String message) errorState,
  }) {
    return successScannedState(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialState,
    TResult? Function()? loadingState,
    TResult? Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult? Function(String message)? successScannedState,
    TResult? Function(String message)? errorState,
  }) {
    return successScannedState?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult Function(String message)? successScannedState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) {
    if (successScannedState != null) {
      return successScannedState(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initialState,
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_LoadedState value) loadedState,
    required TResult Function(_SuccessScannedState value) successScannedState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return successScannedState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialState value)? initialState,
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_LoadedState value)? loadedState,
    TResult? Function(_SuccessScannedState value)? successScannedState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return successScannedState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_LoadedState value)? loadedState,
    TResult Function(_SuccessScannedState value)? successScannedState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (successScannedState != null) {
      return successScannedState(this);
    }
    return orElse();
  }
}

abstract class _SuccessScannedState implements GoodsListScreenState {
  const factory _SuccessScannedState({required final String message}) =
      _$_SuccessScannedState;

  String get message;
  @JsonKey(ignore: true)
  _$$_SuccessScannedStateCopyWith<_$_SuccessScannedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorStateCopyWith<$Res> {
  factory _$$_ErrorStateCopyWith(
          _$_ErrorState value, $Res Function(_$_ErrorState) then) =
      __$$_ErrorStateCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_ErrorStateCopyWithImpl<$Res>
    extends _$GoodsListScreenStateCopyWithImpl<$Res, _$_ErrorState>
    implements _$$_ErrorStateCopyWith<$Res> {
  __$$_ErrorStateCopyWithImpl(
      _$_ErrorState _value, $Res Function(_$_ErrorState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_ErrorState(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ErrorState implements _ErrorState {
  const _$_ErrorState({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'GoodsListScreenState.errorState(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ErrorState &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorStateCopyWith<_$_ErrorState> get copyWith =>
      __$$_ErrorStateCopyWithImpl<_$_ErrorState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialState,
    required TResult Function() loadingState,
    required TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)
        loadedState,
    required TResult Function(String message) successScannedState,
    required TResult Function(String message) errorState,
  }) {
    return errorState(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialState,
    TResult? Function()? loadingState,
    TResult? Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult? Function(String message)? successScannedState,
    TResult? Function(String message)? errorState,
  }) {
    return errorState?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialState,
    TResult Function()? loadingState,
    TResult Function(List<ProductDTO> scannedProducts,
            List<ProductDTO> unscannedProducts, ProductDTO selectedProduct)?
        loadedState,
    TResult Function(String message)? successScannedState,
    TResult Function(String message)? errorState,
    required TResult orElse(),
  }) {
    if (errorState != null) {
      return errorState(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initialState,
    required TResult Function(_LoadingState value) loadingState,
    required TResult Function(_LoadedState value) loadedState,
    required TResult Function(_SuccessScannedState value) successScannedState,
    required TResult Function(_ErrorState value) errorState,
  }) {
    return errorState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialState value)? initialState,
    TResult? Function(_LoadingState value)? loadingState,
    TResult? Function(_LoadedState value)? loadedState,
    TResult? Function(_SuccessScannedState value)? successScannedState,
    TResult? Function(_ErrorState value)? errorState,
  }) {
    return errorState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initialState,
    TResult Function(_LoadingState value)? loadingState,
    TResult Function(_LoadedState value)? loadedState,
    TResult Function(_SuccessScannedState value)? successScannedState,
    TResult Function(_ErrorState value)? errorState,
    required TResult orElse(),
  }) {
    if (errorState != null) {
      return errorState(this);
    }
    return orElse();
  }
}

abstract class _ErrorState implements GoodsListScreenState {
  const factory _ErrorState({required final String message}) = _$_ErrorState;

  String get message;
  @JsonKey(ignore: true)
  _$$_ErrorStateCopyWith<_$_ErrorState> get copyWith =>
      throw _privateConstructorUsedError;
}
