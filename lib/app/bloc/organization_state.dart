part of 'organization_cubit.dart';

@freezed
class OrganizationState with _$OrganizationState {
  const factory OrganizationState.initialState() = _InitialState;

  const factory OrganizationState.loadingState() = _LoadingState;

  const factory OrganizationState.loadedState({
    required List<CounteragentDTO> organizations,

  }) = _LoadedState;

  const factory OrganizationState.errorState({
    required String message,
  }) = _ErrorState;
}
