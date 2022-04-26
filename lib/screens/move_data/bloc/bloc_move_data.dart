import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';

class BlocMoveData extends Bloc<EventBlocMoveData, StateBlocMoveData> {
  BlocMoveData() : super(StateMoveDataLoading()) {
    on<EventBlocMoveData>((event, emit) {
      // TODO: implement event handler
    });
  }
}
