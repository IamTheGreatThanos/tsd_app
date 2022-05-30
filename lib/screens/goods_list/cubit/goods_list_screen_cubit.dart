import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_products_pharmacy_arrival.dart';

part 'goods_list_screen_state.dart';

part 'goods_list_screen_cubit.freezed.dart';

class GoodsListScreenCubit extends Cubit<GoodsListScreenState> {
  List<ProductDTO> allProducts = [];
  List<ProductDTO> unscannedProducts = [];
  List<ProductDTO> scannedProdcuts = [];
  final GetProductsPharmacyArrival _getProductsPharmacyArrival;

  GoodsListScreenCubit(
    this._getProductsPharmacyArrival,
  ) : super(const GoodsListScreenState.initialState());

  Future<void> getProducts(int orderId) async {
    emit(const GoodsListScreenState.loadingState());
    final result = await _getProductsPharmacyArrival.call(orderId);
    result.fold(
        (l) => emit(
              GoodsListScreenState.errorState(message: mapFailureToMessage(l)),
            ), (r) {
      allProducts = r;
      for (final ProductDTO product in r) {
        if (product.status == '1') {
          unscannedProducts.add(product);
        } else {
          scannedProdcuts.add(product);
        }
      }
      emit(
        GoodsListScreenState.loadedState(
          scannedProducts: scannedProdcuts,
          unscannedProducts: unscannedProducts,
        ),
      );
    });
  }
}
