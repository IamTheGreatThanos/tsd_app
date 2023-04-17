import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/domain/repositories/auth_repository.dart';

part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository _authRepo;
  ProfileCubit(this._authRepo) : super(const ProfileState.initialState());

  Future<void> getProfile() async {
    emit(const ProfileState.loadingState());
    final result = await _authRepo.getProfile();
    result.fold(
        (l) => emit(ProfileState.errorState(message: mapFailureToMessage(l))),
        (r) {
      emit(ProfileState.loadedState(user: r));
    });
  }
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initialState() = _InitialState;

  const factory ProfileState.loadingState() = _LoadingState;

  const factory ProfileState.loadedState({
    required User user,
  }) = _LoadedState;

  const factory ProfileState.errorState({
    required String message,
  }) = _ErrorState;
}
