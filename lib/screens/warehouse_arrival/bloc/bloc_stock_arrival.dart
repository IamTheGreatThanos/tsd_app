import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../network/models/dto_models/response/dto_order_details_response.dart';

part 'events.dart';
part 'states.dart';
part 'parts/_read.dart';
class BlocStockArrival extends Bloc<EventBlocStockArrival, StateBlocStockArrival> {
  BlocStockArrival() : super(StateStockArrivalLoading()) {
    on<EventReadStockArrival>(_read);

  }
}
