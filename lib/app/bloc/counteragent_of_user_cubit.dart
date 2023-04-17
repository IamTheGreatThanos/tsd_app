import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/get_countragents.dart';

part 'counteragent_of_user_cubit.freezed.dart';

class CounteragentOfUserCubit extends Cubit<CounteragentOfUserState> {
  final GetCountragents _getCounteragents;
  CounteragentOfUserCubit(this._getCounteragents)
      : super(const CounteragentOfUserState.initialState());

  Future<void> loadCounteragents({
    int? userId,
  }) async {
    emit(const CounteragentOfUserState.loadingState());
    final result = await _getCounteragents.call(
      userId: userId,
    );
    result.fold(
        (l) =>
            emit(CounteragentOfUserState.errorState(message: mapFailureToMessage(l))),
        (r) {
      emit(CounteragentOfUserState.loadedState(counteragents: r));
    });
  }
}

@freezed
class CounteragentOfUserState with _$CounteragentOfUserState {
  const factory CounteragentOfUserState.initialState() = _InitialState;

  const factory CounteragentOfUserState.loadingState() = _LoadingState;

  const factory CounteragentOfUserState.loadedState({
    required List<CounteragentDTO> counteragents,

  }) = _LoadedState;

  const factory CounteragentOfUserState.errorState({
    required String message,
  }) = _ErrorState;
}

