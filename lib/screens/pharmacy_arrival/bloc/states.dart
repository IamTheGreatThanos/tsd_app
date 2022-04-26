part of 'bloc_pharmacy_arrival.dart';

@immutable
abstract class StateBlocPharmacyArrival {}

class StatePharmacyArrivalLoading extends StateBlocPharmacyArrival {}

class StatePharmacyArrivalLoadData extends StateBlocPharmacyArrival {
  final List<DTOOrderDetails> orderDetails;

  StatePharmacyArrivalLoadData({
    required this.orderDetails,
  });
}
