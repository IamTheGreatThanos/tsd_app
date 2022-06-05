import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dynamic_link_layer_event.dart';
part 'dynamic_link_layer_state.dart';

class DynamicLinkLayerBloc
    extends Bloc<DynamicLinkLayerEvent, DynamicLinkLayerState> {
  bool isAuthorized;

  DynamicLinkLayerBloc(
    this.isAuthorized,
  ) : super(DynamicLinkLayerInitial()) {
    on<InitialDynamicLinkLayerEvent>(
      (event, emit) => _buildInitialEvent(event, emit),
    );
  }

  Future<void> _buildInitialEvent(
    InitialDynamicLinkLayerEvent event,
    Emitter<DynamicLinkLayerState> emit,
  ) async {
    if (isAuthorized) {
      emit(AuthorizedState());
    } else {
      emit(NotAuthorizedState());
    }
  }
}
