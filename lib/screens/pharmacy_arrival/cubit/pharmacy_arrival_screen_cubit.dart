import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_orders_by_search.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_arrival_orders.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/update_pharmacy_order_status.dart';

part 'pharmacy_arrival_screen_state.dart';
part 'pharmacy_arrival_screen_cubit.freezed.dart';

class PharmacyArrivalScreenCubit extends Cubit<PharmacyArrivalScreenState> {
  List<PharmacyOrderDTO> _activeOrders = [];
  int _currentPage = 1;
  final GetPharmacyArrivalOrders _getPharmacyArrivalOrders;
  final UpdatePharmacyOrderStatus _updatePharmacyOrderStatus;
  final GetOrdersBySearch _getOrdersBySearch;
  PharmacyArrivalScreenCubit(
    this._getPharmacyArrivalOrders,
    this._updatePharmacyOrderStatus,
    this._getOrdersBySearch,
  ) : super(const PharmacyArrivalScreenState.initialState());

  Future<void> getOrdersBySearch({
    required String number,
    required int status,
  }) async {
    emit(const PharmacyArrivalScreenState.loadingState());
    final result = await _getOrdersBySearch.call(
      GetOrdersBySearchParams(
        number: number,
        status: status,
      ),
    );
    result.fold(
      (l) => emit(
        PharmacyArrivalScreenState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) => emit(PharmacyArrivalScreenState.bySearch(products: r)),
    );
  }

  Future<void> onRefreshOrders({
    required int status,
    String? number,
    int? senderId,
    String? departureDate,
    int? sortType,
    String? amountStart,
    String? amountEnd,
  }) async {
    _currentPage = 1;
    emit(const PharmacyArrivalScreenState.loadingState());
    final result = await _getPharmacyArrivalOrders.call(
      GetPharmacyArrivalOrdersParams(
        number: number,
        page: _currentPage,
        status: status,
        senderId: senderId,
        departureDate: departureDate,
        sortType: sortType,
        amountEnd: amountEnd,
        amountStart: amountStart,
      ),
    );
    result.fold(
      (l) => emit(
        PharmacyArrivalScreenState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) {
        log("ON REFRESH:: , page:: $_currentPage,");
        _currentPage++;
        _activeOrders = [];
        for (final PharmacyOrderDTO orderDTO in r) {
          if (orderDTO.status == 1 || orderDTO.status == 2) {
            _activeOrders.add(orderDTO);
          }
        }
        emit(PharmacyArrivalScreenState.loadedState(orders: _activeOrders));
      },
    );
  }

  Future<void> onLoadOrders({
    required int status,
    String? number,
    int? senderId,
    String? departureDate,
    int? sortType,
    String? amountStart,
    String? amountEnd,
  }) async {
    final result = await _getPharmacyArrivalOrders.call(
      GetPharmacyArrivalOrdersParams(
        number: number,
        page: _currentPage,
        status: status,
        senderId: senderId,
        departureDate: departureDate,
        sortType: sortType,
        amountEnd: amountEnd,
        amountStart: amountStart,
      ),
    );
    result.fold(
      (l) => emit(
        PharmacyArrivalScreenState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) {
        final List<PharmacyOrderDTO> loadOrders = [];
        log("ON LOADING:: , page:: $_currentPage");
        if (r.isNotEmpty) {
          _currentPage++;
        }
        for (final PharmacyOrderDTO orderDTO in r) {
          if (orderDTO.status == 1 || orderDTO.status == 2) {
            loadOrders.add(orderDTO);
          }
        }
        _activeOrders += loadOrders;
        emit(PharmacyArrivalScreenState.loadedState(orders: _activeOrders));
      },
    );
  }

  Future<void> updateOrderStatus({
    required int orderId,
    required int status,
    required int totalStatus,
  }) async {
    emit(const PharmacyArrivalScreenState.loadingState());
    final result = await _updatePharmacyOrderStatus.call(
      UpdatePharmacyOrderStatusParams(
        orderId: orderId,
        status: status,
        totalStatus: totalStatus,
      ),
    );

    result.fold(
      (l) {
        emit(
          PharmacyArrivalScreenState.errorState(
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
