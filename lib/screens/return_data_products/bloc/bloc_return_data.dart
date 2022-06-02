import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmacy_arrival/network/dio_wrapper/dio_extension.dart';
import 'package:pharmacy_arrival/network/models/dto_models/response/dto_return_data.dart';
import 'package:pharmacy_arrival/network/repository/global_repository.dart';

part 'events.dart';

part 'states.dart';

class BlocReturnData extends Bloc<EventBlocReturnData, StateBlocReturnData> {
  BlocReturnData({
    required GlobalRepository repository,
  })  : _repository = repository,
        super(StateReturnDataLoading()) {
    on<EventReturnDataInitial>((event, emit) async {
      try {
        final result = await _repository.getReturnData();
        emit(StateReturnDataLoadData(goods: result));
      } catch (e) {
        try {
          emit(StateReturnDataError(error: e.dioErrorMessage));
        } catch (e) {
          emit(StateReturnDataError(error: e.toString()));
        }
      }
    });
  }

  final GlobalRepository _repository;
}
