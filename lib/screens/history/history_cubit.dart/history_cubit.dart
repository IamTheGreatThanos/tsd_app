
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_moving_history.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_arrival_history.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/get_refund_history.dart';
import 'package:pharmacy_arrival/domain/usecases/warehouse_usecases/get_warehouse_arrival_history.dart';

part 'history_state.dart';
part 'history_cubit.freezed.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetPharmacyArrivalHistory _getPharmacyArrivalHistory;
  final GetWarehouseArrivalHistory _getWarehouseArrivalHistory;
  final GetMovingHistory _getMovingHistory;
  final GetRefundHistory _getRefundHistory;
  HistoryCubit(
    this._getPharmacyArrivalHistory,
    this._getWarehouseArrivalHistory,
    this._getMovingHistory,
    this._getRefundHistory,
  ) : super(const HistoryState.initialState());

  Future<void> getPharmacyArrivalHistory() async {
    emit(const HistoryState.loadingState());
    final failureOrSuccess = await _getPharmacyArrivalHistory.call();
    failureOrSuccess.fold(
      (l) => emit(HistoryState.errorState(message: mapFailureToMessage(l))),
      (r) {
        final List<PharmacyOrderDTO> orders = [];
        for (final PharmacyOrderDTO order in r) {
          if (order.status == 3) {
            orders.add(order);
          }
        }
        emit(HistoryState.pharmacyHistoryState(pharmacyOrders: orders));
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

  Future<void> getMovingHistory() async {
    emit(const HistoryState.loadingState());
    final failureOrSuccess = await _getMovingHistory.call();
    failureOrSuccess.fold(
        (l) => emit(HistoryState.errorState(message: mapFailureToMessage(l))),
        (r) {
      final List<MoveDataDTO> orders = [];
      for (final MoveDataDTO order in r) {
        if (order.status == 2) {
          orders.add(order);
        }
      }
      emit(HistoryState.movingHistoryState(pharmacyOrders: orders));
    });
  }

  Future<void> getRefundHistory() async {
    emit(const HistoryState.loadingState());
    final failureOrSuccess = await _getRefundHistory.call();
    failureOrSuccess.fold(
        (l) => emit(HistoryState.errorState(message: mapFailureToMessage(l))),
        (r) {
      final List<RefundDataDTO> orders = [];
      for (final RefundDataDTO order in r) {
        if (order.status == 2) {
          orders.add(order);
        }
      }
      emit(HistoryState.refundHistoryState(pharmacyOrders: orders));
    });
  }
}
