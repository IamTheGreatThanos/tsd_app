import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_moving_history.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_orders_by_search.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_arrival_history.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/update_pharmacy_order_status.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/get_refund_history.dart';
import 'package:pharmacy_arrival/domain/usecases/warehouse_usecases/get_warehouse_arrival_history.dart';

part 'history_state.dart';
part 'history_cubit.freezed.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetPharmacyArrivalHistory _getPharmacyArrivalHistory;
  final GetWarehouseArrivalHistory _getWarehouseArrivalHistory;
  final GetMovingHistory _getMovingHistory;
  final UpdatePharmacyOrderStatus _updatePharmacyOrderStatus;
  final GetOrdersBySearch _getOrdersBySearch;
  final MoveDataRepository _moveDataRepository;
  HistoryCubit(
    this._getPharmacyArrivalHistory,
    this._getWarehouseArrivalHistory,
    this._getMovingHistory,
    this._updatePharmacyOrderStatus,
    this._getOrdersBySearch,
    this._moveDataRepository,
  ) : super(const HistoryState.initialState());

  Future<void> updatePharmacyOrderStatus({
    required int orderId,
    int? refundStatus,
    required bool isFromHisPage,
  }) async {
    emit(const HistoryState.loadingState());
    final result = await _updatePharmacyOrderStatus.call(
      UpdatePharmacyOrderStatusParams(
        orderId: orderId,
        refundStatus: refundStatus,
      ),
    );
    result.fold(
        (l) => emit(HistoryState.errorState(message: mapFailureToMessage(l))),
        (r) {
      log('Refund Status updated successfully');
      if (isFromHisPage) {
        getPharmacyArrivalHistory();
      } else {
        emit(const HistoryState.refundHistoryFinishedState());

        getPharmacyArrivalHistory();
      }
    });
  }

  Future<void> getPharmacyArrivalHistory({
    String? number,
    int? senderId,
    int? recipientId,
    int? refundStatus,
  }) async {
    emit(const HistoryState.loadingState());
    final failureOrSuccess = await _getPharmacyArrivalHistory.call(
      GetPharmacyArrivalHistoryParams(
        number: number,
        recipientId: recipientId,
        senderId: senderId,
        refundStatus: refundStatus,
      ),
    );
    failureOrSuccess.fold(
      (l) {
        log(l.toString());
        emit(HistoryState.errorState(message: mapFailureToMessage(l)));
      },
      (r) {
        log(r.length.toString());
        // final List<PharmacyOrderDTO> orders = [];
        // for (final PharmacyOrderDTO order in r) {
        //   if (order.status == 3) {
        //     orders.add(order);
        //   }
        // }
        emit(HistoryState.pharmacyHistoryState(pharmacyOrders: r));
      },
    );
  }

  Future<void> getPharmacyHistoryBySearch({
    required String number,
  }) async {
    emit(const HistoryState.loadingState());
    final result = await _getOrdersBySearch.call(
      GetOrdersBySearchParams(
        number: number,
        status: 3,
      ),
    );
    result.fold(
      (l) => emit(
        HistoryState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) => emit(HistoryState.pharmacyHistoryBySearch(pharmacyOrders: r)),
    );
  }

  Future<void> getWarehouseArrivalHistory() async {
    emit(const HistoryState.loadingState());
    final failureOrSuccess = await _getWarehouseArrivalHistory.call();
    failureOrSuccess.fold(
      (l) => emit(HistoryState.errorState(message: mapFailureToMessage(l))),
      (r) {
        final List<WarehouseOrderDTO> orders = [];
        for (final WarehouseOrderDTO order in r) {
          if (order.status == 3) {
            orders.add(order);
          }
        }
        emit(HistoryState.warehouseHistoryState(pharmacyOrders: orders));
      },
    );
  }

  Future<void> getMovingHistory() async {
    emit(const HistoryState.loadingState());
    final failureOrSuccess = await _moveDataRepository.getMovingOrders(accept: 1);
    failureOrSuccess.fold(
        (l) => emit(HistoryState.errorState(message: mapFailureToMessage(l))),
        (r) {
      final List<MoveDataDTO> orders = [];
      for (final MoveDataDTO order in r) {
        if (order.status == 2) {
          orders.add(order);
        }
      }
      emit(HistoryState.movingHistoryState(pharmacyOrders: r));
    });
  }

  Future<void> getRefundHistory({int? refundStatus}) async {
    emit(const HistoryState.loadingState());
    final failureOrSuccess = await _getPharmacyArrivalHistory
        .call(GetPharmacyArrivalHistoryParams(refundStatus: refundStatus));
    failureOrSuccess.fold(
        (l) => emit(HistoryState.errorState(message: mapFailureToMessage(l))),
        (r) {
      emit(HistoryState.refundHistoryState(pharmacyOrders: r));
    });
  }
}
