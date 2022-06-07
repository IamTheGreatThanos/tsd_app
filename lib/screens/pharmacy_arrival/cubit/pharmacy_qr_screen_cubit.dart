import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_order_by_number.dart';

part 'pharmacy_qr_screen_state.dart';
part 'pharmacy_qr_screen_cubit.freezed.dart';

class PharmacyQrScreenCubit extends Cubit<PharmacyQrScreenState> {
  final GetOrderByNumber _getOrderByNumber;
  PharmacyQrScreenCubit(this._getOrderByNumber)
      : super(const PharmacyQrScreenState.initialState());

  Future<void> getOrderByNumber({required String number}) async {
    emit(const PharmacyQrScreenState.loadingState());
    final result = await _getOrderByNumber.call(number);
    result.fold(
        (l) => emit(
              PharmacyQrScreenState.errorState(message: mapFailureToMessage(l)),
            ), (r) {
      emit(PharmacyQrScreenState.loadedState(order: r));
    });
  }
}
