import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_arrival_orders.dart';

part 'pharmacy_arrival_screen_state.dart';
part 'pharmacy_arrival_screen_cubit.freezed.dart';

class PharmacyArrivalScreenCubit extends Cubit<PharmacyArrivalScreenState> {
 final GetPharmacyArrivalOrders _getPharmacyArrivalOrders;
  PharmacyArrivalScreenCubit(this._getPharmacyArrivalOrders)
      : super(const PharmacyArrivalScreenState.initialState());

  Future<void> getOrders() async {
    emit(const PharmacyArrivalScreenState.loadingState());
    final result = await _getPharmacyArrivalOrders.call();
    result.fold(
      (l) => emit(
        PharmacyArrivalScreenState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) => emit(PharmacyArrivalScreenState.loadedState(orders: r)),
    );
  }
}
