import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

part 'move_order_page_state.dart';
part 'move_order_page_cubit.freezed.dart';

class MoveOrderPageCubit extends Cubit<MoveOrderPageState> {
  List<MoveDataDTO> _activeOrders = [];
  int _currentPage = 1;
  final MoveDataRepository _moveDataRepository;
  MoveOrderPageCubit(this._moveDataRepository)
      : super(const MoveOrderPageState.initialState());

  Future<void> onRefreshOrders({
    int? status,
    int? senderId,
    int? recipientId,
    int? accept,
    int? send,
    String? date,
    int? sortType,
  }) async {
    _currentPage = 1;
    emit(const MoveOrderPageState.loadingState());
    final result = await _moveDataRepository.getMovingOrders(
      status: status,
      senderId: senderId,
      recipientId: recipientId,
      accept: accept,
      send: send,
      date: date,
      page: _currentPage,
      sortType: sortType,
    );
    result.fold(
      (l) => emit(
        MoveOrderPageState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) {
        log("ON REFRESH:: , page:: $_currentPage,");
        _currentPage++;
        _activeOrders = [];
        _activeOrders += r;
        emit(MoveOrderPageState.loadedState(orders: _activeOrders));
      },
    );
  }

  Future<void> onLoadOrders({
    int? status,
    int? senderId,
    int? recipientId,
    int? accept,
    int? send,
    String? date,
    int? sortType,
  }) async {
    final result = await _moveDataRepository.getMovingOrders(
      status: status,
      senderId: senderId,
      recipientId: recipientId,
      accept: accept,
      send: send,
      date: date,
      page: _currentPage,
      sortType: sortType,
    );
    result.fold(
      (l) => emit(
        MoveOrderPageState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) {
        log("ON LOADING:: , page:: $_currentPage");
        if (r.isNotEmpty) {
          _currentPage++;
        }
        _activeOrders += r;
        emit(MoveOrderPageState.loadedState(orders: _activeOrders));
      },
    );
  }
}
