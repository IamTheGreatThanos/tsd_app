import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/update_pharmacy_order_status.dart';
import 'package:pharmacy_arrival/domain/usecases/warehouse_usecases/get_warehouse_arrival_history.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/vmodel/pharmacy_filter_vmodel.dart';

part 'history_state.dart';
part 'history_cubit.freezed.dart';
//TODO История разделено на 4 части: Для Приход Аптека, Приход на склад, Возврат, Перемещение

class HistoryCubit extends Cubit<HistoryState> {
  final GetWarehouseArrivalHistory _getWarehouseArrivalHistory;
  final PharmacyRepository _pharmacyRepository;
  final UpdatePharmacyOrderStatus _updatePharmacyOrderStatus;
  final MoveDataRepository _moveDataRepository;
  HistoryCubit(
    this._getWarehouseArrivalHistory,
    this._pharmacyRepository,
    this._updatePharmacyOrderStatus,
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
    PharmacyFilterVmodel? pharmacyFilterVmodel,
    String? number,
    int? refundStatus,
  }) async {
    emit(const HistoryState.loadingState());
    final failureOrSuccess = await _pharmacyRepository.getPharmacyArrivalOrders(
      number: number,
      page: 1,
      refundStatus: refundStatus,
      status: 3,
      incomingDate: pharmacyFilterVmodel?.incomingDate,
      incomingNumber: pharmacyFilterVmodel?.incomingNumber,
      senderId: pharmacyFilterVmodel?.sender?.id,
      departureDate: pharmacyFilterVmodel?.departureDate,
      sortType: pharmacyFilterVmodel?.sortType,
      amountEnd: pharmacyFilterVmodel?.amountEnd,
      amountStart: pharmacyFilterVmodel?.amountStart,
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

  Future<void> getMovingHistory({
    int? status,
    int? senderId,
    int? recipientId,
    String? date,
  }) async {
    emit(const HistoryState.loadingState());
    final failureOrSuccess = await _moveDataRepository.getMovingOrders(
      accept: 1,
      send: 1,
      senderId: senderId,
      recipientId: recipientId,
      date: date,
    );
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

  Future<void> getRefundHistory({
    PharmacyFilterVmodel? pharmacyFilterVmodel,
    String? number,
    int? recipientId,
    int? refundStatus,
  }) async {
    emit(const HistoryState.loadingState());
    final failureOrSuccess = await _pharmacyRepository.getPharmacyArrivalOrders(
      number: number,
      page: 1,
      refundStatus: refundStatus,
      status: 3,
      incomingDate: pharmacyFilterVmodel?.incomingDate,
      incomingNumber: pharmacyFilterVmodel?.incomingNumber,
      senderId: pharmacyFilterVmodel?.sender?.id,
      departureDate: pharmacyFilterVmodel?.departureDate,
      sortType: pharmacyFilterVmodel?.sortType,
      amountEnd: pharmacyFilterVmodel?.amountEnd,
      amountStart: pharmacyFilterVmodel?.amountStart,
    );
    failureOrSuccess.fold(
        (l) => emit(HistoryState.errorState(message: mapFailureToMessage(l))),
        (r) {
      emit(HistoryState.refundHistoryState(pharmacyOrders: r));
    });
  }
}
