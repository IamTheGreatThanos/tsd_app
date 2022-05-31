import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmacy_arrival/network/dio_wrapper/dio_extension.dart';
import 'package:pharmacy_arrival/network/models/dto_models/response/dto_move_data.dart';
import 'package:pharmacy_arrival/network/repository/global_repository.dart';

part 'events.dart';

part 'states.dart';

class BlocMoveData extends Bloc<EventBlocMoveData, StateBlocMoveData> {
  BlocMoveData({
    required GlobalRepository repository,
  })  : _repository = repository,
        super(StateMoveDataLoading()) {
    on<EventMoveDataInitial>((event, emit) async {
      try {
        final result = await _repository.getMoveData();
        moveData = result;
        emit(StateMoveDataLoadData(goods: result));
      } catch (e) {
        try {
          emit(StateMoveDataError(error: e.dioErrorMessage));
        } catch (e) {
          emit(StateMoveDataError(error: e.toString()));
        }
      }
    });
    on<EventChangeMoveData>((event, emit) async {
      emit(StateMoveDataLoading());
      try {
        moveData[event.index].totalCount = event.count;
        moveData[event.index].series = event.number;
        emit(StateMoveDataLoadData(goods: moveData));
      } catch (e) {
        try {
          emit(StateMoveDataError(error: e.dioErrorMessage));
        } catch (e) {
          emit(StateMoveDataError(error: e.toString()));
        }
      }
    });
  }

  final GlobalRepository _repository;
  List<DTOMoveData> moveData = [];
}
