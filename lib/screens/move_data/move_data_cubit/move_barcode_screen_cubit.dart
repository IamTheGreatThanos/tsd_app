import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';

part 'move_barcode_screen_state.dart';
part 'move_barcode_screen_cubit.freezed.dart';

class MoveBarcodeScreenCubit extends Cubit<MoveBarcodeScreenState> {
  MoveBarcodeScreenCubit() : super(const MoveBarcodeScreenState.initialState());

  Future<void> getProductByBarcode({required String barcode})async{
    
  }
}
