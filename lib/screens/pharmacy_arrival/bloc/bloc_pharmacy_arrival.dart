import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../network/models/dto_models/response/dto_order_details_response.dart';

part 'events.dart';
part 'states.dart';
part 'parts/_read.dart';

class BlocPharmacyArrival extends Bloc<EventBlocPharmacyArrival, StateBlocPharmacyArrival> {
  BlocPharmacyArrival() : super(StatePharmacyArrivalLoading()) {
    on<EventReadPharmacyArrival>(_read);
  }
}
