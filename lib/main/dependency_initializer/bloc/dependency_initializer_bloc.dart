import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'dependency_initializer_event.dart';
part 'dependency_initializer_state.dart';

class DependencyInitializerBloc
    extends Bloc<DependencyInitializerEvent, DependencyInitializerState> {
  DependencyInitializerBloc() : super(NotInitializedDependencyInitializer()) {
    on<InitialDependencyInitializedEvent>(
        (event, emit) => _onInitialDependencyInitializedEvent(event, emit));
  }

  _onInitialDependencyInitializedEvent(InitialDependencyInitializedEvent event,
      Emitter<DependencyInitializerState> emit) async {
    await event._initializer.call(event.context);
    emit(InitializedDependencyInitializer());
  }
}
