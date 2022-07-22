import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_move_data_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_move_products_from_cache.dart';

part 'move_state.dart';
part 'move_cubit.freezed.dart';

class MoveCubit extends Cubit<MoveState> {
  final GetMoveDataFromCache _getMoveDataFromCache;
  final GetMoveProductsFromCache _getMoveProductsFromCache;
  MoveCubit(this._getMoveDataFromCache, this._getMoveProductsFromCache)
      : super(const MoveState.initialState());

  // Future<void> checkMoveDataOrder() async {
  //   List<ProductDTO> products = [];
  //   emit(const MoveState.loadingState());
  //   final result = await _getMoveDataFromCache.call();
  //   result.fold(
  //     (l) => emit(const MoveState.passiveState()),
  //     (r) async {
  //       final failureOrSuccess = await _getMoveProductsFromCache.call();
  //       failureOrSuccess.fold(
  //         (l) =>
  //             emit(MoveState.activeState(moveDataDTO: r, products: products)),
  //         (rArray) {
  //           products = rArray;
  //           emit(MoveState.activeState(moveDataDTO: r, products: products));
  //         },
  //       );
  //     },
  //   );
  // }
}
