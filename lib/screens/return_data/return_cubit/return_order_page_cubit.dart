import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_arrival_orders.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_refund_order_by_incoming.dart';

part 'return_order_page_state.dart';
part 'return_order_page_cubit.freezed.dart';

class ReturnOrderPageCubit extends Cubit<ReturnOrderPageState> {
  List<PharmacyOrderDTO> _activeOrders = [];
  int _currentPage = 1;
  final GetPharmacyArrivalOrders _getPharmacyArrivalOrders;
  final GetRefundOrderByIncoming _getRefundOrderByIncoming;
  ReturnOrderPageCubit(
    this._getPharmacyArrivalOrders,
    this._getRefundOrderByIncoming,
  ) : super(const ReturnOrderPageState.initialState());

  Future<void> getOrdersBySearch({
    String? incomingDate,
    String? incomingNumber,
  }) async {
    emit(const ReturnOrderPageState.loadingState());
    final result = await _getRefundOrderByIncoming.call(
      GetRefundOrderByIncomingParams(
        incomingDate: incomingDate,
        incomingNumber: incomingNumber,
      ),
    );
    result.fold(
      (l) => emit(
        ReturnOrderPageState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) => emit(ReturnOrderPageState.byFilterState(orders: r)),
    );
  }

  Future<void> onRefreshOrders({
    required int refundStatus,
    String? number,
    int? senderId,
    String? departureDate,
    int? sortType,
    String? amountStart,
    String? amountEnd,
    String? incomingDate,
    String? incomingNumber,
  }) async {
    _currentPage = 1;
    emit(const ReturnOrderPageState.loadingState());
    final result = await _getPharmacyArrivalOrders.call(
      GetPharmacyArrivalOrdersParams(
        number: number,
        page: _currentPage,
        status: 3,
        incomingDate: incomingDate,
        incomingNumber: incomingNumber,
        refundStatus: refundStatus,
        senderId: senderId,
        departureDate: departureDate,
        sortType: sortType,
        amountEnd: amountEnd,
        amountStart: amountStart,
      ),
    );
    result.fold(
      (l) => emit(
        ReturnOrderPageState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) {
        log("ON REFRESH:: , page:: $_currentPage,");
        _currentPage++;
        _activeOrders = [];
        _activeOrders += r;
        emit(ReturnOrderPageState.loadedState(orders: _activeOrders));
      },
    );
  }

  Future<void> onLoadOrders({
    required int refundStatus,
    String? number,
    int? senderId,
    String? departureDate,
    int? sortType,
    String? amountStart,
    String? amountEnd,
    String? incomingDate,
    String? incomingNumber,
  }) async {
    final result = await _getPharmacyArrivalOrders.call(
      GetPharmacyArrivalOrdersParams(
        number: number,
        page: _currentPage,
        refundStatus: refundStatus,
        status: 3,
        incomingDate: incomingDate,
        incomingNumber: incomingNumber,
        senderId: senderId,
        departureDate: departureDate,
        sortType: sortType,
        amountEnd: amountEnd,
        amountStart: amountStart,
      ),
    );
    result.fold(
      (l) => emit(
        ReturnOrderPageState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) {
        // List<PharmacyOrderDTO> _loadOrders = [];
        log("ON LOADING:: , page:: $_currentPage");
        if (r.isNotEmpty) {
          _currentPage++;
        }
        // for (final PharmacyOrderDTO orderDTO in r) {
        //   if (orderDTO.status == 1 || orderDTO.status == 2) {
        //     _loadOrders.add(orderDTO);
        //   }
        // }
        _activeOrders += r;
        emit(ReturnOrderPageState.loadedState(orders: _activeOrders));
      },
    );
  }
}
