part of 'pharmacy_qr_screen_cubit.dart';


@freezed
class PharmacyQrScreenState with _$PharmacyQrScreenState {
  const factory PharmacyQrScreenState.initialState() = _InitialState;

  const factory PharmacyQrScreenState.loadingState() = _LoadingState;

  const factory PharmacyQrScreenState.loadedState({
    required PharmacyOrderDTO order,
  }) = _LoadedState;

  const factory PharmacyQrScreenState.errorState({
    required String message,
  }) = _ErrorState;
}
