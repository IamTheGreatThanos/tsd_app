part of 'pharmacy_arrival_screen_cubit.dart';

@freezed
class PharmacyArrivalScreenState with _$PharmacyArrivalScreenState {
  const factory PharmacyArrivalScreenState.initialState() = _InitialState;

  const factory PharmacyArrivalScreenState.loadingState() = _LoadingState;

  const factory PharmacyArrivalScreenState.loadedState({
    required List<PharmacyOrderDTO> orders,
  }) = _LoadedState;

    const factory PharmacyArrivalScreenState.bySearch({
    required List<PharmacyOrderDTO> products,
  }) = _BySearchState;


  const factory PharmacyArrivalScreenState.errorState({
    required String message,
  }) = _ErrorState;
}
