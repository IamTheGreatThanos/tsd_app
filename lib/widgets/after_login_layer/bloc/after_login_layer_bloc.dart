import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pharmacy_arrival/generated/l10n.dart';
import 'package:pharmacy_arrival/network/repository/global_repository.dart';
import 'package:pharmacy_arrival/network/repository/hive_repository.dart';
import 'package:pharmacy_arrival/network/tokens_repository/tokens_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'after_login_layer_event.dart';

part 'after_login_layer_state.dart';

class AfterLoginLayerBloc
    extends Bloc<AfterLoginLayerEvent, AfterLoginLayerState> {
  GlobalRepository _repository;
  TokensRepository _tokensRepository;
  final S _lang;
  final HiveRepository _hiveRepository;

  AfterLoginLayerBloc(
    this._repository,
    this._tokensRepository,
    this._lang,
    this._hiveRepository,
  ) : super(LoadingAfterLoginState()) {
    on<InitialAfterLoginEvent>(_onInitialAfterLoginEvent);
  }

  _onInitialAfterLoginEvent(
      InitialAfterLoginEvent event, Emitter<AfterLoginLayerState> emit) async {
    try {

    } catch (error) {
      if (kDebugMode) {
        rethrow;
      }
      emit(ErrorAfterLoginState(error));
    }
  }
}

