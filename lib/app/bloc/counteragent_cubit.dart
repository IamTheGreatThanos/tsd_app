import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/get_countragents.dart';

part 'counteragent_state.dart';
part 'counteragent_cubit.freezed.dart';

class CounteragentsCubit extends Cubit<CounteragentState> {
  final GetCountragents _getCounteragents;
  CounteragentsCubit(this._getCounteragents)
      : super(const CounteragentState.initialState());

  Future<void> loadCounteragents({
    int? userId,
  }) async {
    emit(const CounteragentState.loadingState());
    final result = await _getCounteragents.call(
      userId: userId,
    );
    result.fold(
        (l) =>
            emit(CounteragentState.errorState(message: mapFailureToMessage(l))),
        (r) {
      emit(CounteragentState.loadedState(counteragents: r));
    });
  }
}
