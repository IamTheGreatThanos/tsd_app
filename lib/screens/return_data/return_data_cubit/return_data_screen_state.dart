part of 'return_data_screen_cubit.dart';


@freezed
class ReturnDataScreenState with _$ReturnDataScreenState {
  const factory ReturnDataScreenState.initialState() = _InitialState;

  const factory ReturnDataScreenState.loadingState() = _LoadingState;

  const factory ReturnDataScreenState.loadedState({
    required PharmacyOrderDTO refundDataDTO,
  }) = _LoadedState;

  const factory ReturnDataScreenState.errorState({
    required String message,
  }) = _ErrorState;
}
