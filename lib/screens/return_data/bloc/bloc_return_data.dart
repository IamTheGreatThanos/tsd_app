import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';

class BlocReturnData extends Bloc<EventBlocReturnData, StateBlocReturnData> {
  BlocReturnData() : super(StateReturnDataLoading()) {
    on<EventBlocReturnData>((event, emit) {
      // TODO: implement event handler
    });
  }
}
