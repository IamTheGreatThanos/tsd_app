part of "../bloc_pharmacy_arrival.dart";

extension Read on BlocPharmacyArrival {
  Future<void> _read(EventReadPharmacyArrival event,
      Emitter<StateBlocPharmacyArrival> emit) async {
    try {
      emit(StatePharmacyArrivalLoading());
      List<DTOOrderDetails> orders = [
        DTOOrderDetails(
            orderName: "№. 1 ANG-0277112",
            containerCount: 84,
            createdAt: DateTime(2021, 11, 17, 14, 19),
            stockName: "Склад №12 Толе би"),
        DTOOrderDetails(
            orderName: "№. 2 | ANG-0384",
            containerCount: 84,
            createdAt: DateTime(2021, 11, 17, 14, 19),
            stockName: "Склад №12 Толе би",
            isActive: false),
        DTOOrderDetails(
            orderName: "№. 3 ANG-01233",
            containerCount: 84,
            createdAt: DateTime(2021, 11, 17, 14, 19),
            stockName: "Склад №12 Толе би"),
        DTOOrderDetails(
            orderName: "№. 4 ANG-5672",
            containerCount: 84,
            createdAt: DateTime(2021, 11, 17, 14, 19),
            stockName: "Склад №12 Толе би",
            isActive: false),
        DTOOrderDetails(
            orderName: "№. 5 ANG-9354",
            containerCount: 84,
            createdAt: DateTime(2021, 11, 17, 14, 19),
            stockName: "Склад №12 Толе би",
            isActive: false),
        DTOOrderDetails(
            orderName: "№. 6 ANG-018745",
            containerCount: 84,
            createdAt: DateTime(2021, 11, 17, 14, 19),
            stockName: "Склад №12 Толе би"),
        DTOOrderDetails(
            orderName: "№. 7 ANG-17966",
            containerCount: 84,
            createdAt: DateTime(2021, 11, 17, 14, 19),
            stockName: "Склад №12 Толе би",
            isActive: false),
        DTOOrderDetails(
            orderName: "№. 8 ANG-178563",
            containerCount: 84,
            createdAt: DateTime(2021, 11, 17, 14, 19),
            stockName: "Склад №12 Толе би"),
        DTOOrderDetails(
            orderName: "№. 9 ANG-109613",
            containerCount: 84,
            createdAt: DateTime(2021, 11, 17, 14, 19),
            stockName: "Склад №12 Толе би",
            isActive: false),
        DTOOrderDetails(
            orderName: "№. 10 ANG-95662",
            containerCount: 84,
            createdAt: DateTime(2021, 11, 17, 14, 19),
            stockName: "Склад №12 Толе би",
            isActive: false),
        DTOOrderDetails(
            orderName: "№. 11 ANG-49892",
            containerCount: 84,
            createdAt: DateTime(2021, 11, 17, 14, 19),
            stockName: "Склад №12 Толе би"),
      ];
      await Future.delayed(Duration(seconds: 3))
          .then((value) => emit(StatePharmacyArrivalLoadData(
                orderDetails: orders,
              )));
    } catch (e) {}
  }
}
