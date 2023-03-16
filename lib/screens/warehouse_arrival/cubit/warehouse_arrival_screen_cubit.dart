import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/warehouse_usecases/get_warehouse_arrival_orders.dart';
import 'package:pharmacy_arrival/domain/usecases/warehouse_usecases/update_warehouse_order_status.dart';

part 'warehouse_arrival_screen_state.dart';
part 'warehouse_arrival_screen_cubit.freezed.dart';

class WarehouseArrivalScreenCubit extends Cubit<WarehouseArrivalScreenState> {
  List<WarehouseOrderDTO> _activeOrders = [];
  int _currentPage = 1;
  final GetWarehouseArrivalOrders _getWarehouseArrivalOrders;
  final UpdateWarehouseOrderStatus _updateWarehouseOrderStatus;
  WarehouseArrivalScreenCubit(
    this._getWarehouseArrivalOrders,
    this._updateWarehouseOrderStatus,
  ) : super(const WarehouseArrivalScreenState.initialState());

  Future<void> getOrdersBySearch({
    required String number,
    required int status,
  }) async {
    emit(const WarehouseArrivalScreenState.loadingState());
    final result = await _getWarehouseArrivalOrders.call(
      GetWarehouseArrivalOrdersParams(
        searchText: number,
        status: status,
        page: 1,
      ),
    );
    result.fold(
      (l) => emit(
        WarehouseArrivalScreenState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) => emit(WarehouseArrivalScreenState.bySearch(orders: r)),
    );
  }

  Future<void> onRefreshOrders({
    required int status,
  }) async {
    _currentPage = 1;
    emit(const WarehouseArrivalScreenState.loadingState());
    final result = await _getWarehouseArrivalOrders.call(
      GetWarehouseArrivalOrdersParams(page: _currentPage, status: status),
    );
    result.fold(
      (l) => emit(
        WarehouseArrivalScreenState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) {
        log("ON REFRESH:: , page:: $_currentPage,");
        _currentPage++;
        _activeOrders = [];
        for (final WarehouseOrderDTO orderDTO in r) {
          if (orderDTO.status == 1 || orderDTO.status == 2) {
            _activeOrders.add(orderDTO);
          }
        }
        emit(WarehouseArrivalScreenState.loadedState(orders: _activeOrders));
      },
    );
  }

  Future<void> onLoadOrders({required int status}) async {
    final result = await _getWarehouseArrivalOrders.call(
      GetWarehouseArrivalOrdersParams(page: _currentPage, status: status),
    );
    result.fold(
      (l) => emit(
        WarehouseArrivalScreenState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) {
        final List<WarehouseOrderDTO> loadOrders = [];
        log("ON LOADING:: , page:: $_currentPage");
        if (r.isNotEmpty) {
          _currentPage++;
        }
        for (final WarehouseOrderDTO orderDTO in r) {
          if (orderDTO.status == 1 || orderDTO.status == 2) {
            loadOrders.add(orderDTO);
          }
        }
        _activeOrders += loadOrders;
        emit(WarehouseArrivalScreenState.loadedState(orders: _activeOrders));
      },
    );
  }

  Future<void> updateOrderStatus({
    required int orderId,
    required int status,
  }) async {
    emit(const WarehouseArrivalScreenState.loadingState());
    final result = await _updateWarehouseOrderStatus.call(
      UpdateWarehouseOrderStatusParams(orderId: orderId, status: status),
    );

    result.fold(
      (l) {
        emit(
          WarehouseArrivalScreenState.errorState(
            message: mapFailureToMessage(l),
          ),
        );
      },
      (r) {
        log('SUCCESS UPDATED STATUS: ${r.status}');
      },
    );
    await onRefreshOrders(status: 1);
  }
}
