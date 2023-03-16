part of 'accept_cont_launch_cubit.dart';

@freezed
class AcceptContLaunchState with _$AcceptContLaunchState {
  const factory AcceptContLaunchState.initialState() = _InitialState;

  const factory AcceptContLaunchState.loadingState() = _LoadingState;

  const factory AcceptContLaunchState.activeState() = _ActiveState;

  const factory AcceptContLaunchState.passiveState() = _PassiveState;
}
