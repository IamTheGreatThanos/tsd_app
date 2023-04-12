part of 'refund_container_cubit.dart';

@freezed
class RefundContainerState with _$RefundContainerState {
 const factory RefundContainerState.initialState() = _InitialState;

  const factory RefundContainerState.loadingState() = _LoadingState;

  const factory RefundContainerState.loadedState({
    required String message,
  }) = _LoadedState;
  const factory RefundContainerState.errorState({
    required String message,
  }) = _ErrorState;
}
