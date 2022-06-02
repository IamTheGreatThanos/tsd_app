import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_move_data_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_move_products_from_cache.dart';

part 'return_state.dart';
part 'return_cubit.freezed.dart';

class ReturnCubit extends Cubit<ReturnState> {
  ReturnCubit()
      : super(const ReturnState.initialState());

  Future<void> checkReturnDataOrder() async {
    emit(const ReturnState.loadingState());

  }
}
