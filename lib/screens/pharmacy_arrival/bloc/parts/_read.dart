part of "../bloc_pharmacy_arrival.dart";

extension Read on BlocPharmacyArrival {
  Future<void> _read(EventReadPharmacyArrival event,
      Emitter<StateBlocPharmacyArrival> emit) async {
    try {
      emit(StatePharmacyArrivalLoading());
      List<DTOOrderDetails> orders = [];
      for (int i = 0; i < 15; i++) {
        orders.add(
          DTOOrderDetails(
              orderName: "№.${i + 1} ANG-49892",
              containerCount: Random().nextInt(140),
              isActive: Random().nextBool(),
              createdAt: DateTime.now().subtract(Duration(
                days: Random().nextInt(180),
                hours: Random().nextInt(180),
                minutes: Random().nextInt(180),
                seconds: Random().nextInt(180),
              )),
              addressFrom: "Сулейманова 32",
              cityFrom: "г. Тараз",
              addressTo: "Шевченко 90",
              cityTo: "г. Алматы",
              sender: "Aqniet Group"),
        );
      }
      await Future.delayed(Duration(seconds: 1))
          .then((value) => emit(StatePharmacyArrivalLoadData(
                orderDetails: orders,
              )));
    } catch (e) {}
  }
}
