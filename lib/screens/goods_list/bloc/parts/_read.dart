part of "../bloc_goods_list.dart";

extension Read on BlocGoodsList {
  Future<void> _read(
      EventInitialGoodsList event, Emitter<StateBlocGoodsList> emit) async {
    if (goods.isEmpty) {
      List<GoodDetails> goods = [];
      for (int i = 0; i < 3; i++) {
        goods.add(
          GoodDetails(
            image:
                "assets/images/png/goos_sample_${Random().nextBool() ? "1" : "2"}.png",
            title:
                "${Random().nextBool() ? "Акнекутан капс. 16мг №30" : "Оптинол Глубокое увлажнение 0,4% 10мл"}",
            company: "Jadran",
            count: Random().nextInt(250),
            number: getRandomString(5).toUpperCase(),
            price: Random().nextInt(20000),
          ),
        );
      }
      this.goods = goods;
    }
    emit(StateGoodsListLoadData(
        goods: GoodsResponse(goods: goods, scannedGoods: scannedGoods)));
  }
}

String getRandomString(int length) {
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
