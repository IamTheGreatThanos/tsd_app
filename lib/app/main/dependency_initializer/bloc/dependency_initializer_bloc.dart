import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dependency_initializer_event.dart';
part 'dependency_initializer_state.dart';

class DependencyInitializerBloc
    extends Bloc<DependencyInitializerEvent, DependencyInitializerState> {
  DependencyInitializerBloc() : super(NotInitializedDependencyInitializer()) {
    on<InitialDependencyInitializedEvent>(
        (event, emit) => _onInitialDependencyInitializedEvent(event, emit),);
  }

  Future<void> _onInitialDependencyInitializedEvent(InitialDependencyInitializedEvent event,
      Emitter<DependencyInitializerState> emit,) async {
    await event._initializer.call(event.context);
    emit(InitializedDependencyInitializer());
  }
}
