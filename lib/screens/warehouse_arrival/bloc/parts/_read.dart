part of "../bloc_stock_arrival.dart";

extension Read on BlocStockArrival {
  Future<void> _read(
    EventReadStockArrival event,
    Emitter<StateBlocStockArrival> emit,
  ) async {
    try {
      emit(StateStockArrivalLoading());
      List<DTOOrderDetails> orders = [];
      for (int i = 0; i < 15; i++) {
        orders.add(
          DTOOrderDetails(
            orderName: "№.${i + 1} ANG-49892",
            containerCount: Random().nextInt(140),
            isActive: Random().nextBool(),
            createdAt: DateTime.now().subtract(
              Duration(
                days: Random().nextInt(180),
                hours: Random().nextInt(180),
                minutes: Random().nextInt(180),
                seconds: Random().nextInt(180),
              ),
            ),
            stockName: "Склад №12 Толе би",
          ),
        );
      }
      await Future.delayed(Duration(seconds: 3)).then(
        (value) => emit(
          StateStockArrivalLoadData(
            orderDetails: orders,
          ),
        ),
      );
    } catch (e) {}
  }
}
