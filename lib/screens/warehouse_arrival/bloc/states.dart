part of 'bloc_stock_arrival.dart';

@immutable
abstract class StateBlocStockArrival {}

class StateStockArrivalLoading extends StateBlocStockArrival {}

class StateStockArrivalLoadData extends StateBlocStockArrival {
  final List<DTOOrderDetails> orderDetails;

  StateStockArrivalLoadData({
    required this.orderDetails,
  });
}
